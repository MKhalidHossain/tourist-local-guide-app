# Kobeur

Kobeur is a Flutter app that connects tourists with locals, enabling travelers to discover local offers, book experiences, and chat in real time while locals manage offers and trips. The app uses GetX for state management and dependency injection, a feature-first structure, and a service/repository layer to keep UI, business logic, and data access cleanly separated.

## Overview

- App name: Kobeur
- Platforms: Android, iOS, Web, macOS, Windows, Linux
- SDK: Flutter with Dart `^3.7.2`
- Version: `2.0.5`
- Architecture: Feature-first + GetX controllers + repositories + services

## Introduction

Kobeur is built around a two-sided experience:

Tourist:
- Discover local offers and experiences
- Search, view details, and book
- Pay securely and manage bookings
- Chat with locals and view trip history

Local:
- Create and manage offers
- Receive and manage bookings
- Chat with tourists
- Track trip status and profile details

## Key Features

- Role-based onboarding and authentication (tourist or local)
- Search and discovery for offers
- Offer details, favorites, and ratings
- Booking flow with confirmation and status tracking
- Payments with Stripe
- Real-time chat via Socket.IO
- Profile management and account settings
- Local storage for tokens and user preferences
- Deep linking support
- Media handling (images and files)

## App Flow (Simplified)

```mermaid
flowchart TD
  A[App Launch] --> B{First Time Install?}
  B -- Yes --> C[Onboarding]
  B -- No --> D{Logged In?}
  C --> D
  D -- No --> E[Auth]
  D -- Yes --> F[Role-Based Home]
  E --> F
  F --> G[Tourist: Home, Search, Booking]
  F --> H[Local: Home, Offers, Trips]
  G --> I[Offer Details]
  I --> J[Booking + Payment]
  H --> K[Manage Offers + Trips]
  F --> L[Chat]
  F --> M[Profile]
```

## Architecture

- State and dependency management: GetX
- Navigation: `GetMaterialApp` and custom bottom navigation
- Networking: `http` + custom `ApiClient`
- Real-time: `socket_io_client`
- Storage: `shared_preferences` and `get_storage`
- Payments: `flutter_stripe`

## Project Structure

```
lib/
  main.dart                        # App entry point
  core/                            # Themes, widgets, constants, services
  feature/                         # Feature modules
    auth/                          # Login, signup, OTP, role selection
    home/                          # Local and tourist home flows
    booking_module/                # Booking and confirmation screens
    trip_module/                   # Trip/booking lists and widgets
    offer/                         # Offer listing and details
    chat/                          # Messaging and chat history
    payment/                       # Stripe payment flows
    profile/                       # Profile and account settings
  helpers/                         # Dependency injection, API client
  navigation/                      # Bottom navigation
  utils/                           # Helpers and shared utilities
assets/
  images/                          # App images
  icons/                           # App icons
```

## Configuration

- API base URL and Socket URL: `lib/core/constants/urls.dart`
- Stripe publishable key: `lib/core/constants/app_constants.dart`
- Google Sign-In client IDs: `lib/core/constants/app_constants.dart`
- App icons: `pubspec.yaml` under `flutter_launcher_icons`

## Getting Started

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Configure backend URLs:
   - Update `baseUrl` and `socketBaseUrl` in `lib/core/constants/urls.dart`.

3. Configure Stripe and Google Sign-In:
   - Update `publishableKey`, `clientId`, and `serverClientId` in `lib/core/constants/app_constants.dart`.
   - Make sure platform-specific configs match your keys.

4. Run the app:
   ```bash
   flutter run
   ```

## Common Commands

- Run tests:
  ```bash
  flutter test
  ```

- Regenerate launcher icons:
  ```bash
  flutter pub run flutter_launcher_icons
  ```

## Development Notes

- Dependency injection setup: `lib/helpers/dependency_injection.dart`
- API client and request handling: `lib/helpers/remote/data/api_client.dart`
- Role-based navigation: `lib/navigation/bottom_navigationber_screen.dart`

## Security and Secrets

Do not commit real API keys or production credentials. Move sensitive values to environment-specific builds or secure secret management.
=======
# turist_and_local_service

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Language](https://img.shields.io/badge/Dart-96.9%25-blue)](https://dart.dev/)

## Overview

**for_turist_and_local_service** is a cross-platform application designed to bridge the gap between tourists and local service providers. Developed primarily in Dart with Flutter, the app aims to offer a seamless experience for travelers seeking local services, attractions, and assistance, while empowering local businesses to reach potential customers.

## Features

- **Service Discovery:** Easily search for local attractions, services, restaurants, guides, and more.
- **Location-Based Results:** Find nearby services and businesses tailored to your current location.
- **Business Listings:** Local businesses can register and showcase their offerings to tourists and residents.
- **Booking & Reservations:** Integrated system for booking guides, transport, and other services.
- **Reviews & Ratings:** Leave and read feedback to ensure quality and trust between users and service providers.
- **Multi-language Support:** Usable by tourists from various backgrounds and regions.

## Technology Stack

| Language      | Usage                        | Percentage |
|---------------|-----------------------------|------------|
| Dart          | Flutter development, core app| 96.9%      |
| C++           | Native plugins/extensions    | 1.4%       |
| CMake         | Build configuration          | 1.1%       |
| Swift         | iOS-specific modules         | 0.2%       |
| Ruby          | Scripting/CI/CD, automation  | 0.2%       |
| C             | Native integration           | 0.1%       |
| Other         | Miscellaneous support files  | 0.1%       |

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)

### Installation

1. **Clone the repository:**
    ```bash
    git clone https://github.com/MKhalidHossain/for_turist_and_local_service.git
    cd for_turist_and_local_service
    ```

2. **Install dependencies:**
    ```bash
    flutter pub get
    ```

3. **Run the app:**
    ```bash
    flutter run
    ```

   > You can run on Android, iOS, or web platforms, based on your setup.

## Contributing

Contributions are welcome! To contribute:

1. Fork this repository.
2. Create a feature branch (`git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Create a Pull Request describing your changes.

Please read the [CONTRIBUTING.md](CONTRIBUTING.md) for more details.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- Flutter Community
- Open source contributors
- Local business partners and testers

---
