import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nightreader/features/home/manager/brightness_manager.dart';
import 'package:nightreader/features/sound/manager/sound_manager.dart';

enum TimerPreset { infinite, thirtyMinutes, oneHour, custom }

class TimerManager extends ChangeNotifier {
  final BrightnessManager _brightnessManager;
  final SoundManager _soundManager;

  Timer? _timer;
  Duration _remainingTime = Duration.zero;
  TimerPreset _currentPreset = TimerPreset.infinite;

  Duration get remainingTime => _remainingTime;
  TimerPreset get currentPreset => _currentPreset;
  bool get isRunning => _timer != null && _timer!.isActive;

  TimerManager(this._brightnessManager, this._soundManager);

  void setPreset(TimerPreset preset, {Duration? customDuration}) {
    _currentPreset = preset;
    switch (preset) {
      case TimerPreset.infinite:
        _remainingTime = Duration.zero;
        break;
      case TimerPreset.thirtyMinutes:
        _remainingTime = const Duration(minutes: 30);
        break;
      case TimerPreset.oneHour:
        _remainingTime = const Duration(hours: 1);
        break;
      case TimerPreset.custom:
        _remainingTime = customDuration ?? Duration.zero;
        break;
    }
    notifyListeners();
  }

  void startTimer() {
    if (_currentPreset == TimerPreset.infinite) return;
    if (isRunning) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds > 0) {
        _remainingTime = _remainingTime - const Duration(seconds: 1);
        notifyListeners();
      } else {
        _timer?.cancel();
        _onTimerEnd();
        notifyListeners();
      }
    });
  }

  void _onTimerEnd() {
    _soundManager.stopSound();
    _brightnessManager.setBrightness(0.1); // Gradually dim to a low brightness
    // TODO: Optionally fade-out animation
  }

  void pauseTimer() {
    _timer?.cancel();
    notifyListeners();
  }

  void stopTimer() {
    _timer?.cancel();
    _remainingTime = Duration.zero;
    _currentPreset = TimerPreset.infinite;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
