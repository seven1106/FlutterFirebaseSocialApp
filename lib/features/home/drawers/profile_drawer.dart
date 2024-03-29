import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routemaster/routemaster.dart';
import 'package:untitled/features/auth/controller/auth_controller.dart';

import '../../../theme/palette.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  void toggleTheme(WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).toggleTheme();
  }

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }

  void navigateToUserProfile(
      BuildContext context, String uid, String name, String token) {
    Routemaster.of(context).push('/u/$name/$uid/$token');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final isGuest = !user!.isAuthenticated;
    return Drawer(
      child: SafeArea(
          child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.profilePic),
            radius: 60,
          ),
          const SizedBox(height: 15),
          Text(
            user.name,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 15),
          const Divider(),
          isGuest
              ? const SizedBox()
              : ListTile(
                  title: const Text("My profile"),
                  leading: const Icon(Icons.person),
                  onTap: () {
                    navigateToUserProfile(context, user.uid, user.name, user.token);
                  }),
          ListTile(
            title: const Text("Log out"),
            leading: const Icon(Icons.logout, color: Colors.red),
            onTap: () => logOut(ref),
          ),
          const Divider(),
          SizedBox(
            child: ListTile(
              title: const Text("Dark Mode"),
              leading: const Icon(Icons.dark_mode),
              trailing: Switch.adaptive(
                value: ref.watch(themeNotifierProvider.notifier).mode == ThemeMode.dark,
                onChanged: (val) => toggleTheme(ref),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
