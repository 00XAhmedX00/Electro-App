import 'package:electrocart/Firebase/firebase_functions.dart';
import 'package:electrocart/Screens/admin_screens/admin_chat_user_page.dart';
import 'package:electrocart/Widgets/go_to.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsersMessagesPage extends StatelessWidget {
  const UsersMessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.purple, title: Text("Chat Page")),
      body: FutureBuilder(
        future: FirebaseFunctions().getUsersChats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Text("No Chats!");
          } else if (snapshot.hasError) {
            return const Text("An Error Happend!");
          }
          final List<Map<String, dynamic>>? chats = snapshot.data;

          return Column(
            children: [
              ...chats!.map((chat) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    onTap: () async {
                      String userId = await FirebaseFunctions().findUserId(
                        userEmail: chat['Email'],
                      );

                      if (context.mounted) {
                        goTo(
                          context: context,
                          page: AdminChatUserPage(
                            userId: userId,
                            userName:
                                "${chat['FirstName']} ${chat['LastName']}",
                          ),
                          routed: true,
                        );
                      }
                    },
                    tileColor: Colors.purple.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(15),
                      side: BorderSide(color: Colors.purple, width: 2),
                    ),
                    leading: CircleAvatar(child: Icon(Icons.person_outline)),
                    title: Text(
                      "${chat['FirstName']} ${chat['LastName']}",
                      style: GoogleFonts.voces(fontSize: 20),
                    ),
                    subtitle: Text(
                      "${chat['Email']}",
                      style: GoogleFonts.voces(fontSize: 14),
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
