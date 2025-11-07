import 'package:flutter/material.dart';
import 'package:nightreader/features/home/view/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  Future<void> _completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Night Reader!',
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
              const SizedBox(height: 20),
              const Text(
                'Swipe up/down to adjust brightness, left/right to change theme.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => _completeOnboarding(context),
                child: const Text('Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
