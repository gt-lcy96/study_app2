import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study_app_2/firebase_ref/references.dart';
import 'package:study_app_2/pages/login/view.dart';
import 'package:study_app_2/routes/routes.dart';
import 'package:study_app_2/services/app_logger.dart';
import 'package:study_app_2/widgets/dialogs/dialogue_widget.dart';

class AuthController extends GetxController {

  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;

  @override
  void onReady() {
    // TODO: implement onReady
    initAuth();
    super.onReady();
  }

  Future<void> initAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateToIntroduction();
  }
  
  signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if(account != null) {
        final _authAccount = await account.authentication;
        final _credential = GoogleAuthProvider.credential(
          idToken: _authAccount.idToken,
          accessToken: _authAccount.accessToken,
        );

        await _auth.signInWithCredential(_credential);
        await saveUser(account);
        navigateToHomePage();
      }
    } catch(e) {
      print("Exception in auth_controller: $e");
    }
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  saveUser(GoogleSignInAccount account) {
    userRF.doc(account.email).set({
      'email': account.email,
      "name": account.displayName,
      "profilePic": account.photoUrl,
    });
  }

  Future<void> signOut() async {
    AppLogger.d('Sign Out');
    try {
      await _auth.signOut();
      navigateToHomePage();
    } on FirebaseAuthException catch(e) {
      // print('Exception in auth_controller.signOut: $e');
      AppLogger.e(e);
    }
  }

  void navigateToIntroduction() {
    Get.offAllNamed(AppRoutes.INTRODUCTION);
  }

  navigateToHomePage() {
    Get.offAllNamed(AppRoutes.HOME);
  }

  void showLoginAlertDialogue() {
    Get.dialog(Dialogs.questionStartDialogue(onTap: (){
      Get.back();
      navigateToLoginPage();
    }),
    // User cant tap outside of dialog to dismiss the dialog
    barrierDismissible: false
    );
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }
  
  void navigateToLoginPage() {
    Get.toNamed(AppRoutes.SIGN_IN);
  }
}