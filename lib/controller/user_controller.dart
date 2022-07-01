import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wordrush/utils/constants.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  late Rx<User?> _user = Rx<User?>(firebaseAuth.currentUser);
  User? get user => _user.value;
  final Rx<bool> _isAuthLoading = false.obs;
  bool get isAuthLoading => _isAuthLoading.value;
  final Rx<int> _score = Rx<int>(0);
  int get score => _score.value;
  SharedPreferences? prefs;

  @override
  void onReady() {
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    getScore();
    ever(_user, _changeScore);
    super.onReady();
  }

  _changeScore(User? changedUser) async {
    if (changedUser == null) {
      _score.value = 0;
    } else {
      prefs ??= await SharedPreferences.getInstance();
      await prefs!.setInt('highscore', 0);
      getScore();
    }
  }

  Future<void> getScore() async {
    prefs ??= await SharedPreferences.getInstance();
    if (user != null) {
      _score.value = (await firestore
              .collection('users')
              .doc(user!.uid)
              .get())['highscore'] ??
          0;
    } else {
      _score.value = prefs!.getInt('highscore') ?? 0;
    }
  }

  Future<void> setScore(int scoreToSet) async {
    if (user != null) {
      await firestore
          .collection('users')
          .doc(user!.uid)
          .set({"highscore": scoreToSet});
    } else {
      await prefs!.setInt('highscore', scoreToSet);
    }
    _score.value = scoreToSet;
  }

  Future<void> signIn() async {
    try {
      final oldScore = prefs!.getInt('highscore') ?? 0;
      _isAuthLoading.value = true;
      final googleAccount = await GoogleSignIn().signIn();
      final googleAuth = await googleAccount!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final isNewUser = (await firebaseAuth.signInWithCredential(credential))
          .additionalUserInfo!
          .isNewUser;
      Get.snackbar('Signed in successfully', 'Welcome to WORD RUSH');
      _isAuthLoading.value = false;
      if (isNewUser) {
        if (oldScore > 0) {
          setScore(oldScore);
        } else {
          setScore(0);
        }
      }
    } catch (e) {
      _isAuthLoading.value = false;
      Get.snackbar(
          'Failed to sign in', 'Something went wrong, try again later');
    }
  }

  Future<void> signOut() async {
    try {
      _isAuthLoading.value = true;
      await firebaseAuth.signOut();
      await GoogleSignIn().signOut();
      _isAuthLoading.value = false;

      Get.snackbar(
          'Signed out', 'You signed out from this device successfully');
    } catch (_) {
      _isAuthLoading.value = false;

      Get.snackbar(
          'Failed to sign out', 'Something went wrong, try again later');
    }
  }
}
