# mobile_app_test

A new Flutter project for flutter version 3.27.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

##Project summary
-The project is intended for Flutter mobile app (Android/iOS).
-Firebase has been properly configured with:
-Google Sign-In enabled.
-Correct google-services.json and GoogleService-Info.plist files in place.
-The app uses only Google Sign-In for authentication

##Improvements Made
-Implemented Google Sign-In authentication
-Enable automatic user session persistence
-Provider using statmangemnt

##How to Test the Project on a New Machine
1.Clone the Repository for this url : https://github.com/Dimmithra/mobile_app_testing.git
2.Install Dependencies
3.test the Firebase configurations
4.Run the App

##Test Scenarios
Fresh intallation -> navigate to login screen
Launch App -> Check the deveice alrady singIn then navigate to Home page.
TapLogout -> confirmation dialog → returns to Login screen.
google Map -> seletc map icon navigate to selected logatude and latitude to correct loaction
Broken image URL → fallback asset image is shown.
