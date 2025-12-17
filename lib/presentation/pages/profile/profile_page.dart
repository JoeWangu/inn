import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inn/presentation/controllers/auth_controllers/auth_check_controller.dart';
import 'package:inn/presentation/controllers/profile_controller.dart';
import 'package:inn/core/errors/error_handler.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    final profileAsync = ref.watch(profileControllerProvider);

    return Scaffold(
      backgroundColor: cs.onPrimary,
      appBar: AppBar(title: const Text('Profile')),
      body: profileAsync.when(
        data: (profile) {
          final displayName =
              profile?.firstName != null && profile?.lastName != null
              ? "${profile!.firstName} ${profile.lastName}"
              : (profile?.firstName ?? "User");

          return Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 40,
                backgroundImage: profile?.profilePicture != null
                    ? NetworkImage(profile!.profilePicture!) as ImageProvider
                    : const AssetImage('assets/img_assets/avatar.png'),
              ),
              const SizedBox(height: 10),
              Text(
                displayName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (profile?.bio != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  child: Text(
                    profile!.bio!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              if (profile == null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Complete your profile to get the best experience",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),

              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  context.pushNamed('edit-profile', extra: profile);
                },
                icon: const Icon(Icons.edit),
                label: Text(
                  profile == null ? 'Create Profile' : 'Edit Profile',
                ),
              ),

              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.home_work),
                      title: const Text('My Properties'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        context.pushNamed('my-properties');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Settings'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        context.pushNamed('settings');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.help),
                      title: const Text('Help & Support'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text(
                        'Log Out',
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap: () {
                        ref.read(authCheckControllerProvider.notifier).logout();
                        context.goNamed('login');
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              getReadableError(err),
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
