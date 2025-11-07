import 'package:flutter/material.dart';
import 'package:nightreader/features/timer/manager/timer_manager.dart';
import 'package:provider/provider.dart';

class TimerBottomSheet extends StatelessWidget {
  const TimerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TimerManager>(
      builder: (context, timerManager, __) {
        return Container(
          height: 300,
          color: Colors.black,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Timer Settings',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        timerManager.setPreset(TimerPreset.infinite),
                    child: const Text('Infinite'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        timerManager.setPreset(TimerPreset.thirtyMinutes),
                    child: const Text('30 Min'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        timerManager.setPreset(TimerPreset.oneHour),
                    child: const Text('1 Hour'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Remaining: ${timerManager.remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0')}:${timerManager.remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: timerManager.startTimer,
                    child: const Text('Start'),
                  ),
                  ElevatedButton(
                    onPressed: timerManager.pauseTimer,
                    child: const Text('Pause'),
                  ),
                  ElevatedButton(
                    onPressed: timerManager.stopTimer,
                    child: const Text('Stop'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
