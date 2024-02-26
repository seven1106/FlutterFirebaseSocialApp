import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:untitled/features/community/screens/add_mods_sreen.dart';
import 'package:untitled/features/community/screens/community_screen.dart';
import 'package:untitled/features/community/screens/create_community_screen.dart';
import 'package:untitled/features/community/screens/edit_community_screen.dart';
import 'package:untitled/features/community/screens/mod_tool_screen.dart';
import 'package:untitled/features/home/screens/home_screen.dart';
import 'package:untitled/features/home/user_profile/screens/edit_profile_screen.dart';
import 'package:untitled/features/home/user_profile/screens/user_profile_screen.dart';
import 'package:untitled/features/post/screens/comment_screen.dart';
import 'core/common/photo_view.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/chat/screens/mobile_community_chatbox.dart';
import 'features/chat/screens/mobile_contact_chatbox.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/create-community': (_) => const MaterialPage(child: CreateCommunityScreen()),
  '/r/:communityName': (route) => MaterialPage(
      child: CommunityScreen(communityName: route.pathParameters['communityName']!)),
  '/mod-tools/:communityName': (routeData) => MaterialPage(
      child: ModToolScreen(communityName: routeData.pathParameters['communityName']!)),
  '/edit-community/:communityName': (routeData) => MaterialPage(
      child:
          EditCommunityScreen(communityName: routeData.pathParameters['communityName']!)),
  '/add_mods/:communityName': (routeData) => MaterialPage(
      child: AddModsScreen(communityName: routeData.pathParameters['communityName']!)),
  '/u/:name/:uid': (routeData) =>
      MaterialPage(child: UserProfileScreen(
          uid: routeData.pathParameters['uid']!,
          name: routeData.pathParameters['name']!),
),
  '/edit-profile/:uid': (routeData) =>
      MaterialPage(child: EditProfileScreen(uid: routeData.pathParameters['uid']!)),
  '/post/:postId/comments': (routeData) =>
      MaterialPage(child: CommentsScreen(postId: routeData.pathParameters['postId']!)),
  '/post/img': (routeData) {
    final List<String> imageUrls = routeData.queryParameters['imageUrls']!.split(',');
    final int initialIndex = int.parse(routeData.queryParameters['initialIndex']!);
    return MaterialPage(
      child: ImageZoomScreen(
        initialIndex: initialIndex,
        imageUrls: imageUrls,
      ),
    );
  },
  '/chat/:name/:uid': (routeData) => MaterialPage(
      child: MobileContactChatScreen(
          name: routeData.pathParameters['name']!,
          uid: routeData.pathParameters['uid']!)),
  '/chat/:name': (routeData) => MaterialPage(
      child: MobileCommunityChatScreen(
          name: routeData.pathParameters['name']!,
          ),
  ),
});

