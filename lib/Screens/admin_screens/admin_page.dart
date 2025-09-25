import 'package:electrocart/Screens/admin_screens/ban_user_page.dart';
import 'package:electrocart/Screens/admin_screens/users_messages_page.dart';
import 'package:electrocart/Widgets/go_to.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.topLeft,
            end: AlignmentGeometry.bottomRight,
            colors: [Colors.purple, Colors.black],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Delete User
                  GestureDetector(
                    onTap: () {
                      goTo(context: context, page: BanUserPage(), routed: true);
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple.shade300,
                            Colors.purple.shade600,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Delete User",
                          style: GoogleFonts.aBeeZee(color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  // User Messages
                  GestureDetector(
                    onTap: () {
                      goTo(
                        context: context,
                        page: UsersMessagesPage(),
                        routed: true,
                      );
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple.shade300,
                            Colors.purple.shade600,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "User Messages",
                            style: GoogleFonts.aBeeZee(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
