import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/features/auth/controller/auth_controller.dart';

class ProflieDrawner extends ConsumerWidget {
  const ProflieDrawner({super.key});
  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
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
            'u/ ${user.name}',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 15),
          const Divider(),
          ListTile(
            title: const Text("My profile"),
            leading: const Icon(Icons.person),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text("Log out"),
            leading: const Icon(Icons.logout, color: Colors.red),
            onTap: () => logOut(ref),
          ),
          Switch.adaptive(value: true, onChanged: (val) {})
        ],
      )),
    );
  }
}