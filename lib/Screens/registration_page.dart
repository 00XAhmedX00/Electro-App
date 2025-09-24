import 'package:electrocart/Firebase/auth_services.dart';
import 'package:electrocart/Widgets/specific_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  SpecificFormField formFields = SpecificFormField();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

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
                  "Welcome!",
                  style: GoogleFonts.voces(fontSize: 40, color: Colors.black),
                ),
              ),
              const SizedBox(height: 40),
              // Sign Up Text
              Center(
                child: Text(
                  "Sign Up!",
                  style: GoogleFonts.voces(fontSize: 40, color: Colors.black),
                ),
              ),
              // First Name Input Field
              const SizedBox(height: 20),
              Text(
                "First Name",
                style: GoogleFonts.voces(fontSize: 30, color: Colors.black),
              ),
              formFields.nameFormField(
                controller: firstName,
                hintText: "first name",
              ),
              // Last Name Input Field
              const SizedBox(height: 20),
              Text(
                "Last Name",
                style: GoogleFonts.voces(fontSize: 30, color: Colors.black),
              ),
              formFields.nameFormField(
                controller: lastName,
                hintText: "last name",
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
              // Confirm Password Input Field
              const SizedBox(height: 20),
              Text(
                "Confirm Password",
                style: GoogleFonts.voces(fontSize: 30, color: Colors.black),
              ),
              formFields.confirPasswordFormField(
                controller: confirmPassword,
                actualPassword: password,
              ),
              // Submit Button
              const SizedBox(height: 20),
              Center(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.green, width: 3),
                  ),
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      AuthServices().addUser(
                        email: email.text,
                        password: password.text,
                      );
                    }
                  },
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.voces(fontSize: 15, color: Colors.black),
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
