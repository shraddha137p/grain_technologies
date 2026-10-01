# Grain Machine Test

A Flutter application with Firebase email/password authentication and a paginated user list backed by the ReqRes API. GetX is used for navigation, dependency injection, and reactive state management.

## Requirements

- Flutter SDK with Dart `3.11` or later, as required by `pubspec.yaml`
- A Firebase project with Email/Password authentication enabled
- Android or iOS toolchain configured for Flutter

## Setup

1. Clone the repository and open its root directory.
2. Install Dart and Flutter dependencies:

	```bash
	flutter pub get
	```

3. Configure Firebase for the platforms you intend to run:

	```bash
	dart pub global activate flutterfire_cli
	flutterfire configure
	```

	Ensure `lib/firebase_options.dart` contains the configuration for the selected Firebase project. Add the platform-specific Firebase files required by FlutterFire (for example, `google-services.json` for Android and `GoogleService-Info.plist` for iOS), and enable **Email/Password** under Firebase Authentication providers.

4. Start the application on a connected device or emulator:

	```bash
	flutter run
	```

## Useful Commands

```bash
flutter analyze
flutter test
flutter run
```

## Architecture

The app separates screen rendering, application state, data access, and external services:

```text
Views -> GetX Controllers -> Repositories -> Services -> Firebase / ReqRes API
							  \\-> Models (parsed response data)
```

- **App startup and routing:** `lib/main.dart` initializes Firebase and checks the restored authentication state. Authenticated users start at the user list; signed-out users start at the welcome screen. `lib/core/routes/app_pages.dart` declares GetX routes.
- **Bindings:** `lib/views/auth/auth_binding.dart` and `lib/views/users/user_binding.dart` register controllers and their dependencies for each route.
- **Views:** `lib/views/auth/` contains the welcome, login, and registration screens. `lib/views/users/` contains the user list and its widgets.
- **Controllers:** `lib/viewmodels/auth_controller.dart` coordinates authentication and navigation. `lib/viewmodels/user_controller.dart` owns the observable user list, refresh state, scroll-based pagination, and loading/error state.
- **Repositories:** `lib/repositories/` separates controllers from API/auth implementation details and converts API responses into models.
- **Services:** `lib/services/firebase_auth_service.dart` handles Firebase Authentication. `lib/services/api_service.dart` makes ReqRes HTTP requests using Dio.
- **Models:** `lib/models/` defines user data and parses the paginated API response, including `page`, `per_page`, and `total_pages`.
- **Shared UI and assets:** `lib/core/` contains routes, theme, utilities, and reusable widgets; `assets/` contains images and fonts.

### User list data flow

`UserListScreen` renders the observable data with `ListView.builder`. `UserController` requests five users per page through `UserRepository`; `ApiService` sends the page parameters to ReqRes. The response model supplies the current and total page values. Pull-to-refresh reloads page 1, and scrolling near the list end requests the next page.

## External Configuration

- Firebase project settings and platform configuration files are required for authentication.
- The ReqRes base URL and request headers are configured in `lib/services/api_service.dart`. Update them there if the API configuration changes.
