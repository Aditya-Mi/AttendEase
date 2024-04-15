import 'package:attendease/core/app_text.dart';
import 'package:attendease/core/widgets/custom_divider.dart';
import 'package:attendease/providers/user_provider.dart';
import 'package:attendease/screens/loading_screen.dart';
import 'package:attendease/widgets/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: user.when(
        data: (data) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${data.firstName} ${data.lastName}',
                          style: MyAppTypography.body2.copyWith(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          'Assistant Professor',
                          style: MyAppTypography.body4,
                        ),
                        Text(
                          'ECE Department',
                          style: MyAppTypography.body4,
                        ),
                        Text(
                          'Since 2016',
                          style: MyAppTypography.body4,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const CustomDivider(color: Color(0xffD4D4D4)),
                SettingsItem(
                  function: () {},
                  icon: Icons.person_outline,
                  title: 'Account',
                  subTitle: 'Privacy, secutrity, change email or number',
                ),
                SettingsItem(
                  function: () {},
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  subTitle: 'Message, group & call tones',
                ),
                SettingsItem(
                  function: () {},
                  icon: Icons.headset_mic_outlined,
                  title: 'Help',
                  subTitle: 'Help centre, contact us, privacy policy',
                ),
                SettingsItem(
                  function: () {},
                  icon: Icons.share_outlined,
                  title: 'Share',
                  subTitle: 'Share our app with others',
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return const Center(
            child: Text('An unexpected error occurred'),
          );
        },
        loading: () => const LoadingScreen(),
      ),
    );
  }
}
