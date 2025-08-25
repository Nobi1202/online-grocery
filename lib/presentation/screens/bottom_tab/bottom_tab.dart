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
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
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

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const ShopScreen();
      case 1:
        return const ExploreScreen();
      case 2:
        return const CartScreen();
      case 3:
        return const FavouriteScreen();
      case 4:
        return const AccountScreen();
    }
    return const SizedBox.shrink();
  }
}
