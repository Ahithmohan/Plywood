import 'package:dot_curved_bottom_nav/dot_curved_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:plywood/screens/add_product_page.dart';
import 'package:plywood/screens/category_page.dart';
import 'package:plywood/screens/home_view_page.dart';
import 'package:plywood/screens/profile_page.dart';
import 'package:plywood/screens/purchase_page.dart';
import 'package:plywood/screens/stock_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final ScrollController _scrollController = ScrollController();
  late List<Widget> _pages;

  // final List<Widget> _pages = [
  //   HomeViewPage(
  //     scrollController: _scrollController,
  //   ),
  //   const CategoryPage(),
  //   const StockPage(),
  //   const SettingsPage(),
  //   const ProfilePage()
  // ];
  @override
  void initState() {
    super.initState();
    _pages = [
      HomeViewPage(
        scrollController: _scrollController,
      ),
      const CategoryPage(),
      const AddProductPage(),
      StockPage(
        scrollController: _scrollController,
      ),
      const PurchasePage(),
      const ProfilePage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_currentPage],
      bottomNavigationBar: DotCurvedBottomNav(
        scrollController: _scrollController,
        hideOnScroll: true,
        indicatorColor: Colors.orange,
        backgroundColor: Colors.black,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.ease,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        selectedIndex: _currentPage,
        indicatorSize: 5,
        borderRadius: 25,
        height: 70,
        onTap: (index) {
          setState(() => _currentPage = index);
        },
        items: [
          Icon(
            Icons.home,
            color: _currentPage == 0 ? Colors.orange : Colors.white,
          ),
          Icon(
            Icons.category,
            color: _currentPage == 1 ? Colors.orange : Colors.white,
          ),
          Icon(
            Icons.add_to_photos,
            color: _currentPage == 2 ? Colors.orange : Colors.white,
          ),
          Icon(
            Icons.list_alt_outlined,
            color: _currentPage == 3 ? Colors.orange : Colors.white,
          ),
          Icon(Icons.shopping_cart,
              color: _currentPage == 4 ? Colors.orange : Colors.white),
          Icon(
            Icons.person,
            color: _currentPage == 5 ? Colors.orange : Colors.white,
          ),
        ],
      ),
    );
  }
}
