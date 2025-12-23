import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class AnalyticsLog {
  // 1. Static final instance (the single instance)
  static final AnalyticsLog _instance = AnalyticsLog._internal();

  // 2. Factory constructor to return the same instance
  factory AnalyticsLog() {
    return _instance;
  }

  // 3. Private named constructor to prevent external instantiation
  AnalyticsLog._internal();

  // Instance of the Firebase Analytics client
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  // --- Public Logging Methods ---

  /// Logs a generic event with the provided title.
  Future<void> logSimpleEvent({required String title}) async {
    await analytics.logEvent(name: title);
    debugPrint('Analytics Event Logged: $title');
  }
}
