import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod/riverpod.dart';
import 'package:untitled/model/user_model.dart';
import '../../../core/utils.dart';
import '../repository/auth_repository.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);
final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) => AuthController(
          authRepository: ref.watch(authRepositoryProvider),
          ref: ref,
        ));
  final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChanges;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});
final getCurrentUserDataProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getCurrentUserData();
});

// final getCurrentUserDataProvider = FutureProvider((ref) {
//   final authController = ref.watch(authControllerProvider.notifier);
//   return authController.getCurrentUserData();
// });
class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChanges => _authRepository.authStateChanges;

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    user.fold((l) => showSnackBar(context, l.message),
        (userModel) => _ref.read(userProvider.notifier).update((state) => userModel));
    state = false;
  }

  void setUserState(bool isOnline) {
    _authRepository.setUserState(isOnline);
  }

  void updateToken(String token) {
    _authRepository.updateToken(token);
  }

  void signInAsGuest(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInAsGuest();
    user.fold((l) => showSnackBar(context, l.message), (userModel) {
      _ref.read(userProvider.notifier).update((state) => userModel);
      state = false;
    });
  }

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  Stream<UserModel> getCurrentUserData() {
    return _authRepository.getCurrentUserData();
  }

  void logOut() async {
    _ref.read(userProvider.notifier).update((state) => null);
    _authRepository.logOut();
  }
}
