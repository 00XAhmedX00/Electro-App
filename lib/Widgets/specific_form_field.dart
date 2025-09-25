import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecificFormField {
  Widget nameFormField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return SizedBox(
      width: double.maxFinite,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Enter your $hintText",
          hintStyle: GoogleFonts.voces(fontSize: 15, color: Colors.black38),
          prefixIcon: Icon(Icons.account_box_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.green, width: 3),
          ),
          filled: true,
          fillColor: Colors.white54,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Input required!";
          } else if (value.length < 3) {
            return "Length of name should be at least 3!";
          }
          return null;
        },
      ),
    );
  }

  Widget emailFormField({required TextEditingController controller}) {
    return SizedBox(
      width: double.maxFinite,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Enter your email",
          hintStyle: GoogleFonts.voces(fontSize: 15, color: Colors.black38),
          prefixIcon: Icon(Icons.email_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.green, width: 3),
          ),
          filled: true,
          fillColor: Colors.white54,
        ),
        validator: (value) {
          final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
          if (value!.isEmpty) {
            return "Input required!";
          } else if (!emailRegex.hasMatch(value)) {
            return "Email not valid!";
          }
          return null;
        },
      ),
    );
  }

  Widget passwordFormField({required TextEditingController controller}) {
    return SizedBox(
      width: double.maxFinite,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Enter your password",
          hintStyle: GoogleFonts.voces(fontSize: 15, color: Colors.black38),
          prefixIcon: Icon(Icons.password_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.green, width: 3),
          ),
          filled: true,
          fillColor: Colors.white54,
        ),
        validator: (value) {
          final regExp = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
          if (value!.isEmpty) {
            return "Input required!";
          } else if (value.length < 6) {
            return "Length of password should be at least 6!";
          } else if (!regExp.hasMatch(value)) {
            return "Password should contains special character!";
          }
          return null;
        },
        obscureText: true,
      ),
    );
  }

  Widget confirPasswordFormField({
    required TextEditingController controller,
    required TextEditingController actualPassword,
  }) {
    return SizedBox(
      width: double.maxFinite,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Enter your password",
          hintStyle: GoogleFonts.voces(fontSize: 15, color: Colors.black38),
          prefixIcon: Icon(Icons.password_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.green, width: 3),
          ),
          filled: true,
          fillColor: Colors.white54,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Input required!";
          } else if (value.length < 6) {
            return "Length of password should be at least 6!";
          } else if (controller.text != actualPassword.text) {
            return "The two passwords not matched!";
          }
          return null;
        },
        obscureText: true,
      ),
    );
  }

  Widget chatFormField({
    required TextEditingController controller,
    required Function sendMessage,
  }) {
    return SizedBox(
      width: double.maxFinite,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Enter a Message...",
          hintStyle: GoogleFonts.voces(fontSize: 15, color: Colors.black38),
          prefixIcon: Icon(Icons.message_outlined),
          suffixIcon: IconButton(
            onPressed: () {
              sendMessage();
            },
            icon: Icon(Icons.send_outlined),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.purple, width: 3),
          ),
          filled: true,
          fillColor: Colors.purple.shade100,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter a Message!";
          }
          return null;
        },
      ),
    );
  }
}
