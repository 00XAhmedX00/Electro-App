import 'package:electrocart/Screens/product_details.dart';
import 'package:electrocart/Screens/whishlist.dart';
import 'package:electrocart/Widgets/build_banner.dart';
import 'package:electrocart/Widgets/go_to.dart';
import 'package:electrocart/Widgets/product_container.dart';
import 'package:electrocart/Widgets/showSnackbar.dart';
import 'package:electrocart/cubit/product/product_logic.dart';
import 'package:electrocart/cubit/product/product_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    List<String> categoryImages = [
      "assets/images/categories/iphone.png",
      "assets/images/categories/laptop.png",
      "assets/images/products/camera.png",
      "assets/images/categories/tv.png",
      "assets/images/categories/playstation.png",
    ];
    List<Map<String, dynamic>> products = [];

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => ProductLogic()..getAllProducts(),
      child: BlocConsumer<ProductLogic, ProductState>(
        listener: (context, state) {
          if (state is GetProduct) {
            products = state.products;
          }
        },
        builder: (context, state) {
          // if(state is LoadingProduct){
          //   return const Center(child: CircularProgressIndicator(),);
          // }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo Image
                      Image.asset(
                        "assets/images/light_mode_no_bg.png",
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 10),
                      // Search
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: TextEditingController(),
                            decoration: InputDecoration(
                              hintText: "Search for product",
                              hintStyle: GoogleFonts.voces(
                                fontSize: 15,
                                color: Colors.black38,
                              ),
                              prefixIcon: Icon(Icons.search_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              filled: true,
                              fillColor: const Color.fromARGB(16, 0, 0, 0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Favourite Icon
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black12,
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              goTo(
                                context: context,
                                page: Whishlist(),
                                routed: true,
                              );
                            },
                            icon: Icon(Icons.favorite_border_outlined),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Sliding Show
                  SizedBox(
                    height: height * 0.48,
                    child: PageView(
                      children: [
                        buildBanner("assets/images/ads/ad1.png"),
                        buildBanner("assets/images/ads/ad2.png"),
                        buildBanner("assets/images/ads/ad3.png"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Categories
                  Text(
                    "Categories",
                    style: GoogleFonts.voces(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...categoryImages.map((image) {
                        return Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(20),
                            child: Image.asset(image),
                          ),
                        );
                      }),
                    ],
                  ),

                  // Discounts
                  const SizedBox(height: 20),
                  Text(
                    "Best Discounts",
                    style: GoogleFonts.voces(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  state is LoadingProduct
                      ? Center(
                          child: SizedBox(
                            width: 85,
                            height: 85,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ...products.map((product) {
                                return InkWell(
                                  onTap: () {
                                    FirebaseAuth.instance.currentUser != null
                                        ? goTo(
                                            context: context,
                                            page: ProductDetails(
                                              product: product,
                                            ),
                                            routed: true,
                                          )
                                        : showSnackbar(
                                            message: "You must be logged in",
                                            context: context,
                                          );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 3,
                                    ),
                                    child: productContainer(
                                      image: product['image'],
                                      name: product['name'],
                                      rate: product['rate'],
                                      price: product['price'],
                                      priceAfterDiscount:
                                          product['priceAfterDiscount'],
                                      context: context,
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
