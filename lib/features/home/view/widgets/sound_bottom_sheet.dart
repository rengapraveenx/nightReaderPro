import 'package:flutter/material.dart';
import 'package:nightreader/features/sound/manager/sound_manager.dart';
import 'package:provider/provider.dart';

class SoundBottomSheet extends StatelessWidget {
  const SoundBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SoundManager>(
      builder: (context, soundManager, __) {
        return Container(
          height: 300,
          color: Colors.black,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Sound Settings',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: soundManager.availableSounds.length,
                  itemBuilder: (context, index) {
                    final soundPath = soundManager.availableSounds[index];
                    final soundName = soundPath
                        .split('/')
                        .last
                        .split('.')
                        .first;
                    return ListTile(
                      title: Text(
                        soundName,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing:
                          soundManager.currentSound == soundPath &&
                              soundManager.isPlaying
                          ? IconButton(
                              icon: const Icon(
                                Icons.pause,
                                color: Colors.white,
                              ),
                              onPressed: () => soundManager.pauseSound(),
                            )
                          : IconButton(
                              icon: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                              onPressed: () =>
                                  soundManager.playSound(soundPath),
                            ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.volume_down, color: Colors.white),
                  Expanded(
                    child: Slider(
                      value: soundManager.volume,
                      onChanged: (value) => soundManager.setVolume(value),
                      min: 0.0,
                      max: 1.0,
                      activeColor: Colors.white,
                      inactiveColor: Colors.white30,
                    ),
                  ),
                  const Icon(Icons.volume_up, color: Colors.white),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
