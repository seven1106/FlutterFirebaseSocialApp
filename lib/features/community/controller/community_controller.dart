import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:routemaster/routemaster.dart';
import 'package:untitled/core/constants/constants.dart';
import 'package:untitled/model/community_model.dart';

import '../../../core/failure.dart';
import '../../../core/providers/storage_repository_provider.dart';
import '../../../core/utils.dart';
import '../../auth/controller/auth_controller.dart';
import '../repository/community_repo.dart';

final userCommunitiesProvider = StreamProvider((ref) {
  return ref.watch(communityControllerProvider.notifier).getCommunities();
});
final communityNameProvider =
    StreamProvider.family((ref, String communityName) {
  return ref
      .watch(communityControllerProvider.notifier)
      .getCommunityName(communityName);
});

final communityControllerProvider =
    StateNotifierProvider<CommunityController, bool>((ref) {
  final storageRepository = ref.watch(storageRepositoryProvider);
  return CommunityController(
      communityRepo: ref.watch(communityRepoProvider),
      ref: ref,
      storageRepository: storageRepository);
});

final getCommunityByNameProvider = StreamProvider.family((ref, String name) {
  return ref.watch(communityControllerProvider.notifier).getCommunityName(name);
});

final searchCommunityProvider = StreamProvider.family((ref, String query) {
  return ref.watch(communityControllerProvider.notifier).searchCommunity(query);
});

class CommunityController extends StateNotifier<bool> {
  final CommunityRepo _communityRepo;

  final Ref _ref;

  final StorageRepository _storageRepository;

  CommunityController({
    required CommunityRepo communityRepo,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _communityRepo = communityRepo,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void createCommunity(String name, String des, BuildContext context) async {
    state = true;
    final userUid = _ref.read(userProvider)?.uid ?? "";
    Community community = Community(
        id: name,
        name: name,
        description: des,
        banner: Constants.bannerDefault,
        avatar: Constants.avatarDefault,
        members: [userUid],
        mods: [userUid]);
    final res = await _communityRepo.createCommunity(community);
    res.fold(
        (l) => showSnackBar(context, l.message),
        (r) => {
              showSnackBar(context, "Community created."),
              Routemaster.of(context).pop()
            });
    state = false;
  }
  void joinCommunity(Community community, BuildContext context) async {
    final user = _ref.read(userProvider)!;
    Either<Failure, void> res;
    if (community.members.contains(user.uid)) {
      res = await _communityRepo.leaveCommunity(community.name, user.uid);
    } else {
      res = await _communityRepo.joinCommunity(community.name, user.uid);
      res.fold((l) => showSnackBar(context, l.message), (r) => {
        if (community.members.contains(user.uid)) {
          showSnackBar(context, "Leaved community ${community.name}"),
        } else {
          showSnackBar(context, " Joined community ${community.name}"),

        }
      });
    }
 }

  Stream<List<Community>> getCommunities() {
    final userUid = _ref.read(userProvider)?.uid ?? "";
    return _communityRepo.getCommunities(userUid);
  }

  Stream<Community> getCommunityName(String communityName) {
    return _communityRepo.getCommunityName(communityName);
  }

  void editCommunity(
      {required File? avatarFile,
      required File? bannerFile,
      required BuildContext context,
      required Community community,
      required String description}) async {
    state = true;

    if (avatarFile != null) {
      final res = await _storageRepository.storeFile(
          file: avatarFile,
          id: community.name,
          path: "community/${community.name}/avatar");
      res.fold((l) => showSnackBar(context, l.message), (r) => community = community.copyWith(avatar: r));
    }
    if (bannerFile != null) {
      final res = await _storageRepository.storeFile(
          file: bannerFile,
          id: community.name,
          path: "community/${community.name}/banner");
      res.fold((l) => showSnackBar(context, l.message), (r) => community = community.copyWith(banner: r));

    }
    if(description != community.description){
      community = community.copyWith(description: description);
    }
    final res = await _communityRepo.editCommunity(community);
    state = false;
    res.fold(
        (l) => showSnackBar(context, l.message),
        (r) => {
              showSnackBar(context, "Community edited."),
              Routemaster.of(context).pop()
            });
  }
  Stream<List<Community>> searchCommunity(String query) {
    return _communityRepo.searchCommunity(query);
  }
  void addMods(String communityName, List<String> uids, BuildContext context) async {
    state = true;
    final res = await _communityRepo.addMod(communityName, uids);
    res.fold(
        (l) => showSnackBar(context, l.message),
        (r) => {
              showSnackBar(context, "Mod added."),
              Routemaster.of(context).pop()
            });
    state = false;
  }
}