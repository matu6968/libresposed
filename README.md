# Libresposed
<img align="left" src="play-store-images/ic_launcher-playstore.png" width="140" />

Historically, setting a custom MAC address on Android was very easy for rooted users. Starting with Android 12, however, Google's implementation of MAC address randomization has made it impossible, as the MAC address is always changed when the network state is altered. If you have encountered this problem, then you need Libresposed! Libresposed is an Xposed module based on MACsposed before it went proprietary (1.2.0+) that blocks the MAC address randomizer on Android 12 through 14 and allows you to once again make use of your favorite tools for setting your MAC address. Simply install Libresposed, enable it, and go back to randomizing your MAC address using your favorite tools for doing so!

Libresposed will [always be free software](https://www.gnu.org/philosophy/free-sw.html) and will not require a weird 10$ lifetime license (or the subscription flavors ranging from 1$ to 5$) to unlock its functionality unlike MACsposed where it went the proprietary route starting in 1.2.0.


**⚠️ WARNING:** Libresposed is intended for rooted devices running Android 12 through 14 and requires Xposed. The required Xposed variant to use is LSPosed. Other Xposed variants will not work. Additionally, this module cannot be guaranteed to work on all devices. In the worst case, it can cause a bootloop. Use at your own risk.

<p align="center">
  <a href="https://github.com/matu6968/libresposed/releases">
    <img src="play-store-images/badge_github.png" height="80" />
  </a>
</p>

To use Libresposed:
1. Install LSposed. This requires your device to be rooted with Magisk or KernelSU. Installation instructions for LSPosed are available [here](https://github.com/LSPosed/LSPosed#install).
2. Install Libresposed.
3. Activate the Libresposed module in the LSposed user interface.

<p align="center">
  <img src="play-store-images/screenshots/1.png" width="300" />
  <img src="play-store-images/screenshots/2.png" width="300" />
</p>

4. Reboot your device and sign in.

<p align="center">
  <img src="play-store-images/screenshots/3.png" width="300" />
</p>

5. Open the quick settings panel. The Libresposed tile will appear.

<p align="center">
  <img src="play-store-images/screenshots/4.png" width="300" />
</p>

6. Toggle the Libresposed tile on or off to enable or disable it.
7. Use your favorite tool for setting a custom MAC address!

<p align="center">
  <img src="play-store-images/screenshots/5.png" width="300" />
  <img src="play-store-images/screenshots/6.png" width="300" />
</p>

## Building

To build the app, you need to have the following tools installed:

- Android Studio
- Gradle
- JDK 17

Then, you can build the app by running the following command:

Due to libxposed not being available on Maven Central, you need to build first the libxposed library and then publish it to your local Maven repository.

Either by running the following script:

```bash
./setup-libxposed.sh
```

Or manually by running the following commands:

```bash
git clone https://github.com/libxposed/api.git
git clone https://github.com/libxposed/service.git
cd api
./gradlew :api:publishApiPublicationToMavenLocal
cd ../service
# You need to apply a patch to the service project to prevent failures when building the app
git apply ../patch-java-requirement.patch
./gradlew :service:publishServicePublicationToMavenLocal
```

Then, you can build the app by running the following command:

```bash
./gradlew build
```