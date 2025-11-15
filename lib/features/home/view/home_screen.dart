import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nightreader/service/update_checker_service.dart';
import 'package:nightreader/features/in_app_review/service/in_app_review_service.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/theme/theme_manager.dart';
import '../manager/brightness_manager.dart';
import 'widgets/bottom_control_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Check update for returning users
      UpdateCheckerService(context).checkForUpdate();
      Provider.of<InAppReviewService>(context, listen: false).requestReview();
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreenStl();
  }
}

class HomeScreenStl extends StatelessWidget {
  const HomeScreenStl({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<ThemeManager, BrightnessManager>(
        builder: (context, themeManager, brightnessManager, __) {
          return GestureDetector(
            onVerticalDragUpdate: (details) {
              if (details.primaryDelta! < 0) {
                brightnessManager.increaseBrightness();
              } else {
                brightnessManager.decreaseBrightness();
              }
            },
            onHorizontalDragEnd: (details) {
              themeManager.nextTheme();
            },
            onLongPress: () {
              brightnessManager.toggleLock();
            },
            child: Stack(
              children: [
                Animate(
                  effects: const [FadeEffect()],
                  child: Container(
                    key: ValueKey(themeManager.currentTheme),
                    decoration: BoxDecoration(
                      gradient: AppTheme.getGradient(themeManager.currentTheme),
                    ),
                    alignment: Alignment.center,
                    child: AnimatedOpacity(
                      opacity: brightnessManager.brightness,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black12.withAlpha(50),
                        ),
                        child: Text(
                          brightnessManager.isLocked
                              ? 'Brightness Locked'
                              : 'Night Reader',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: AnimatedOpacity(
                    opacity: brightnessManager.isLocked ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(
                      Icons.lock,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomControlBar(),
    );
  }
}
