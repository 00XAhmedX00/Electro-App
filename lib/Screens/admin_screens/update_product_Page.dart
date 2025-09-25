import 'package:electrocart/Firebase/firebase_functions.dart';
import 'package:electrocart/Widgets/showSnackbar.dart';
import 'package:electrocart/Widgets/specific_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateProductPage extends StatelessWidget {
  final String productName;
  const UpdateProductPage({super.key, required this.productName});

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
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: Text("Add Product"),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(double.maxFinite, 50),
            backgroundColor: Colors.green.shade300,
            side: BorderSide(color: Colors.green, width: 3),
          ),
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
                showSnackbar(message: "Product Saved", context: context);
                Navigator.of(context).pop();
              }
            } else {
              showSnackbar(message: "Fill All Fields", context: context);
            }
          },
          child: Text(
            "Update Product",
            style: GoogleFonts.poppins(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text("Name", style: GoogleFonts.voces(fontSize: 30)),
                const SizedBox(height: 5),
                SpecificFormField().productNameFormField(
                  controller: name,
                  hintText: "Product Name",
                ),
                // Product Description
                const SizedBox(height: 20),
                Text("Description", style: GoogleFonts.voces(fontSize: 30)),
                const SizedBox(height: 5),
                SpecificFormField().productNameFormField(
                  controller: description,
                  hintText: "Product Description",
                ),
                // Product Price
                const SizedBox(height: 20),
                Text("Price", style: GoogleFonts.voces(fontSize: 30)),
                const SizedBox(height: 5),
                SpecificFormField().productPriceFormField(
                  controller: price,
                  hintText: "Product Price",
                ),
                // Product Discount if it has
                const SizedBox(height: 20),
                Text("Discount Rate", style: GoogleFonts.voces(fontSize: 30)),
                const SizedBox(height: 5),
                SpecificFormField().productDiscountFormField(
                  controller: discount,
                  hintText: "Product Discount (If There Is)",
                ),
                // Product Category
                const SizedBox(height: 20),
                Text("Category", style: GoogleFonts.voces(fontSize: 30)),
                const SizedBox(height: 5),
                SpecificFormField().categoryDropDownList(controller: category),
                // Image Link
                const SizedBox(height: 20),
                Text("Image Link", style: GoogleFonts.voces(fontSize: 30)),
                const SizedBox(height: 5),
                SpecificFormField().productNameFormField(
                  controller: imageUrl,
                  hintText: "Product Image Link",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
