import 'package:electrocart/Widgets/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> products = [
    {
      "image": "assets/images/products/adapter.png",
      "name": "Adapter",
      "price": 40.00,
      "category": "Accessories",
      "count": 1,
    },
    {
      "image": "assets/images/products/airpods.png",
      "name": "Wireless Mouse",
      "price": 150.00,
      "category": "Electronics",
      "count": 1,
    },
    {
      "image": "assets/images/products/camera.png",
      "name": "Mechanical Keyboard",
      "price": 600.00,
      "category": "Electronics",
      "count": 1,
    },
    {
      "image": "assets/images/products/smart_watch.png",
      "name": "Phone Charger",
      "price": 120.00,
      "category": "Accessories",
      "count": 1,
    },
    {
      "image": "assets/images/products/tv.png",
      "name": "Headphones",
      "price": 300.00,
      "category": "Audio",
      "count": 1,
    },
  ];

  void add(int index) {
    setState(() {
      products[index]['count']++;
    });
  }

  void remove(int index) {
    setState(() {
      if (products[index]['count'] == 1) {
        products.removeAt(index);
      } else {
        products[index]['count']--;
      }
    });
  }

  void delete(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cart Title
            Padding(
              
              padding: const EdgeInsets.all(25.0),
              child: Text(
                'View Cart',
                style: GoogleFonts.voces(
                  color: Color(0xFF9C27B0),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCart(
                    product: products[index],
                    onDelete: () => delete(index),
                    onAdd: () => add(index),
                    onRemove: () => remove(index),
                  );
                },
              ),
            ),

            // Product Cart
          ],
        ),
      ),
    );
  }
}
