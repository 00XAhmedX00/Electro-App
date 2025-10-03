import 'package:electrocart/Firebase/firebase_functions.dart';
import 'package:electrocart/Widgets/showSnackbar.dart';
import 'package:electrocart/Widgets/specific_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController description = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController discount = TextEditingController();
    TextEditingController imageUrl = TextEditingController();
    TextEditingController category = TextEditingController();

    GlobalKey<FormState> key = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: Text(
          'Add New Product',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ElevatedButton.icon(
          onPressed: () async {
            if (key.currentState!.validate() && category.text.isNotEmpty) {
              await FirebaseFunctions().saveProduct(
                category: category.text,
                description: description.text,
                discount: int.parse(discount.text),
                imageUrl: imageUrl.text,
                name: name.text,
                price: double.parse(price.text),
              );
              if (context.mounted) {
                showSnackbar(
                  message: "Product Saved Successfully!",
                  context: context,
                );
                Navigator.of(context).pop();
              }
            } else {
              showSnackbar(
                message: "Please fill all required fields",
                context: context,
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade600,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          icon: Icon(Icons.save, size: 20),
          label: Text(
            'Save Product',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade600, Colors.green.shade800],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.add_box,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Add New Product',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Fill in the product details below',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                // Form Fields
                _buildFormSection(
                  title: 'Product Name',
                  icon: Icons.shopping_bag_outlined,
                  child: SpecificFormField().productNameFormField(
                    controller: name,
                    hintText: "Enter product name",
                  ),
                ),

                _buildFormSection(
                  title: 'Description',
                  icon: Icons.description_outlined,
                  child: SpecificFormField().productNameFormField(
                    controller: description,
                    hintText: "Enter product description",
                  ),
                ),

                _buildFormSection(
                  title: 'Price',
                  icon: Icons.attach_money_outlined,
                  child: SpecificFormField().productPriceFormField(
                    controller: price,
                    hintText: "Enter product price",
                  ),
                ),

                _buildFormSection(
                  title: 'Discount Rate (%)',
                  icon: Icons.discount_outlined,
                  child: SpecificFormField().productDiscountFormField(
                    controller: discount,
                    hintText: "Enter discount percentage",
                  ),
                ),

                _buildFormSection(
                  title: 'Category',
                  icon: Icons.category_outlined,
                  child: SpecificFormField().categoryDropDownList(
                    controller: category,
                  ),
                ),

                _buildFormSection(
                  title: 'Image URL',
                  icon: Icons.image_outlined,
                  child: SpecificFormField().productNameFormField(
                    controller: imageUrl,
                    hintText: "Enter product image URL",
                  ),
                ),

                SizedBox(height: 100), // Space for floating action button
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.green, size: 20),
              ),
              SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
