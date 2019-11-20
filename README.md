# Feedme Mobile Client

The mobile client for feedme is written using Google's Flutter Framework and the Dart Language. Dart is a C++ / Java like Object Oriented language developed by Google. Flutter is a cross platform development SDK for mobile applications. Unlike other cross-platform SDKs (i.e. Xamarin and React Native), Flutter (and by extension Dart) compiles into native C++ code which implements a highly efficient canvas to which the app draws its GUI in real time. Flutter was chosen for its advertised ease of development and growing popularity. It is a very elegant Framework, but it is not yet as widely supported as native development and other older frameworks. 

## Build Instructions

To run this client locally, you need to have the following software installations:

* Android Studio / Xcode (depending on whether you want to run on Android or iOS) **NOTE**: You cannot run the iOS platform version on a computer not running macOS.
    - **For Android:** you need _build tools v28.03_ and _Android SDK 28_. Easiest way to do this through (Android Studio)[https://developer.android.com/studio/install], however, you can also go the terminal route and [install the Android SDK manually](https://developer.android.com/studio/index.html#command-tools).
    - **For Xcode:** make sure you install developer tools (`xcode-select --install`) and agree to the terms of use by openning Xcode once
* A device to deploy the code to. This may be a physical device (only the Android build supports deploying to a physical device as of right now given Apple's tight restrictions) or an Emulator.
    - An Android Emulator is pretty easy to install (it's called AVD) and can be installed either through [Android Studio](https://developer.android.com/studio/run/managing-avds) or the [Command Line](https://stackoverflow.com/questions/4974568/how-do-i-launch-the-android-emulator-from-the-command-line)
        * Another Note: you have to install a AVD image via the SDK manager. I recommend a generic Pixel device running Android 28 (Oreo)
    - Apple's iPhone Simulator comes pre-installed with XCode. You can launch it via Spotlight by typing in "Simulator" and selecting a device (only iPhone 6 or later are compatible with Flutter apps as they are 64-bit systems).
* The Flutter Framework:
    - [Use this link for a guide to installing flutter on your machine and OS.](https://flutter.dev/docs/get-started/install)
* For development you can use an IDE like XCode or Android Studio, a "smart" text editor like VSCode with the Flutter extension installed, or just a plain old text editor and command line. For the pruposes of testing you do not have to set up an environment and can simply use the CLI.
* Run `flutter doctor` to make sure your install is all good (ignoring errors regarding setting up an IDE).

To run the app, you first have to connect a device or emulator. You can verify whether or not it is being detected using the `flutter doctor` command. Then, from the root of the project, run `flutter run` to run in the debug profile. 
--
**IMPORTANT**: as it is configured right now, the debug profile will ONLY connect to a locally hosted server instance, so you must have deployed the server locally to be able to use the app. To connect to the running Google Cloud instance (it's no different than the local server, it just will cost us money but saves you the hastle of having to build the server), you have to deploy flutter in release move with the command `flutter run --release`.

## Application Usage:
The application is pretty self explanatory. You start the app and create a new account (or login to an existing one, it is the same mechanism). If it is your first time using the app, it will prompt you to complete a brief survey on your food preferences. 

The main app page has only two buttons:

* The profile button in the top left corner can be used to change your profile settings (i.e. update your preferences, log out of the app, and change your display name) and the application settings
    - The application is configured by default to generate food recommendations for you at 12 PM. You can change that in the app preferences. You can also see your choice history and change the search radius for restaurants.
* The Feed Me button is the money maker! Click that button and the app will start searching for a place for you to eat. It will generate a list of restaurants but it won't _show_ you what restaurants it has chosen. It'll only show you pictures from the restaurants. Similar to Tinder, we require you to swipe up for food picture that you want to eat and down for those you do not. Only upon swiping up will it show you the restaurant details. We do this for three reasons:
    - In our initial user testing, users were unwilling to abide by our recommendation on name, location, and rating alone. They complained about wanting at least a little input on the process
    - Eating is a gut decision and we want you to make a split second decision based on visual (and by extension experiential) input to make the best decision
    - We want to force you to make a decision so we can train our model.

## Implementation:
The app's implementation is entirely contained with the `lib` folder. Additionally, the `assets` folder contains the resources like the graphics and fonts. All the other files and directories are onyl being used by flutter to implement the build process and are not application specific.

The `lib` folder contains an `app` subdirectory containing the implementation of each page of the app, while the `struct` controls the backend anmd structural behavior of the app.