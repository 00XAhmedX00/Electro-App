import 'package:electrocart/Firebase/firebase_functions.dart';
import 'package:electrocart/Widgets/curved_Navigator.dart';
import 'package:electrocart/Widgets/go_to.dart';
import 'package:electrocart/Widgets/showSnackbar.dart';
import 'package:electrocart/Widgets/specific_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeName extends StatelessWidget {
  final String userId;
  const ChangeName({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    TextEditingController fistName = TextEditingController();
    TextEditingController lastName = TextEditingController();
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
                  "Change Name",
                  style: GoogleFonts.voces(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                SpecificFormField().nameFormField(
                  controller: fistName,
                  hintText: "new First Name",
                ),
                const SizedBox(height: 10),
                SpecificFormField().nameFormField(
                  controller: lastName,
                  hintText: "new Last Name",
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: BorderSide(color: Colors.lightGreen, width: 2),
                  ),
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      await FirebaseFunctions().updateName(
                        firstName: fistName.text,
                        lastName: lastName.text,
                        id: userId,
                      );
                      if (context.mounted) {
                        showSnackbar(
                          message: "Name Changed Successfuly",
                          context: context,
                        );
                        goTo(context: context, page: CurvedNavigator());
                      }
                    }
                  },
                  child: Text(
                    "Update Name",
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
