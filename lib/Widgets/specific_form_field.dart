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
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
            border: Border.all(color: Colors.purple.withOpacity(0.3), width: 1),
          ),
          child: Row(
            children: [
              // Message input field
              Expanded(
                child: TextFormField(
                  controller: controller,
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    hintText: "Type your message...",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                  ),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                  onChanged: (value) {
                    setState(() {}); // Rebuild to update send button state
                  },
                  onFieldSubmitted: (value) {
                    if (controller.text.trim().isNotEmpty) {
                      sendMessage();
                    }
                  },
                ),
              ),

              // Send button
              Container(
                margin: EdgeInsets.only(right: 8),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      if (controller.text.trim().isNotEmpty) {
                        sendMessage();
                      }
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: controller.text.trim().isNotEmpty
                              ? [Colors.purple.shade600, Colors.purple.shade800]
                              : [Colors.grey.shade300, Colors.grey.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: controller.text.trim().isNotEmpty
                            ? [
                                BoxShadow(
                                  color: Colors.purple.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
              int.parse(value) > 100 ||
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
