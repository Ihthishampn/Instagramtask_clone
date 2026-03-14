import 'dart:async';
import 'package:flutter/widgets.dart';

/// Singleton cache for intrinsic image sizes keyed by URL.
class ImageSizeCache {
  ImageSizeCache._();
  static final ImageSizeCache instance = ImageSizeCache._();

  final Map<String, Size> _cache = {};

  Size? get(String url) => _cache[url];

  /// Prefetch intrinsic sizes for the provided URLs.
  /// This resolves each image via [ImageProvider] and stores its width/height.
  Future<void> prefetch(List<String> urls) async {
    final unique = urls.where((u) => u.isNotEmpty).toSet().toList();
    for (final url in unique) {
      if (_cache.containsKey(url)) continue;
      await _resolveAndStore(url);
    }
  }

  Future<void> _resolveAndStore(String url) async {
    try {
      final provider = NetworkImage(url);
      final completer = Completer<void>();
      final stream = provider.resolve(const ImageConfiguration());
      late ImageStreamListener listener;

      listener = ImageStreamListener(
        (imageInfo, _) {
          final w = imageInfo.image.width.toDouble();
          final h = imageInfo.image.height.toDouble();
          if (w > 0 && h > 0) {
            _cache[url] = Size(w, h);
          }
          try {
            stream.removeListener(listener);
          } catch (_) {}
          if (!completer.isCompleted) completer.complete();
        },
        onError: (e, s) {
          try {
            stream.removeListener(listener);
          } catch (_) {}
          if (!completer.isCompleted) completer.complete();
        },
      );

      stream.addListener(listener);
      await completer.future;
    } catch (_) {
      // ignore
    }
  }
}
