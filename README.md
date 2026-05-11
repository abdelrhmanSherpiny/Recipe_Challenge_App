# Recipe Challenge App 

A modern, comprehensive Flutter recipe application designed to help users master their cooking skills through challenges, time tracking, and a curated list of recipes.

## Features

### Onboarding
- **Interactive 3-Step Flow:** Guides users through the app's value proposition.
- **Personalization:** Collects user name and cooking level (Beginner, Intermediate, Chef).
- **Responsive Design:** Adaptive layout that switches between mobile (stacked) and tablet (side-by-side) views using `LayoutBuilder`.
- **State Persistence:** Remembers if onboarding is completed using `shared_preferences`.

### Home Dashboard
- **Personalized Header:** Greets the user by name and displays their current cooking level.
- **Today's Challenge:** A featured recipe card with a custom gradient overlay and visual details.
- **Random Recipe:** "Roll the dice" feature to suggest a random meal.
- **Recipe Feed:** A scrollable list of recipes featuring:
  - Optimized image loading ( caching & resizing).
  - rich meta-data (Time, Steps, Tags).
  - SVG icons for food types (Meat, Veggie, etc.).

### Favorites System
- **Interactive Toggles:** Users can mark recipes as favorites directly from the list.
- **Dedicated Tab:** A filterable view in the bottom navigation to show only bookmarked recipes.

### UI/UX Design
- **Custom Typography:** Uses *Hedvig Letters Serif* for headings and *Nunito* for body text via `google_fonts`.
- **Dark Theme:** Sleek dark mode aesthetic with consistent color palettes (`#0E1118` background, `#DB7A2B` accents).
- **Visuals:** Extensive use of SVG icons and high-quality image assets.
- **Gradients:** Custom linear gradients for text readability on image backgrounds.

## Tech Stack

- **Framework:** [Flutter](https://flutter.dev/)
- **Language:** [Dart](https://dart.dev/)
- **Navigation:** [auto_route](https://pub.dev/packages/auto_route)
- **State Management:** `setState` (local), `shared_preferences` (persistence)
- **Assets:** [flutter_svg](https://pub.dev/packages/flutter_svg) for vector graphics.
- **Fonts:** [google_fonts](https://pub.dev/packages/google_fonts).

## Project Structure

```
lib/
├── main.dart               # App entry point & configuration
├── app_router.dart         # Navigation routing configuration
├── auth_guard.dart         # Route guard for onboarding check
├── home_screen.dart        # Main dashboard & recipe logic
└── onboarding_screen.dart  # Onboarding flow & logic
assets/
├── images/                 # PNG assets (Food images, backgrounds)
└── icons/                  # SVG icons (UI elements, navigation)
```

## Getting Started

1.  **Prerequisites:**
    - Flutter SDK installed.
    - A connected device or emulator.

2.  **Installation:**
    ```bash
    # Clone the repository (if applicable)
    # git clone ...

    # Install dependencies
    flutter pub get
    ```

3.  **Code Generation (if modifying routes):**
    This project uses `auto_route` which requires code generation.
    ```bash
    dart run build_runner build
    ```

4.  **Run the App:**
    ```bash
    flutter run
    ```
