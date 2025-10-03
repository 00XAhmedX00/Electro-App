import 'package:electrocart/Firebase/firebase_functions.dart';
import 'package:electrocart/Screens/user_screens/change_name_page.dart';
import 'package:electrocart/Screens/user_screens/change_password_page.dart';
import 'package:electrocart/Screens/login_page.dart';
import 'package:electrocart/Screens/registration_page.dart';
import 'package:electrocart/Widgets/display_buttom_container.dart';
import 'package:electrocart/Widgets/go_to.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: height * 0.46,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xFF9C27B0), Color(0xFFE040FB)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      future: FirebaseFunctions().getUser(
                        id: FirebaseAuth.instance.currentUser != null
                            ? FirebaseAuth.instance.currentUser!.uid
                            : "empty",
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text("An Error Happend!"));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Column(
                            children: [
                              Text(
                                "No Account Yet?",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                ),
                              ),
                              Center(
                                child: Image.asset(
                                  "assets/images/think.png",
                                  width: 150,
                                  height: 150,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  // Login Button
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      side: BorderSide(
                                        color: const Color.fromARGB(
                                          255,
                                          103,
                                          30,
                                          115,
                                        ),
                                        width: 2,
                                      ),
                                    ),
                                    onPressed: () {
                                      goTo(context: context, page: LoginPage());
                                    },
                                    child: Text(
                                      "Login",
                                      style: GoogleFonts.voces(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                  // Sign Up Button
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      maximumSize: Size(width, height),
                                      side: BorderSide(
                                        color: const Color.fromARGB(
                                          255,
                                          103,
                                          30,
                                          115,
                                        ),
                                        width: 2,
                                      ),
                                    ),
                                    onPressed: () {
                                      goTo(
                                        context: context,
                                        page: RegistrationPage(),
                                      );
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: GoogleFonts.voces(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 150),
                              // Policies
                              Positioned(
                                top: height * 0.65,
                                left: width * 0.01,
                                right: width * 0.05,

                                child: Column(
                                  children: [
                                    // What Is ElectroCart
                                    Card(
                                      child: ListTile(
                                        onTap: () {
                                          displayModalBottomSheet(
                                            context: context,
                                            header: "What Is ElectroCart",
                                            message:
                                                "Our Electro-App has user-friendly navigation, advanced product search and filtering, secure account management, and detailed product pages with specifications, reviews, and ratings. It should also provide shopping cart and wishlist functionality, multiple secure payment options, real-time order tracking, and personalized recommendations. Additional features like flash deals, promotional offers, customer support chat, and easy return/refund policies enhance the shopping experience, while push notifications keep users updated on new arrivals, discounts, and order status.",
                                          );
                                        },
                                        leading: ClipOval(
                                          child: Image.asset(
                                            'assets/images/light_mode_no_bg.png',
                                            width: 115,
                                            height: 110,
                                            fit: BoxFit.cover,
                                          ),
                                        ),

                                        title: Text(
                                          'What Is ElectroCart',
                                          style: GoogleFonts.voces(
                                            fontSize: 20,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 10),
                                    // Refund Policy
                                    Card(
                                      child: ListTile(
                                        onTap: () {
                                          displayModalBottomSheet(
                                            context: context,
                                            message:
                                                "Our return policy allows products to be returned within 7–14 days "
                                                "of delivery if they are unused, undamaged, and in their original packaging. Certain items such as perishable goods,"
                                                " digital products, and personal care items are non-returnable. Refunds will be issued to the original payment method after inspection,"
                                                " or an exchange will be provided if the item is defective or incorrect. Return shipping is free if the issue is caused by the seller"
                                                ", but customers are responsible for costs when returning items for personal reasons. To start a return, please contact customer support for approval"
                                                " and instructions.",
                                            header: "Refund Policy",
                                          );
                                        },
                                        leading: ClipOval(
                                          child: Container(
                                            width: 115,
                                            height: 110,
                                            color: Colors.transparent,
                                            child: Icon(
                                              Icons.shield_outlined,
                                              size: 55,
                                            ),
                                          ),
                                        ),

                                        title: Text(
                                          'Refund Policy',
                                          style: GoogleFonts.voces(
                                            fontSize: 20,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 10),
                                    // Privacy Policy
                                    Card(
                                      child: ListTile(
                                        onTap: () {
                                          displayModalBottomSheet(
                                            context: context,
                                            message:
                                                "At ElectroApp, we respect your privacy and are committed to protecting"
                                                " your personal data. When you use our app, we may collect information such as"
                                                " your name, email address, contact details, payment information, and purchase"
                                                " history to process orders, provide customer support, and improve your shopping"
                                                " experience. Your information is stored securely and will only be shared with"
                                                " trusted service providers (such as payment processors and delivery partners)"
                                                " to complete transactions or as required by law. We never sell your personal"
                                                " information to third parties, and by using our app you consent to the collection"
                                                " and use of your data in line with this Privacy Policy.",
                                            header: "Privacy Policy",
                                          );
                                        },
                                        leading: ClipOval(
                                          child: Container(
                                            width: 115,
                                            height: 110,
                                            color: Colors.transparent,
                                            child: Icon(
                                              Icons.privacy_tip_outlined,
                                              size: 55,
                                            ),
                                          ),
                                        ),

                                        title: Text(
                                          'Privacy Policy',
                                          style: GoogleFonts.voces(
                                            fontSize: 20,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                        final Map<String, dynamic>? userData = snapshot.data;
                        return Column(
                          children: [
                            CircleAvatar(
                              maxRadius: 40,
                              foregroundColor: Colors.purple,
                              child: Icon(Icons.person_outline, size: 40),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "${userData!['FirstName']} ${userData['LastName']}",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                              ),
                            ),
                            Text(
                              "${userData['Email']}",
                              style: GoogleFonts.poppins(
                                color: Colors.black26,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // Change Name Button
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    side: BorderSide(
                                      color: const Color.fromARGB(
                                        255,
                                        103,
                                        30,
                                        115,
                                      ),
                                      width: 2,
                                    ),
                                  ),
                                  onPressed: () {
                                    goTo(
                                      context: context,
                                      page: ChangeName(
                                        userId: FirebaseAuth
                                            .instance
                                            .currentUser!
                                            .uid,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Change Name",
                                    style: GoogleFonts.voces(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                // Change Password Button
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    maximumSize: Size(width, height),
                                    side: BorderSide(
                                      color: const Color.fromARGB(
                                        255,
                                        103,
                                        30,
                                        115,
                                      ),
                                      width: 2,
                                    ),
                                  ),
                                  onPressed: () {
                                    goTo(
                                      context: context,
                                      page: ChangePasswordPage(
                                        userId: FirebaseAuth
                                            .instance
                                            .currentUser!
                                            .uid,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Change Password",
                                    style: GoogleFonts.voces(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Sign Out Button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange.shade900,
                                maximumSize: Size(width, height),
                                side: BorderSide(
                                  color: const Color.fromARGB(
                                    255,
                                    103,
                                    30,
                                    115,
                                  ),
                                  width: 2,
                                ),
                              ),
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut();

                                setState(() {});
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
                        );
                      },
                    ),
                    if (FirebaseAuth.instance.currentUser != null)
                      const SizedBox(height: 150),
                    // Policies
                    if (FirebaseAuth.instance.currentUser != null)
                      Positioned(
                        top: height * 0.65,
                        left: width * 0.01,
                        right: width * 0.05,

                        child: Column(
                          children: [
                            // What Is ElectroCart
                            Card(
                              child: ListTile(
                                onTap: () {
                                  displayModalBottomSheet(
                                    context: context,
                                    header: "What Is ElectroCart",
                                    message:
                                        "Our Electro-App has user-friendly navigation, advanced product search and filtering, secure account management, and detailed product pages with specifications, reviews, and ratings. It should also provide shopping cart and wishlist functionality, multiple secure payment options, real-time order tracking, and personalized recommendations. Additional features like flash deals, promotional offers, customer support chat, and easy return/refund policies enhance the shopping experience, while push notifications keep users updated on new arrivals, discounts, and order status.",
                                  );
                                },
                                leading: ClipOval(
                                  child: Image.asset(
                                    'assets/images/light_mode_no_bg.png',
                                    width: 115,
                                    height: 110,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                title: Text(
                                  'What Is ElectroCart',
                                  style: GoogleFonts.voces(
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 10),
                            // Refund Policy
                            Card(
                              child: ListTile(
                                onTap: () {
                                  displayModalBottomSheet(
                                    context: context,
                                    message:
                                        "Our return policy allows products to be returned within 7–14 days "
                                        "of delivery if they are unused, undamaged, and in their original packaging. Certain items such as perishable goods,"
                                        " digital products, and personal care items are non-returnable. Refunds will be issued to the original payment method after inspection,"
                                        " or an exchange will be provided if the item is defective or incorrect. Return shipping is free if the issue is caused by the seller"
                                        ", but customers are responsible for costs when returning items for personal reasons. To start a return, please contact customer support for approval"
                                        " and instructions.",
                                    header: "Refund Policy",
                                  );
                                },
                                leading: ClipOval(
                                  child: Container(
                                    width: 115,
                                    height: 110,
                                    color: Colors.transparent,
                                    child: Icon(
                                      Icons.shield_outlined,
                                      size: 55,
                                    ),
                                  ),
                                ),

                                title: Text(
                                  'Refund Policy',
                                  style: GoogleFonts.voces(
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 10),
                            // Privacy Policy
                            Card(
                              child: ListTile(
                                onTap: () {
                                  displayModalBottomSheet(
                                    context: context,
                                    message:
                                        "At ElectroApp, we respect your privacy and are committed to protecting"
                                        " your personal data. When you use our app, we may collect information such as"
                                        " your name, email address, contact details, payment information, and purchase"
                                        " history to process orders, provide customer support, and improve your shopping"
                                        " experience. Your information is stored securely and will only be shared with"
                                        " trusted service providers (such as payment processors and delivery partners)"
                                        " to complete transactions or as required by law. We never sell your personal"
                                        " information to third parties, and by using our app you consent to the collection"
                                        " and use of your data in line with this Privacy Policy.",
                                    header: "Privacy Policy",
                                  );
                                },
                                leading: ClipOval(
                                  child: Container(
                                    width: 115,
                                    height: 110,
                                    color: Colors.transparent,
                                    child: Icon(
                                      Icons.privacy_tip_outlined,
                                      size: 55,
                                    ),
                                  ),
                                ),

                                title: Text(
                                  'Privacy Policy',
                                  style: GoogleFonts.voces(
                                    fontSize: 20,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
