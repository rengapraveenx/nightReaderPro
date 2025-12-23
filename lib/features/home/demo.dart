import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

//

PreviewThemeData previewTheme() => PreviewThemeData(
  // materialLight: ThemeData(brightness: Brightness.light, useMaterial3: true),
  // materialDark: ThemeData(brightness: Brightness.dark, useMaterial3: true),
  materialLight: ThemeData.light(useMaterial3: true),
  materialDark: ThemeData.dark(useMaterial3: true),
  cupertinoLight: CupertinoThemeData(brightness: Brightness.light),
  cupertinoDark: CupertinoThemeData(brightness: Brightness.dark),
);

class ButtonShowcase extends StatelessWidget {
  const ButtonShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);

    return Column(
      children: [
        Text('Current Brightness: $brightness'),
        const SizedBox(height: 10),

        FilledButton(child: const Text('Material'), onPressed: () {}),
        const SizedBox(height: 10),

        CupertinoButton.filled(
          child: const Text('Cupertino'),
          onPressed: () {},
        ),
      ],
    );
  }
}

@Preview(
  group: 'Brightness',
  name: 'Example – light',
  brightness: Brightness.light,
  theme: previewTheme,
)
@Preview(
  group: 'Brightness',
  name: 'Example – dark',
  brightness: Brightness.dark,
  theme: previewTheme,
)
Widget preview() => const ButtonShowcase();
