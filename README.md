# Instagram Task Clone

A Flutter Project implementation of Instagram's Home Feed and Stories UX. This project demonstrates clean architecture, Provider-based state management, and optimized layout.

## Links

GitHub Repository:      [https://github.com/Ihthishampn/Instagramtask_clone]

Demo Recording (Loom):  [https://www.loom.com/share/edc55dccebf1448a82f5cab14efc0efe]


---

## Overview

This app replicates core Instagram features:
- **Stories Tray & Viewer** — horizontal story list with full-screen viewer, per-page progress bar, and touch controls (pause, resume, swipe).
- **Feed** — paginated post list with headers, multi-image carousels, action rows (like, save, comment, share), and captions.
- **Smooth Interactions** — shimmer loaders, heart animation on like, carousel position persistence, bottom sheet for post more menu.

---

## State Management: Provider (ChangeNotifier)

### Why Provider?

Provider is chosen for its simplicity and tight integration with Flutter's widget model:

- **Lightweight** — minimal overhead; easy to understand and maintain.
- **Fine-grained rebuilds** — `context.select()` and `Consumer` only rebuild widgets that observe changed state.
- **Hybrid lifecycle pattern** — controllers that require `TickerProvider` (e.g., `AnimationController` for story progress) stay in widgets; logical state (posts, stories, current indices) lives in `ChangeNotifier` providers. This ensures correct lifecycle management while keeping UI state centralized and testable.

### Key Providers

- **`FeedProvider`** — manages feed posts, carousel positions, and infinite scroll pagination (loads 5 posts per page).
- **`StoriesProvider`** — manages stories list and watched-state tracking.
- **`PostCarouselProvider`** — per-post carousel state; tracks current page index.
- **`StoryViewerProvider`** — small provider for the story viewer's current index (keeps state out of local `setState`).
- **`ToggleChangeProvider`** — manages heart animation state for the like action.
- **`NavigationProvider`** — manages bottom navigation bar selected index.

---

## Architecture

### Folder Structure

```
lib/
├── main.dart                                  # App entry; MultiProvider setup
├── core/
│   ├── theme/theme.dart                       # Material theme (dark mode)
│   ├── constants/
│   │   ├── image.dart                         # Image URLs and asset paths
│   │   └── my_colors.dart                     # Color constants
│   ├── shared/
│   │   ├── ui_helpers.dart                    # Shared utility functions
│   │   └── profile_placeholder.dart           # Default avatar widget
│   └── data/
│       ├── users/users.dart                   # Centralized users list
│       └── users_data/
│           ├── user_3.dart                    # Individual user data (3-8)
│           ├── user_4.dart
│           ├── user_5.dart
│           ├── user_6.dart
│           ├── user_7.dart
│           └── user_8.dart
├── model/
│   ├── feed_post_model.dart                   # FeedPost, User, PostData models
│   ├── user_model.dart                        # UserModel for stories
│   ├── post_model.dart                        # Post model
│   └── zoom_state_model.dart                  # Zoom/pinch state
├── repositories/
│   └── post_repository.dart                   # Data layer (currently mock)
├── providers/
│   ├── feed_provider.dart                     # Feed posts, pagination, carousel positions
│   ├── stories_provider.dart                  # Stories list, watched-state
│   ├── post_carousel_provider.dart            # Per-post carousel state (current page)
│   ├── story_viewer_provider.dart             # Story viewer current index
│   ├── toggle_change_provider.dart            # Heart animation state
│   └── navigation_provider.dart               # Bottom nav state
├── screens/
│   ├── home_screen.dart                       # Main screen with feed & stories
│   └── tabs/
│       ├── feed_tab.dart                      # Feed tab content
│       └── placeholder_screen.dart            # Placeholder for other tabs
└── widgets/
    ├── app_bar/
    │   ├── ig_sliver_app_bar.dart             # Custom Instagram-style top app bar
    │   └── my_icon_button.dart                # Reusable icon button
    ├── navigation/
    │   ├── nav_bar.dart                       # Bottom navigation bar
    │   └── nav_item.dart                      # Individual nav item
    ├── refresh/
    │   └── instagram_refresh_indicator.dart   # Pull-to-refresh widget
    ├── shared/
    │   ├── avatar_image.dart                  # Avatar with network image
    │   └── ring_decoration.dart               # Story ring (gradient/grey)
    ├── posts_container/
    │   ├── post_container.dart                # Post wrapper with double-tap, long-press
    │   ├── post_container_skeleton.dart       # Loading skeleton
    │   ├── post_container_actions.dart        # Action row wrapper
    │   ├── post/
    │   │   ├── post_header.dart               # User info, verified badge, more menu
    │   │   ├── post_carousel.dart             # Multi-image carousel wrapper
    │   │   ├── post_carousel_widget.dart      # PageView + indicator dots
    │   │   ├── post_action_row.dart           # Like, comment, share, save buttons
    │   │   ├── post_details.dart              # Caption, hashtags, timestamp
    │   │   ├── post_more_sheet.dart           # Bottom sheet menu
    │   │   ├── pinch_zoom_overlay.dart        # Pinch-to-zoom widget
    │   │   └── zoom_overlay_widget.dart       # Zoom transformation overlay
    │   └── gestures/
    │       └── smart_scale_recognizer.dart    # Custom gesture recognizer for pinch-zoom
    └── story_tray/
        ├── stories_tray.dart                  # Horizontal stories list + shimmer
        ├── story_viewer.dart                  # Full-screen story viewer (controller lifecycle)
        ├── story_core.dart                    # Story UI (PageView, overlays, gestures)
        ├── story_image.dart                   # Image loader with onImageLoaded callback
        ├── story_header.dart                  # User info, progress bar, close button
        ├── story_footer.dart                  # Input field for send
        ├── story_touch_zones.dart             # Left/right tap zones for navigation
        ├── story_avatar.dart                  # Story avatar in tray (shimmer + image)
        ├── story_item.dart                    # Individual story page
        └── story_constants.dart               # Story UI constants (sizing, timing)
```


## Features in Detail

### Stories Tray
- Horizontal scrollable list of story avatars with gradient rings (unwatched) or grey rings (watched).
- Tap to open full-screen story viewer.
- Avatar refresh on watch state change.

### Story Viewer
- Full-screen PageView with one story per page.
- Single progress bar spanning the width; advances per page.
- Progress pauses on touch down, resumes on touch up.
- Left/right tap zones to navigate; swipe disabled (NeverScrollableScrollPhysics).
- Story completes → auto-advance to next; last story → pop to feed.
- Progress only starts after image fully renders (ImageStreamListener + onImageLoaded).

### Feed
- CustomScrollView with posts as children.
- Infinite scroll — loads more posts when near bottom (80%).
- Carousel position per post is remembered across scroll ups/downs.

### Post Item
- **Header** — user avatar (tappable to open story), username, verified badge, location, more-vert icon.
- **Carousel** — multi-image or single image; swipeable; dot indicators show current page.
- **Double-tap heart** — triggers heart animation and marks post as liked.
- **Action Row** — like, comment, share, save; some show toast/snackbar on tap.
- **More Menu** — bottom sheet with Save, QR Code, Add to Favorites, Unfollow, Why Seeing, Hide, About Account, Report.
- **Details** — caption (expandable if long), hashtags, timestamp, "See translation" link.

### Image Loading
- `CachedNetworkImage` with shimmer placeholder (2-second delay before showing).
- Circular progress indicator during download.
- Error widget shows broken-image icon.
- Pinch-to-zoom overlay for full-screen image viewing.

---

## Run & Build

### Prerequisites

- Flutter SDK (3.10.8+). Install: https://flutter.dev
- Dart SDK (included with Flutter).
- Android emulator, iOS simulator, or physical device.

### Setup & Run

```bash
# Clone the repository
git clone https://github.com/Ihthishampn/Instagramtask_clone.git
cd instagram_task_clone

# Install dependencies
flutter pub get

# Run on default device
flutter run

# Run on a specific device
flutter run -d <device-id>

# List available devices
flutter devices
```

### Build for Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle (for Play Store)
flutter build appbundle --release

# iOS (requires macOS + Xcode)
flutter build ios --release
```

### Static Analysis

```bash
# Run Dart analyzer
flutter analyze

# Format code
dart format lib/
```

---

## Dependencies

Key packages (see `pubspec.yaml` for versions):

- **`provider`** — state management.
- **`cached_network_image`** — efficient image loading and caching.
- **`shimmer`** — loading placeholders.
---



## Contact

For issues, suggestions:
- Open an issue on GitHub: https://github.com/Ihthishampn/Instagramtask_clone/issues
- GitHub: [Ihthishampn](https://github.com/Ihthishampn)

---

**Happy coding!** 🚀
