import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrocart/Firebase/firebase_functions.dart';
import 'package:electrocart/Screens/admin_screens/admin_page.dart';
import 'package:electrocart/Screens/login_page.dart';
import 'package:electrocart/Widgets/curved_Navigator.dart';
import 'package:electrocart/Widgets/go_to.dart';
import 'package:electrocart/Widgets/showSnackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  Future<void> addUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required context,
  }) async {
    try {
      // Throw Exception if user enter admin email
      if (email == "admin123@gmail.com") {
        throw FirebaseAuthException(code: 'email-already-in-use');
      }
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await credential.user!.sendEmailVerification();
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(credential.user!.uid)
          .set({
            "FirstName": firstName,
            "LastName": lastName,
            "Email": email,
            "CreatedAt": Timestamp.now(),
            "Active": true,
          });
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        goTo(context: context, page: LoginPage());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackbar(message: "Your password is weak!", context: context);
      } else if (e.code == 'email-already-in-use') {
        showSnackbar(message: "This email is already taken!", context: context);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> checkUserExist({
    required String email,
    required String password,
    required context,
  }) async {
    try {
      if (email == "admin123@gmail.com" && password == "admin123@") {
        goTo(context: context, page: AdminPage());
      }
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .catchError((err) {
            throw FirebaseAuthException(code: 'user-not-found');
          });
      Map<String, dynamic> userData = await FirebaseFunctions().getUser(
        id: credential.user!.uid,
      );
      if (userData['Active'] == false) {
        throw FirebaseAuthException(code: "not-active");
      }
      if (credential.user!.emailVerified) {
        goTo(context: context, page: CurvedNavigator());
      } else {
        showSnackbar(
          message: "Email is not verified!\nCheck Your Email Spam",
          context: context,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackbar(message: "Invalid Email or Password!", context: context);
      } else if (e.code == 'wrong-password') {
        showSnackbar(message: "Invalid Email or Password!", context: context);
      } else if (e.code == 'not-active') {
        showSnackbar(message: "You have been banned!", context: context);
      }
    }
  }
}
