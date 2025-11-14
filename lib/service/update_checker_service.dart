import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// Use the key defined in the Firebase Console
const String _kMinBuildKey = 'minimum_required_build';

class UpdateCheckerService {
  final BuildContext context;

  UpdateCheckerService(this.context);

  Future<void> checkForUpdate() async {
    // 1. Get local app build number
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // Use buildNumber (e.g., '10') which is an integer for comparison
    final currentBuild = int.parse(packageInfo.buildNumber);

    // 2. Initialize and configure Remote Config
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 15),
        // Set to 0 for rapid testing, but use a longer interval (e.g., 1 hour) in production
        minimumFetchInterval: const Duration(minutes: 0),
      ),
    );

    // Set a safe default value if the fetch fails
    await remoteConfig.setDefaults(<String, dynamic>{_kMinBuildKey: '1'});

    try {
      // 3. Fetch and activate config values
      await remoteConfig.fetchAndActivate();

      // 4. Get the minimum required build number
      final requiredBuild = int.parse(remoteConfig.getString(_kMinBuildKey));

      // 5. Compare build numbers
      if (currentBuild < requiredBuild) {
        // Current app version is too old
        _showForceUpdateDialog(packageInfo.packageName);
      }
    } catch (e) {
      // Log or handle the fetch failure gracefully.
      // The app will continue using the default values set above.
      debugPrint('Remote Config check failed: $e');
    }
  }

  // Persistent Dialog (cannot be dismissed)
  void _showForceUpdateDialog(String packageName) {
    showDialog(
      context: context,
      barrierDismissible: false, // CRITICAL: Forces the user to update
      builder: (BuildContext context) {
        return PopScope(
          // Use PopScope for modern Flutter apps
          canPop: false, // CRITICAL: Prevents back button dismissal
          child: AlertDialog(
            title: const Text('⚠️ Update Required'),
            content: const Text(
              'This version is no longer supported. Please update to continue using the app.',
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Go to Store'),
                onPressed: () => _launchStore(packageName),
              ),
            ],
          ),
        );
      },
    );
  }

  // Store Redirection Logic
  void _launchStore(String packageName) async {
    final String url;

    // Use platform-specific URLs
    if (Platform.isIOS) {
      // Replace 'id123456789' with your actual Apple App Store ID
      url = 'https://apps.apple.com/app/id123456789';
    } else if (Platform.isAndroid) {
      url = 'market://details?id=$packageName'; // Uses the package name
    } else {
      // Fallback or unsupported platform
      url = 'https://www.google.com';
    }

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Handle the error if the store cannot be opened
      debugPrint('Could not launch $url');
    }
  }
}
