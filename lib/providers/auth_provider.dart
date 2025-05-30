import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile_app_test/screen/Home_page/home_page.dart';
import 'package:mobile_app_test/screen/login_screen/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_app_test/utils/colors.dart';
import 'dart:developer' as dev;

import 'package:mobile_app_test/widgets/common_snackbar_message.dart';

class AuthProvider extends ChangeNotifier {
  // google authentication
  bool signInLoader = false;
  bool get getsignInLoader => signInLoader;
  setsignInLoader(val) {
    signInLoader = val;
    notifyListeners();
  }

  Future<UserCredential?> signInWithGoogle(context) async {
    try {
      setsignInLoader(true);
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      dev.log("sign credintals ${credential} -- user-- ${googleUser}");
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    email: "${userCredential.user!.email}",
                    name: "${userCredential.user!.displayName}",
                    profilePrc: "${userCredential.user!.photoURL}",
                  )),
        );
      }
    } catch (e) {
      dev.log(e.toString());
      SnackBarUtils.showSnackBar(
        style: SnackBarStyle(backgroundColor: kErrorMessageColor),
        context,
        message: "Google sign-in failed",
      );
    } finally {
      setsignInLoader(false);
    }
  }

// check user already sing in
  bool loadingAlreadySingCheck = false;
  bool get getloadingAlreadySingCheck => loadingAlreadySingCheck;
  setloadingAlreadySingCheck(val) {
    loadingAlreadySingCheck = val;
    notifyListeners();
  }

  Future<void> checkSingStatus(context) async {
    try {
      setloadingAlreadySingCheck(true);
      final user = FirebaseAuth.instance.currentUser;
      dev.log("check user record $user");
      if (user != null) {
        await Future.delayed(const Duration(seconds: 1));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              email: "${user.email}",
              name: "${user.displayName}",
              profilePrc: "${user.photoURL}",
            ),
          ),
        );
      } else {
        await Future.delayed(const Duration(seconds: 1));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setloadingAlreadySingCheck(true);
    }
  }

  // user log out function
  bool loadingLogout = false;
  bool get getloadingLogout => loadingLogout;
  setloadingLogout(val) {
    loadingLogout = val;
    notifyListeners();
  }

  Future<void> userLogOut(context) async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false,
      ).then(
        (value) {
          SnackBarUtils.showSnackBar(
            style: SnackBarStyle(backgroundColor: kSuccessMessageColor),
            context,
            message: "Logout Success",
          );
        },
      );
    } catch (e) {
      dev.log('Logout error: $e');
      SnackBarUtils.showSnackBar(
        style: SnackBarStyle(backgroundColor: kErrorMessageColor),
        context,
        message: "Logout failed. Please try again.",
      );
    }
  }
}
