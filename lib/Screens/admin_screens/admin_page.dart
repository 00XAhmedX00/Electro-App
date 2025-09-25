import 'package:electrocart/Screens/admin_screens/add_product_page.dart';
import 'package:electrocart/Screens/admin_screens/all_products.dart';
import 'package:electrocart/Screens/admin_screens/ban_user_page.dart';
import 'package:electrocart/Screens/admin_screens/users_messages_page.dart';
import 'package:electrocart/Screens/login_page.dart';
import 'package:electrocart/Widgets/admin_page_buttons.dart';
import 'package:electrocart/Widgets/go_to.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade200,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Admin Page",
            style: GoogleFonts.voces(
              shadows: [Shadow(color: Colors.black, blurRadius: 10)],
              color: Colors.white,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Add Product
              adminPageButton(
                context: context,
                text: "Add Product",
                page: AddProductPage(),
              ),
              // All Products
              adminPageButton(
                context: context,
                text: "All Products",
                page: AllProducts(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Delete User
              adminPageButton(
                context: context,
                text: "Delete User",
                page: BanUserPage(),
              ),
              // User Messages
              adminPageButton(
                context: context,
                text: "Chats",
                page: UsersMessagesPage(),
              ),
            ],
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              side: BorderSide(color: Colors.white, width: 2),
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              goTo(context: context, page: LoginPage());
            },
            child: Text(
              "Sign Out",
              style: GoogleFonts.voces(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
