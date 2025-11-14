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
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Night Reader!',
                style: TextStyle(color: Colors.black, fontSize: 32),
              ),
              const SizedBox(height: 20),
              const Text(
                'Here are the gestures to control the app:',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize: 18),
              ),
              const SizedBox(height: 40),
              const ListTile(
                leading: Icon(Icons.swipe_up, color: Colors.black),
                title: Text('Swipe Up: Increase Brightness', style: TextStyle(color: Colors.black)),
              ),
              const ListTile(
                leading: Icon(Icons.swipe_down, color: Colors.black),
                title: Text('Swipe Down: Decrease Brightness', style: TextStyle(color: Colors.black)),
              ),
              const ListTile(
                leading: Icon(Icons.swipe_left_alt_outlined, color: Colors.black),
                title: Text('Swipe Left/Right: Change Color Theme', style: TextStyle(color: Colors.black)),
              ),
              const ListTile(
                leading: Icon(Icons.touch_app, color: Colors.black),
                title: Text('Long Press: Lock/Unlock Brightness', style: TextStyle(color: Colors.black)),
              ),
              const ListTile(
                leading: Icon(Icons.timer, color: Colors.black),
                title: Text('Sleep Timer: Set a timer to turn off the screen', style: TextStyle(color: Colors.black)),
              ),
              const ListTile(
                leading: Icon(Icons.music_note, color: Colors.black),
                title: Text('Music: Play/Pause, Volume Up/Down', style: TextStyle(color: Colors.black)),
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
