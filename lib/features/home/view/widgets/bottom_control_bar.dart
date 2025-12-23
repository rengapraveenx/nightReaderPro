import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:nightreader/features/timer/manager/timer_manager.dart';
import 'package:nightreader/service/analytics_log.dart';
import 'package:provider/provider.dart';

import 'profile_bottom_sheet.dart';
import 'sound_bottom_sheet.dart';
import 'theme_bottom_sheet.dart';
import 'timer_bottom_sheet.dart';

@Preview(name: 'Widget Constructor')
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
                    AnalyticsLog().logSimpleEvent(
                      title: 'timer_bottom_sheet_opened',
                    );
                    return const TimerBottomSheet();
                  case 1:
                    AnalyticsLog().logSimpleEvent(
                      title: 'theme_bottom_sheet_opened',
                    );
                    return const ThemeBottomSheet();
                  case 2:
                    AnalyticsLog().logSimpleEvent(
                      title: 'sound_bottom_sheet_opened',
                    );
                    return const SoundBottomSheet();
                  case 3:
                    AnalyticsLog().logSimpleEvent(
                      title: '_bottom_sheet_opened',
                    );
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
