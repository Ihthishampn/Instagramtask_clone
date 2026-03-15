import 'dart:async';
import 'package:flutter/widgets.dart';

class ImageSizeCache {
  ImageSizeCache._();
  static final ImageSizeCache instance = ImageSizeCache._();

  final Map<String, Size> _cache = {};

  Size? get(String url) => _cache[url];


  Future<void> prefetch(List<String> urls) async {
    final unique = urls.where((u) => u.isNotEmpty).toSet().toList();

    final tasks = <Future<void>>[];
    for (final url in unique) {
      if (_cache.containsKey(url)) continue;
      tasks.add(_resolveAndStore(url));
    }
    if (tasks.isNotEmpty) {
      await Future.wait(tasks);
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
      //
    }
  }
}
