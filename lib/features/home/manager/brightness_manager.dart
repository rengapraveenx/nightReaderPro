import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';

class BrightnessManager extends ChangeNotifier {
  double _brightness = 0.5;
  bool _isLocked = false;

  double get brightness => _brightness;
  bool get isLocked => _isLocked;

  BrightnessManager() {
    _initBrightness();
  }

  Future<void> _initBrightness() async {
    try {
      _brightness = await ScreenBrightness().current;
      notifyListeners();
    } catch (e) {
      print(e);
      _brightness = 0.5;
      notifyListeners();
    }
  }

  Future<void> setBrightness(double brightness) async {
    try {
      await ScreenBrightness().setScreenBrightness(brightness);
      _brightness = brightness;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void toggleLock() {
    FirebaseCrashlytics.instance.log('User clicked brightness lock button');
    _isLocked = !_isLocked;
    notifyListeners();
  }

  Future<void> increaseBrightness() async {
    if (!_isLocked && _brightness < 1.0) {
      setBrightness(_brightness + 0.1);
    }
  }

  Future<void> decreaseBrightness() async {
    if (!_isLocked && _brightness > 0.1) {
      setBrightness(_brightness - 0.1);
    }
  }
}
