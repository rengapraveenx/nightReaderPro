import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class SoundManager extends ChangeNotifier {
  static const String _lastSoundKey = 'last_sound';
  static const Duration _fadeDuration = Duration(milliseconds: 500);

  final AudioPlayer _audioPlayer = AudioPlayer();
  List<String> availableSounds = [
    'sounds/rain.mp3',
    'sounds/river.mp3',
    'sounds/water.mp3',
    'sounds/flute.mp3',
  ];

  String? _currentSound;
  bool _isPlaying = false;
  double _volume = 0.5;

  String? get currentSound => _currentSound;
  bool get isPlaying => _isPlaying;
  double get volume => _volume;

  SoundManager() {
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    _audioPlayer.onPlayerComplete.listen((event) {
      _isPlaying = false;
      WakelockPlus.disable();
      notifyListeners();
    });
    _loadLastSound();
  }

  Future<void> _loadLastSound() async {
    final prefs = await SharedPreferences.getInstance();
    final lastSound = prefs.getString(_lastSoundKey);
    if (lastSound != null && availableSounds.contains(lastSound)) {
      await playSound(lastSound);
    }
  }

  Future<void> playSound(String soundPath) async {
    if (_currentSound == soundPath && _isPlaying) {
      return; // Already playing this sound
    }
    await _audioPlayer.stop();
    await _audioPlayer.setSourceAsset(soundPath);
    await _audioPlayer.setVolume(0.0); // Start from 0 volume for fade-in
    await _audioPlayer.resume();
    _currentSound = soundPath;
    _isPlaying = true;
    WakelockPlus.enable();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastSoundKey, soundPath);

    // Fade-in logic
    double currentFadeVolume = 0.0;
    final double targetVolume = _volume;
    final int steps = 10;
    final Duration stepDuration = _fadeDuration ~/ steps;

    for (int i = 0; i <= steps; i++) {
      currentFadeVolume = targetVolume * (i / steps);
      await _audioPlayer.setVolume(currentFadeVolume);
      await Future.delayed(stepDuration);
    }

    notifyListeners();
  }

  Future<void> pauseSound() async {
    // Fade-out logic
    double currentFadeVolume = _volume;
    final int steps = 10;
    final Duration stepDuration = _fadeDuration ~/ steps;

    for (int i = steps; i >= 0; i--) {
      currentFadeVolume = _volume * (i / steps);
      await _audioPlayer.setVolume(currentFadeVolume);
      await Future.delayed(stepDuration);
    }

    await _audioPlayer.pause();
    _isPlaying = false;
    WakelockPlus.disable();
    notifyListeners();
  }

  Future<void> stopSound() async {
    // Fade-out logic
    double currentFadeVolume = _volume;
    final int steps = 10;
    final Duration stepDuration = _fadeDuration ~/ steps;

    for (int i = steps; i >= 0; i--) {
      currentFadeVolume = _volume * (i / steps);
      await _audioPlayer.setVolume(currentFadeVolume);
      await Future.delayed(stepDuration);
    }

    await _audioPlayer.stop();
    _isPlaying = false;
    _currentSound = null;
    WakelockPlus.disable();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_lastSoundKey);
    notifyListeners();
  }

  Future<void> setVolume(double newVolume) async {
    _volume = newVolume;
    await _audioPlayer.setVolume(newVolume);
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    WakelockPlus.disable(); // Ensure wakelock is disabled when manager is disposed
    super.dispose();
  }
}
