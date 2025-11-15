import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InAppReviewService {
  final InAppReview _inAppReview = InAppReview.instance;
  final SharedPreferences _prefs;

  static const String _appOpenCountKey = 'app_open_count';
  static const String _lastReviewRequestKey = 'last_review_request';

  InAppReviewService(this._prefs);

  Future<void> incrementAppOpenCount() async {
    int openCount = _prefs.getInt(_appOpenCountKey) ?? 0;
    await _prefs.setInt(_appOpenCountKey, openCount + 1);
  }

  Future<void> requestReview() async {
    final bool isAvailable = await _inAppReview.isAvailable();
    if (!isAvailable) {
      return;
    }

    int openCount = _prefs.getInt(_appOpenCountKey) ?? 0;
    int lastRequestTimestamp = _prefs.getInt(_lastReviewRequestKey) ?? 0;

    DateTime lastRequestDate = DateTime.fromMillisecondsSinceEpoch(
      lastRequestTimestamp,
    );
    DateTime now = DateTime.now();

    bool shouldRequestReview =
        openCount >= 10 &&
        (lastRequestTimestamp == 0 ||
            now.difference(lastRequestDate).inDays >= 30);

    if (shouldRequestReview) {
      await _inAppReview.requestReview();
      await _prefs.setInt(_lastReviewRequestKey, now.millisecondsSinceEpoch);
    }
  }
}
