# MyInoface

Flutter app (iOS + Android) for school/institution management: login (email/password and QR), classes, gardes, and recovery requests.

- **Package:** `com.inoser.myinoface`
- **Flutter:** see `.fvmrc` (use [FVM](https://fvm.app/))

## Test iOS on a Mac (no iPhone)

You can test almost everything on the **iOS Simulator**. You do not need a physical iPhone for login (email/password), navigation, or a store-style archive. QR/camera is the main thing the simulator cannot do well.

### 1. Install Xcode

1. App Store → **Xcode** (for App Store uploads you need **Xcode 26+**).
2. Open Xcode once, accept the license, and wait until extra components finish.
3. Xcode → **Settings → Platforms** (or **Components**) → install an **iOS 18/26 simulator runtime**.
4. In Terminal:

```bash
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
xcodebuild -downloadPlatform iOS
```

### 2. Install Flutter tooling

If you use FVM:

```bash
brew install cocoapods
cd /path/to/myinoface2
fvm install
fvm flutter doctor -v
```

`flutter doctor` should show **Xcode** and **iOS Simulator** as OK. Sign in with your Apple ID in Xcode → **Settings → Accounts** (a free account is enough for Simulator).

### 3. Open a simulator

```bash
open -a Simulator
```

Or:

```bash
xcrun simctl list devices available
```

Then boot an iPhone, for example:

```bash
xcrun simctl boot "iPhone 16"
open -a Simulator
```

Use an iPhone model, not only iPad.

### 4. Run this app on the simulator

From the project root:

```bash
fvm flutter pub get
cd ios && pod install && cd ..
fvm flutter devices
fvm flutter run
```

If several devices appear, choose the simulator:

```bash
fvm flutter run -d "iPhone 16"
```

First `pod install` and first Simulator boot are slow. After that, hot reload works as usual.

Signing: Simulator builds use automatic signing with team `PL35WBFPFC` already in the project. You should not need a real iPhone or a paid device register.

### 5. What you can / cannot test

| Works on Simulator | Weak / missing |
|---|---|| Email/password login | QR / camera scan |
| Classes, gardes, recovery screens | Real push from APNs (FCM is limited) |
| Layout, French/Arabic, rotation | Performance like a real phone |
| App icon, launch screen | TestFlight (that is a signed device/IPA flow) |

For login on Simulator, use **identifiant + password + school code**, not the QR button.

### 6. Optional: store-style IPA (still no iPhone)

You can still produce the archive on the Mac:

```bash
fvm flutter build ipa --release
```

Upload that IPA to **TestFlight**. Installing TestFlight **does** require an iPhone, an iPad, or a friend with a device. Simulator cannot install TestFlight builds.

Start with steps 1–4; when `flutter doctor` is clean, `flutter run` on iPhone Simulator is the daily test loop.
