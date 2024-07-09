# Captain App Requirements

## Overview
Captain App is a Flutter application designed to display Saudi Arabia football league matches, allowing users to sign up, sign in, and authenticate using OTP through Firebase. The app will fetch match details from the All Sports API and provide a match details page where users can bet on the score.

## Features
1. **Firebase Authentication**
   - Sign up
   - Sign in
   - OTP verification

2. **Match Listings**
   - Fetch a list of matches from the All Sports API
   - Display match details
   - Allow users to bet on match scores

## Firebase Integration
To integrate Firebase with the Captain App:
1. **Set up a Firebase project:**
   - Go to the [Firebase Console](https://console.firebase.google.com/)
   - Create a new project and add the Android/iOS app
   - Follow the instructions to add `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files to the Flutter project

2. **Enable Authentication:**
   - Enable Email/Password and Phone Authentication in the Firebase Console

3. **Install Firebase packages in Flutter:**
   - Add the following dependencies to `pubspec.yaml`:
     ```yaml
     dependencies:
            get:
            firebase_core:
            firebase_auth:
            firebase_storage:
            shared_preferences:
            http: 
            smooth_page_indicator: ^1.1.0
            flutter_svg: ^2.0.7
            cloud_firestore:
            flutter_cache_manager: ^3.3.1 
            intl_phone_field: ^3.2.0
            cached_network_image: ^3.3.0
            intl: ^0.18.1
            # flutter_launcher_icons: ^0.13.1
            otp_text_field: ^1.1.3
            shimmer: ^3.0.0
            connectivity_plus: ^5.0.0
            image_picker: ^1.0.4
            google_sign_in: ^6.1.5
            awesome_dialog: ^3.1.0
            animated_text_kit: ^4.2.2
            flutter_rating_bar: ^4.0.1
            auto_size_text: ^3.0.0
            flutter_markdown: ^0.6.18
            flutter_polls: ^0.1.5
            youtube_player_flutter: ^8.1.2
            sign_in_button: ^3.2.0
            url_launcher: ^6.2.2
            lottie: ^3.0.0
     ```

## All Sports API Integration
To integrate All Sports API with the Captain App:
1. **Sign up and get an API key**:
   - Go to [All Sports API](https://allsportsapi.com/)
   - Sign up and get an API key

2. **Store the API key**:
   - Create a file `lib/app/utils/Core/utils/strings.dart`
   - Store the API key in a variable named `allsportsapiKey`

## Directory Structure

CaptainApp/
├── android/
├── ios/
├── lib/
│ ├── app/
│ │ ├── utils/
│ │ │ ├── Core/
│ │ │ │ ├── utils/
│ │ │ │ │ ├── strings.dart
│ │ │ │ │ └── ...
│ │ │ └── ...
│ │ └── ...
│ ├── main.dart
│ └── ...
├── pubspec.yaml
└── ...