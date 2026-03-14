# Instagram Feed Clone

A highly polished Flutter replication of the Instagram Home Feed, built as part of a UI/UX challenge.

## Features

- **Pixel-Perfect UI**: Replicates Instagram's top bar, stories tray, and post feed.
- **Image Carousel**: Smooth horizontal scrolling with dot indicators for multi-image posts.
- **Pinch-to-Zoom**: Interactive zoom on images using Flutter's InteractiveViewer.
- **Stateful Interactions**: Like and Save buttons toggle state locally.
- **Infinite Scroll**: Lazy loading of posts when nearing the bottom.
- **Shimmer Loading**: Elegant loading states with shimmer effects.
- **Cached Images**: Uses cached_network_image for efficient image handling.

## Architecture

### State Management
This app uses **Provider** for state management. The `PostProvider` manages the list of posts, loading states, and user interactions (like/save toggles).

### Project Structure
```
lib/
├── models/
│   └── post.dart          # Data models (User, Post, Story)
├── providers/
│   └── post_provider.dart # State management for posts
├── services/
│   ├── post_repository.dart   # Mock data layer for posts
│   └── story_repository.dart  # Mock data for stories
├── screens/
│   └── home_screen.dart       # Main home screen
└── widgets/
    ├── top_bar.dart           # Top navigation bar
    ├── stories_tray.dart      # Stories horizontal list
    ├── post_feed.dart         # List of posts
    ├── post_feed_shimmer.dart  # Loading shimmer
    └── post_item.dart         # Individual post widget
```

### Key Components

- **PostRepository**: Provides mock data with simulated 1.5s delay for loading states.
- **PostProvider**: Handles fetching posts, pagination, and state updates.
- **PostItem**: Complex widget handling image carousel, interactions, and pinch-zoom.

## Running the App

1. Ensure Flutter is installed and set up.
2. Clone the repository.
3. Run `flutter pub get` to install dependencies.
4. Run `flutter run` to launch the app.

## Demo

- **Shimmer Loading**: Initial load shows shimmer effects for 1.5 seconds.
- **Infinite Scroll**: Scroll to the bottom to load more posts.
- **Pinch-to-Zoom**: Pinch on any image to zoom in/out.
- **Interactions**: Tap like/save to toggle state; other buttons show Snackbars.
