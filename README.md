# Unread Reader

An Android app, built with Flutter, that lists your SMS conversations and lets you read them in a chat view, with unread messages highlighted in color. It reads straight from the phone's SMS store, so you can see what's in a thread at a glance. The repo also holds the app's support website, an Angular site hosted on Firebase.

## Features

- **Thread list**: every SMS conversation with the contact's photo and name and how many unread messages it has, with pull-to-refresh (`lib/pages/home.dart`).
- **Conversation view**: the messages in a thread as chat bubbles, with unread ones in color. Each thread loads at most 25 messages (`MESSAGES_LIMIT` in `lib/constants.dart`) to keep loading fast (`lib/pages/message.dart`).
- **Support site** in `web/`: home, support and privacy policy pages.

## How it works

The app uses the `sms` plugin's `SmsQuery` to load all threads and their contacts from the device, which needs the `READ_SMS` permission declared in `android/app/src/main/AndroidManifest.xml`. Because it relies on Android's SMS provider, it only works on Android.

```
lib/
├── main.dart
├── constants.dart          # MESSAGES_LIMIT
├── pages/                  # home (thread list), message (conversation)
├── services/               # SMS helpers, modals, package info
├── models/chat_message.dart
└── common/drawer_widget.dart
web/                        # Angular 8 support site + Firebase hosting config and functions
```

## Tech stack

- Flutter, Dart SDK `>=2.1.0 <3.0.0` (pre-null-safety)
- `sms` for reading threads and contacts, `cached_network_image`, `package_info`, `device_info`
- Support site: Angular 8 with Firebase Hosting and Cloud Functions

## Getting started

### App

Use a Flutter SDK that supports Dart 2.x (the `sms` plugin and this project predate null safety), then run on an Android device or emulator with SMS data:

```sh
flutter pub get
flutter run
```

Grant the SMS permission when asked.

### Support site

```sh
cd web
npm install
npx ng serve      # http://localhost:4200
```
