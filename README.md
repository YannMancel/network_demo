[![badge_flutter]][link_flutter_release]

# network_demo
**Goal**: A Flutter project to manage network requests.

## Requirements
* Computer (Windows, Mac or Linux)
* Android Studio

## Setup the project in Android studio
1. Download the project code, preferably using `git clone git@github.com:YannMancel/network_demo.git`.
2. In Android Studio, select *File* | *Open...*
3. Select the project

## Database
We will be utilizing [Go REST][link_go_rest] as the online REST API for testing our app.
it provides fully secured rapid prototyping and lets us do a variety of network operations on the data.

## Run
```bash
make run TOKEN=YOUR_ACCESS_TOKEN
```

## Dependencies
* Flutter Version Management
  * [fvm][dependencies_fvm]
* Data class generator
  * [build_runner][dependencies_build_runner]
  * [freezed][dependencies_freezed]
  * [freezed_annotation][dependencies_freezed_annotation]
* State managers
  * [flutter_hooks][dependencies_flutter_hooks]
  * [hooks_riverpod][dependencies_hooks_riverpod]
* Network
  * [dio][dependencies_dio]

## Troubleshooting

### No device available during the compilation and execution steps
* If none of device is present (*Available Virtual Devices* or *Connected Devices*),
  * Either select `Create a new virtual device`
  * or connect and select your phone or tablet

## Useful
* [Download Android Studio][useful_android_studio]
* [Create a new virtual device][useful_virtual_device]
* [Enable developer options and debugging][useful_developer_options]

[badge_flutter]: https://img.shields.io/badge/flutter-v3.0.5-blue?logo=flutter
[link_flutter_release]: https://docs.flutter.dev/development/tools/sdk/releases
[link_go_rest]: https://gorest.co.in/
[dependencies_fvm]: https://fvm.app/
[dependencies_build_runner]: https://pub.dev/packages/build_runner
[dependencies_freezed]: https://pub.dev/packages/freezed
[dependencies_freezed_annotation]: https://pub.dev/packages/freezed_annotation
[dependencies_flutter_hooks]: https://pub.dev/packages/flutter_hooks
[dependencies_hooks_riverpod]: https://pub.dev/packages/hooks_riverpod
[dependencies_dio]: https://pub.dev/packages/dio
[useful_android_studio]: https://developer.android.com/studio
[useful_virtual_device]: https://developer.android.com/studio/run/managing-avds.html
[useful_developer_options]: https://developer.android.com/studio/debug/dev-options.html#enable
