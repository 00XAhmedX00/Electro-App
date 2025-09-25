import 'package:electrocart/Firebase/auth_services.dart';
import 'package:electrocart/Screens/registration_page.dart';
import 'package:electrocart/Widgets/go_to.dart';
import 'package:electrocart/Widgets/specific_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SpecificFormField formFields = SpecificFormField();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool refresh = false;

  GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Text
              Center(
                child: Text(
                  "Welcome To ElectroApp!",
                  style: GoogleFonts.voces(fontSize: 40, color: Colors.black),
                ),
              ),
              const SizedBox(height: 40),
              // Sign Up Text
              Center(
                child: Text(
                  "Login!",
                  style: GoogleFonts.voces(fontSize: 40, color: Colors.black),
                ),
              ),
              // Email Input Field
              const SizedBox(height: 20),
              Text(
                "Email",
                style: GoogleFonts.voces(fontSize: 30, color: Colors.black),
              ),
              formFields.emailFormField(controller: email),
              // Password Input Field
              const SizedBox(height: 20),
              Text(
                "Password",
                style: GoogleFonts.voces(fontSize: 30, color: Colors.black),
              ),
              formFields.passwordFormField(controller: password),
              // Submit Button
              const SizedBox(height: 20),
              Center(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.green, width: 3),
                  ),
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      refresh = true;
                      setState(() {});
                      await AuthServices().checkUserExist(
                        email: email.text,
                        password: password.text,
                        context: context,
                      );
                      refresh = false;
                      setState(() {});
                    }
                  },
                  child: refresh
                      ? SizedBox(
                          width: 10,
                          height: 10,
                          child: const CircularProgressIndicator(
                            color: Colors.greenAccent,
                          ),
                        )
                      : Text(
                          "Login",
                          style: GoogleFonts.voces(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                ),
              ),
              // Regestration Page Button
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  goTo(context: context, page: RegistrationPage());
                },
                child: Center(
                  child: Text(
                    "Need To SignUp?",
                    style: GoogleFonts.voces(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
