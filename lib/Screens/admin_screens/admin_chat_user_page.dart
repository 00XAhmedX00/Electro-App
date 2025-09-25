import 'package:electrocart/Firebase/firebase_functions.dart';
import 'package:electrocart/Widgets/answer_buttons.dart';
import 'package:electrocart/Widgets/specific_form_field.dart';
import 'package:flutter/material.dart';

class AdminChatUserPage extends StatefulWidget {
  final String userId;
  final String userName;
  const AdminChatUserPage({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  State<AdminChatUserPage> createState() => _AdminChatUserPageState();
}

class _AdminChatUserPageState extends State<AdminChatUserPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Message Page"),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SpecificFormField().chatFormField(
          controller: controller,
          sendMessage: () async {
            if (controller.text.isNotEmpty) {
              await FirebaseFunctions().sendMessage(
                id: widget.userId,
                message: controller.text,
                sender: "Admin",
              );
              controller.clear();
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
        stream: FirebaseFunctions().getAllMessages(id: widget.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Text("No Messages!");
          } else if (snapshot.hasError) {
            return const Text("An Error Happend!");
          }

          final message = snapshot.data!.docs;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...message.map((message) {
                    return message['Sender'] == widget.userName
                        ? userAnswer(answer: message['Msg'])
                        : botAnswer(answer: message['Msg']);
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
