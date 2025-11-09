import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/theme_manager.dart';
import 'features/home/manager/brightness_manager.dart';
import 'features/home/view/home_screen.dart';
import 'features/onboarding/view/onboarding_screen.dart';
import 'features/sound/manager/sound_manager.dart';
import 'features/timer/manager/timer_manager.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final showOnboarding = prefs.getBool('onboarding_complete') ?? false;
  runApp(MyApp(showOnboarding: showOnboarding));
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;
  const MyApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BrightnessManager()),
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(create: (_) => SoundManager()),
        ChangeNotifierProxyProvider2<
          BrightnessManager,
          SoundManager,
          TimerManager
        >(
          create: (context) => TimerManager(
            context.read<BrightnessManager>(),
            context.read<SoundManager>(),
          ),
          update: (context, brightnessManager, soundManager, timerManager) =>
              TimerManager(brightnessManager, soundManager),
        ),
      ],
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, __) {
          return MaterialApp(
            title: 'Night Reader',
            theme: AppTheme.getTheme(themeManager.currentTheme),
            home: showOnboarding
                ? const HomeScreen()
                : const OnboardingScreen(),
          );
        },
      ),
    );
  }
}
