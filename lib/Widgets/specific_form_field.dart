import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecificFormField {
  // For Login and Signin
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
          hintText: "Enter your confirm password",
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

  // For Chat
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

  // For Products
  Widget productNameFormField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return SizedBox(
      width: double.maxFinite,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Enter $hintText",
          hintStyle: GoogleFonts.voces(fontSize: 15, color: Colors.black38),
          prefixIcon: Icon(Icons.shop_2_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.green, width: 3),
          ),
          filled: true,
          fillColor: const Color.fromARGB(162, 200, 230, 201),
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

  Widget productPriceFormField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return SizedBox(
      width: double.maxFinite,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Enter $hintText",
          hintStyle: GoogleFonts.voces(fontSize: 15, color: Colors.black38),
          prefixIcon: Icon(Icons.money_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.green, width: 3),
          ),
          filled: true,
          fillColor: const Color.fromARGB(162, 200, 230, 201),
        ),
        maxLength: 12,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) {
          if (value!.isEmpty) {
            return "Input required!";
          }
          return null;
        },
      ),
    );
  }

  Widget productDiscountFormField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return SizedBox(
      width: double.maxFinite,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Enter $hintText",
          hintStyle: GoogleFonts.voces(fontSize: 15, color: Colors.black38),
          prefixIcon: Icon(Icons.discount_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.green, width: 3),
          ),
          filled: true,
          fillColor: const Color.fromARGB(162, 200, 230, 201),
        ),
        maxLength: 3,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) {
          if (value!.isEmpty ||
              int.parse(value!) > 100 ||
              int.parse(value) < 0) {
            return "Discount should be between 0 and 100";
          }
          return null;
        },
      ),
    );
  }

  Widget categoryDropDownList({required TextEditingController controller}) {
    return SizedBox(
      width: double.infinity, // take full width
      child: DropdownMenu<String>(
        controller: controller,
        width: double.maxFinite, // almost full width
        menuStyle: MenuStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.white),
          elevation: MaterialStatePropertyAll(8),
          padding: MaterialStatePropertyAll(EdgeInsets.all(8)),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.green.shade300, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.green.shade300, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.green, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        hintText: "Select Category",
        dropdownMenuEntries: const [
          DropdownMenuEntry(value: "📱 Phones", label: "Phones"),
          DropdownMenuEntry(value: "📺 TV", label: "TV"),
          DropdownMenuEntry(value: "🎮 Consoles", label: "Consoles"),
          DropdownMenuEntry(value: "💻 Laptops", label: "Laptops"),
          DropdownMenuEntry(value: "🎧 Airpods", label: "Airpods"),
          DropdownMenuEntry(value: "📷 Cameras", label: "Cameras"),
        ],
      ),
    );
  }
}
