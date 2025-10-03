import 'package:electrocart/Firebase/firebase_functions.dart';
import 'package:electrocart/Widgets/showSnackbar.dart';
import 'package:electrocart/Widgets/specific_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateProductPage extends StatelessWidget {
  final String productName;
  final void Function() update;
  const UpdateProductPage({
    super.key,
    required this.productName,
    required this.update,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController description = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController discount = TextEditingController();
    TextEditingController imageUrl = TextEditingController();
    TextEditingController category = TextEditingController();
    double rate = 0;
    GlobalKey<FormState> key = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: Text(
          'Update Product',
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
              await FirebaseFunctions().updateProduct(
                category: category.text,
                description: description.text,
                discount: int.parse(discount.text),
                imageUrl: imageUrl.text,
                name: name.text,
                price: double.parse(price.text),
                rate: rate,
              );
              if (context.mounted) {
                showSnackbar(
                  message: "Product Updated Successfully!",
                  context: context,
                );
                update();
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
            backgroundColor: Colors.blue.shade600,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          icon: Icon(Icons.update, size: 20),
          label: Text(
            'Update Product',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Form(
          key: key,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: FutureBuilder(
              future: FirebaseFunctions().getProductData(
                productName: productName,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, color: Colors.red, size: 64),
                        SizedBox(height: 16),
                        Text(
                          "An error occurred!",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          color: Colors.grey[400],
                          size: 64,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "No product data found!",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final Map<String, dynamic>? product = snapshot.data;
                name.text = product!['name'];
                description.text = product['description'];
                price.text = product['price'].toString();
                discount.text =
                    (((product['price'] - product['priceAfterDiscount']) /
                                product['price']) *
                            100)
                        .toStringAsFixed(0);
                imageUrl.text = product['image'];
                category.text = product['category'] ?? "";
                rate = product['rate'];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade600, Colors.blue.shade800],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
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
                              Icons.update,
                              size: 32,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Update Product',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Modify the product details below',
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
                );
              },
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
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.blue, size: 20),
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
