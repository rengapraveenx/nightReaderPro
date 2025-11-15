import 'package:flutter/material.dart';
import 'package:nightreader/features/timer/manager/timer_manager.dart';
import 'package:provider/provider.dart';

import 'profile_bottom_sheet.dart';
import 'sound_bottom_sheet.dart';
import 'theme_bottom_sheet.dart';
import 'timer_bottom_sheet.dart';

class BottomControlBar extends StatelessWidget {
  const BottomControlBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TimerManager>(
      builder: (context, timerManager, __) {
        final String timerLabel = timerManager.isRunning
            ? '${timerManager.remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0')}:${timerManager.remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0')}'
            : 'Timer';

        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.timer),
              label: timerLabel,
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.color_lens),
              label: 'Theme',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.music_note),
              label: 'Sound',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          onTap: (index) {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                switch (index) {
                  case 0:
                    return const TimerBottomSheet();
                  case 1:
                    return const ThemeBottomSheet();
                  case 2:
                    return const SoundBottomSheet();
                  case 3:
                    return const ProfileBottomSheet();
                  default:
                    return const SizedBox.shrink();
                }
              },
            );
          },
        );
      },
    );
  }
}
