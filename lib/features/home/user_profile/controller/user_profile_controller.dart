import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:untitled/core/enums/enums.dart';
import 'package:untitled/features/home/user_profile/repository/user_profile_repo.dart';
import 'package:untitled/model/user_model.dart';

import '../../../../core/enums/notification_enums.dart';
import '../../../../core/providers/storage_repository_provider.dart';
import '../../../../core/utils.dart';
import '../../../../model/notification_model.dart';
import '../../../../model/post_model.dart';
import '../../../auth/controller/auth_controller.dart';
import '../../../notification/repository/notification_repo.dart';

final userProfileControllerProvider =
    StateNotifierProvider<UserProfileController, bool>((ref) {
  return UserProfileController(
      userProfileRepo: ref.watch(userProfileRepoProvider),
      notificationRepo: ref.watch(notificationRepoProvider),
      ref: ref,
      storageRepository: ref.watch(storageRepositoryProvider));
});
final getUserPostsProvider = StreamProvider.family((ref, String uid) {
  return ref.read(userProfileControllerProvider.notifier).getUserPosts(uid);
});
final searchUserProvider = StreamProvider.family((ref, String query) {
  return ref.watch(userProfileControllerProvider.notifier).searchUser(query);
});
final getUserFollowersProvider = StreamProvider.family((ref, String uid) {
  return ref
      .watch(userProfileControllerProvider.notifier)
      .getUserFollowers(uid);
});
class UserProfileController extends StateNotifier<bool> {
  final UserProfileRepo _userRepo;
  final NotificationRepo _notificationRepo;
  final Ref _ref;

  final StorageRepository _storageRepository;

  UserProfileController({
    required UserProfileRepo userProfileRepo,
    required NotificationRepo notificationRepo,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _userRepo = userProfileRepo,
        _notificationRepo = notificationRepo,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void editUser(
      {required File? avatarFile,
      required File? bannerFile,
      required BuildContext context,
      required String description,
      required String name}) async {
    var user = _ref.read(userProvider)!;
    state = true;

    if (avatarFile != null) {
      final res = await _storageRepository.storeFile(
          file: avatarFile, id: user.uid, path: "user/${user.uid}/avatar");
      res.fold((l) => showSnackBar(context, l.message),
          (r) => user = user.copyWith(profilePic: r));
    }
    if (bannerFile != null) {
      final res = await _storageRepository.storeFile(
          file: bannerFile, id: user.uid, path: "user/${user.uid}/banner");
      res.fold((l) => showSnackBar(context, l.message),
          (r) => user = user.copyWith(banner: r));
    }
    if (description != user.description) {
      user = user.copyWith(description: description);
    }
    if (name != user.name) {
      user = user.copyWith(name: name);
    }
    final res = await _userRepo.editUser(user);
    state = false;
    res.fold(
        (l) => showSnackBar(context, l.message),
        (r) => {
              _ref.read(userProvider.notifier).update((state) => user),
              showSnackBar(context, 'Profile updated successfully'),
              Routemaster.of(context).push('/u/${user.uid}')
            });
  }

  Stream<List<PostModel>> getUserPosts(String uid) {
    try {
      return _userRepo.getUserPosts(uid);
    } catch (e) {
      return Stream.empty();
    }
  }
  Stream<List<UserModel>> searchUser(String query) {
    return _userRepo.searchUser(query);
  }
  Stream<List<UserModel>> getUserFollowers(String uid) {
    return _userRepo.getUserFollowers(uid);
  }

  void updateUserKarma(UserKarma karma) async {
    UserModel user = _ref.read(userProvider)!;
    user = user.copyWith(karma: user.karma + karma.karma);
    final res = await _userRepo.updateUserKarma(user);
    res.fold((l) => null,
        (r) => _ref.read(userProvider.notifier).update((state) => user));
  }
  void followUser( String followUid) async {
    final user = _ref.read(userProvider)!;
    _userRepo.followUser(user.uid, followUid);
    final NotificationModel notification = NotificationModel(
      id:user.uid,
      type: NotificationEnum.follow,
      name: user.name,
      createdAt: DateTime.now(),
      uid: followUid,
      profilePic: user.profilePic,
      text: '${user.name} started following you',
      isRead: false,
    );
    _notificationRepo.sendNotification(
      notification: notification,
    );
  }
  void unFollowUser(String followUid) async {
    final user = _ref.read(userProvider)!.uid;
    _userRepo.unFollowUser(user, followUid);
  }
}
