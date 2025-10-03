import 'package:electrocart/Firebase/firebase_functions.dart';
import 'package:electrocart/Widgets/specific_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  int answer = 0;
  String? userName = "";

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  void getUserName() async {
    userName = await FirebaseFunctions().getUserName(
      id: FirebaseAuth.instance.currentUser!.uid,
    );
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
      return "Please Login To Use This Feature!";
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController userMessage = TextEditingController();
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: Text(
          'Customer Support',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton:
          answer == 5 && FirebaseAuth.instance.currentUser != null
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SpecificFormField().chatFormField(
                controller: userMessage,
                sendMessage: () async {
                  if (userMessage.text.isNotEmpty) {
                    await FirebaseFunctions().sendMessage(
                      id: FirebaseAuth.instance.currentUser!.uid,
                      message: userMessage.text,
                      sender: userName!,
                    );
                  }
                  userMessage.clear();
                },
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple.shade600, Colors.purple.shade800],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.support_agent,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'How can we help you?',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Choose from our quick support options or chat with our team',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Quick Support Options
              Text(
                'Quick Support',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16),

              // Support Options Grid
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: isTablet ? 3 : 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: isTablet ? 1.2 : 1.1,
                children: [
                  _buildSupportOption(
                    icon: Icons.undo_outlined,
                    title: 'Returns & Refunds',
                    subtitle: 'Return policy info',
                    onTap: () => setState(() => answer = 1),
                    color: Colors.blue,
                  ),
                  _buildSupportOption(
                    icon: Icons.local_shipping_outlined,
                    title: 'Shipping Info',
                    subtitle: 'Delivery times',
                    onTap: () => setState(() => answer = 2),
                    color: Colors.green,
                  ),
                  _buildSupportOption(
                    icon: Icons.local_offer_outlined,
                    title: 'Deals & Offers',
                    subtitle: 'Current promotions',
                    onTap: () => setState(() => answer = 3),
                    color: Colors.orange,
                  ),
                  _buildSupportOption(
                    icon: Icons.apps_outlined,
                    title: 'App Features',
                    subtitle: 'Feature guide',
                    onTap: () => setState(() => answer = 4),
                    color: Colors.teal,
                  ),
                  _buildSupportOption(
                    icon: Icons.chat_outlined,
                    title: 'Live Chat',
                    subtitle: 'Talk to support',
                    onTap: () => setState(() => answer = 5),
                    color: Colors.purple,
                    isFullWidth: !isTablet,
                  ),
                ],
              ),

              SizedBox(height: 24),

              // Response Section
              if (answer != 0 && answer != 5) _buildResponseCard(sendMessage()),

              if (answer == 5 && FirebaseAuth.instance.currentUser == null)
                _buildResponseCard(sendMessage()),

              if (answer == 5 && FirebaseAuth.instance.currentUser != null)
                _buildChatInterface(),

              SizedBox(height: 100), // Space for floating action button
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
    bool isFullWidth = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              SizedBox(height: 12),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResponseCard(String message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.support_agent,
                  color: Colors.purple,
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Support Response',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            message,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatInterface() {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Chat Header
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.support_agent,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  'Customer Service Chat',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Online',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Chat Messages
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFunctions().getAllMessages(
                id: FirebaseAuth.instance.currentUser != null
                    ? FirebaseAuth.instance.currentUser!.uid
                    : 'empty',
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, color: Colors.red, size: 48),
                        SizedBox(height: 16),
                        Text(
                          "An error occurred!",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.grey[400],
                          size: 48,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Start a conversation with our support team",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Type your message below ⬇️",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final messages = snapshot.data!.docs;
                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isUser = message['Sender'] == userName;

                    return Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Row(
                        mainAxisAlignment: isUser
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isUser) ...[
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                Icons.support_agent,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            SizedBox(width: 8),
                          ],
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: isUser
                                    ? Colors.purple
                                    : Colors.grey[100],
                                borderRadius: BorderRadius.circular(16)
                                    .copyWith(
                                      bottomLeft: isUser
                                          ? Radius.circular(16)
                                          : Radius.circular(4),
                                      bottomRight: isUser
                                          ? Radius.circular(4)
                                          : Radius.circular(16),
                                    ),
                              ),
                              child: Text(
                                message['Msg'],
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: isUser ? Colors.white : Colors.black87,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),
                          if (isUser) ...[
                            SizedBox(width: 8),
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                Icons.person,
                                color: Colors.grey[600],
                                size: 18,
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
