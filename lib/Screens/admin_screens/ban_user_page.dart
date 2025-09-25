import 'package:electrocart/Firebase/firebase_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BanUserPage extends StatefulWidget {
  const BanUserPage({super.key});

  @override
  State<BanUserPage> createState() => _BanUserPageState();
}

class _BanUserPageState extends State<BanUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Delete User"),
      ),
      body: FutureBuilder(
        future: FirebaseFunctions().getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.purple),
            );
          } else if (!snapshot.hasData) {
            return Center(child: Text("No Users Available!"));
          } else if (snapshot.hasError) {
            return Center(child: Text("An Error Happend!"));
          }
          final List<Map<String, dynamic>>? users = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...users!.map((user) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple.shade300,
                          Colors.purple.shade600,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Username: ${user['FirstName']}",
                                style: GoogleFonts.voces(fontSize: 20),
                              ),
                              Text(
                                "Email: ${user['Email']}",
                                style: GoogleFonts.voces(fontSize: 20),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () async {
                              if (user['Active']) {
                                await FirebaseFunctions().banUser(
                                  userEmail: user['Email'],
                                );
                              } else {
                                await FirebaseFunctions().unBanUser(
                                  userEmail: user['Email'],
                                );
                              }
                              setState(() {});
                            },
                            child: Text(
                              user['Active'] == true ? "Ban" : "Unban",
                              style: GoogleFonts.aBeeZee(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
