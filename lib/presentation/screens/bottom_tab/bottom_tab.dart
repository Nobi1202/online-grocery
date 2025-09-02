import 'package:flutter/material.dart';
import 'package:online_grocery/presentation/screens/account/account_screen.dart';
import 'package:online_grocery/presentation/screens/cart/cart_screen.dart';
import 'package:online_grocery/presentation/screens/explore/explore_screen.dart';
import 'package:online_grocery/presentation/screens/favourite/favourite_screen.dart';
import 'package:online_grocery/presentation/screens/shop/shop_screen.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({super.key});

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const ShopScreen(),
          const ExploreScreen(),
          const CartScreen(),
          const FavouriteScreen(),
          const AccountScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
