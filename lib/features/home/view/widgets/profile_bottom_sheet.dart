
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.black,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Profile & Info',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.school, color: Colors.white),
                  title: const Text('Tutorial', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    print('Tutorial tapped');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.star, color: Colors.white),
                  title: const Text('Rate App', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    print('Rate App tapped');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.share, color: Colors.white),
                  title: const Text('Share App', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Share.share('Check out Night Reader app!');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip, color: Colors.white),
                  title: const Text('Privacy Policy', style: TextStyle(color: Colors.white)),
                  onTap: () async {
                    final Uri url = Uri.parse('https://www.google.com'); // Placeholder URL
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info, color: Colors.white),
                  title: const Text('Credits', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    print('Credits tapped');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.white),
                  title: const Text('Exit App', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    SystemNavigator.pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
