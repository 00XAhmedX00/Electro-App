import 'package:electrocart/Widgets/curved_Navigator.dart';
import 'package:electrocart/Widgets/go_to.dart';
import 'package:electrocart/Widgets/showSnackbar.dart';
import 'package:electrocart/Widgets/specific_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordPage extends StatelessWidget {
  final String userId;
  const ChangePasswordPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    TextEditingController password = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
    GlobalKey<FormState> key = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.green.shade300,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Change Password",
                  style: GoogleFonts.voces(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                SpecificFormField().passwordFormField(controller: password),
                const SizedBox(height: 10),
                SpecificFormField().confirPasswordFormField(
                  controller: confirmPassword,
                  actualPassword: password,
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: BorderSide(color: Colors.lightGreen, width: 2),
                  ),
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.currentUser!.updatePassword(
                          password.text,
                        );

                        if (context.mounted) {
                          showSnackbar(
                            message: "Password updated successfully",
                            context: context,
                          );
                          goTo(context: context, page: CurvedNavigator());
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'requires-recent-login') {
                          if (context.mounted) {
                            showSnackbar(
                              message:
                                  "Please log in again to change your password.",
                              context: context,
                            );
                          }
                        } else {
                          if (context.mounted) {
                            showSnackbar(
                              message: e.message ?? "Error occurred",
                              context: context,
                            );
                          }
                        }
                      }
                    }
                  },
                  child: Text(
                    "Update Password",
                    style: GoogleFonts.voces(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: BorderSide(color: Colors.lightGreen, width: 2),
                  ),
                  onPressed: () {
                    goTo(context: context, page: CurvedNavigator(index: 0));
                  },
                  child: Text(
                    "Return To Profile",
                    style: GoogleFonts.voces(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
