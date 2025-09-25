import 'package:electrocart/Screens/cart_page.dart';
import 'package:electrocart/Screens/discount_page.dart';
import 'package:electrocart/Screens/home_page.dart';
import 'package:electrocart/Screens/profile_page.dart';
import 'package:electrocart/Screens/support_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CurvedNavigator extends StatefulWidget {
  final int index;
  const CurvedNavigator({super.key , this.index = 2});

  @override
  State<CurvedNavigator> createState() => _CurvedNavigatorState();
}

class _CurvedNavigatorState extends State<CurvedNavigator> {
  int _index = 2; // Start with Home

  @override
  void initState() {
    super.initState();
    _index = widget.index;
  }
  final List<Widget> _pages = const [
    ProfilePage(),
    DiscountPage(),
    HomePage(),
    CartPage(),
    SupportPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.person_outline, color: Colors.white, size: 32),
      const Icon(Icons.discount_outlined, color: Colors.white, size: 32),
      const Icon(Icons.home_outlined, color: Colors.white, size: 32),
      const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 32),
      const Icon(Icons.support_agent_outlined, color: Colors.white, size: 32),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 250),
        color: const Color.fromARGB(255, 126, 95, 227),
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: const Color.fromARGB(255, 60, 30, 182),
        items: items,
        index: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}
