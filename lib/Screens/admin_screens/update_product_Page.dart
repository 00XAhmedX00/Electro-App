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
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: Text("Update Product"),
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
                showSnackbar(message: "Product Saved", context: context);
                update();
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
            child: FutureBuilder(
              future: FirebaseFunctions().getProductData(
                productName: productName,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.green),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("An Error Happend!"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      "No Data Found!",
                      style: GoogleFonts.voces(fontWeight: FontWeight.bold),
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
                    Text(
                      "Discount Rate",
                      style: GoogleFonts.voces(fontSize: 30),
                    ),
                    const SizedBox(height: 5),
                    SpecificFormField().productDiscountFormField(
                      controller: discount,
                      hintText: "Product Discount (If There Is)",
                    ),
                    // Product Category
                    const SizedBox(height: 20),
                    Text("Category", style: GoogleFonts.voces(fontSize: 30)),
                    const SizedBox(height: 5),
                    SpecificFormField().categoryDropDownList(
                      controller: category,
                    ),
                    // Image Link
                    const SizedBox(height: 20),
                    Text("Image Link", style: GoogleFonts.voces(fontSize: 30)),
                    const SizedBox(height: 5),
                    SpecificFormField().productNameFormField(
                      controller: imageUrl,
                      hintText: "Product Image Link",
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
