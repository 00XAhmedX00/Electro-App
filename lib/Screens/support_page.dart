import 'package:electrocart/Firebase/firebase_functions.dart';
import 'package:electrocart/Widgets/answer_buttons.dart';
import 'package:electrocart/Widgets/button_chat.dart';
import 'package:electrocart/Widgets/specific_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final user = FirebaseAuth.instance.currentUser;
  int answer = 0;
  String? userName = "";

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  void getUserName() async {
    userName = await FirebaseFunctions().getUserName(id: user!.uid);
  }

  String sendMessage() {
    if (answer == 1) {
      return "Our return policy allows products to be returned within 7–14 days "
          "of delivery if they are unused, undamaged, and in their original packaging. Certain items such as perishable goods,"
          " digital products, and personal care items are non-returnable. Refunds will be issued to the original payment method after inspection,"
          " or an exchange will be provided if the item is defective or incorrect. Return shipping is free if the issue is caused by the seller"
          ", but customers are responsible for costs when returning items for personal reasons. To start a return, please contact customer support for approval"
          " and instructions.";
    } else if (answer == 2) {
      return "Shipment times vary depending on your location and are typically completed within **1 to 3 business days**. Once an order has been placed, it can only be canceled within the first **24 hours**; after this period, cancellations are no longer possible.";
    } else if (answer == 3) {
      return "You will find them in the discount page.";
    } else if (answer == 4) {
      return "Our Electro-App has user-friendly navigation, advanced product search and filtering, secure account management, and detailed product pages with specifications, reviews, and ratings. It should also provide shopping cart and wishlist functionality, multiple secure payment options, real-time order tracking, and personalized recommendations. Additional features like flash deals, promotional offers, customer support chat, and easy return/refund policies enhance the shopping experience, while push notifications keep users updated on new arrivals, discounts, and order status.";
    } else {
      return "Still not available!";
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController userMessage = TextEditingController();
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SpecificFormField().chatFormField(
          controller: userMessage,
          sendMessage: () async {
            if (userMessage.text.isNotEmpty) {
              await FirebaseFunctions().sendMessage(
                id: user!.uid,
                message: userMessage.text,
                sender: userName!,
              );
              userMessage.clear();
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      width: 200,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                        border: Border.all(color: Colors.purple, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            chatButton(
                              message: "Return Product",
                              updateChat: () {
                                setState(() {
                                  setState(() {
                                    answer = 1;
                                  });
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                            chatButton(
                              message: "Ask for shippment",
                              updateChat: () {
                                setState(() {
                                  setState(() {
                                    answer = 2;
                                  });
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                            chatButton(
                              message: "Deals",
                              updateChat: () {
                                setState(() {
                                  setState(() {
                                    answer = 3;
                                  });
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                            chatButton(
                              message: "App Features",
                              updateChat: () {
                                setState(() {
                                  setState(() {
                                    answer = 4;
                                  });
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                            chatButton(
                              message: "Customer service",
                              updateChat: () {
                                setState(() {
                                  setState(() {
                                    answer = 5;
                                  });
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.purple, width: 2),
                    ),
                    child: Icon(Icons.support_agent_outlined, size: 40),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (answer != 0) botAnswer(answer: sendMessage()),

              const SizedBox(height: 30),
              StreamBuilder(
                stream: FirebaseFunctions().getAllMessages(id: user!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("An Error Happend!"));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No Data!"));
                  }
                  final message = snapshot.data!.docs;
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...message.map((message) {
                          print(userName);
                          return message['Sender'] == userName
                              ? userAnswer(answer: message['Msg'])
                              : botAnswer(answer: message['Msg']);
                        }),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
