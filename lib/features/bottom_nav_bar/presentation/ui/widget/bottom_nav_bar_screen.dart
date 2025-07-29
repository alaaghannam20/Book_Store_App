import 'package:bookstore_app/core/theme/colors.dart';
import 'package:bookstore_app/features/auth/book/presentation/widgets/all_books_screen.dart';
import 'package:bookstore_app/features/auth/profile/presentation/ui/profile_screen.dart';
import 'package:bookstore_app/features/bottom_nav_bar/presentation/ui/widget/bottom_nav_bar_icon.dart';
import 'package:bookstore_app/features/home/presentation/widget/home_screen.dart';
import 'package:bookstore_app/features/login/presentation/ui/widget/login_screen.dart';
import 'package:bookstore_app/features/my_cart/presentation/ui/widgets/my_cart_screen.dart';
import 'package:bookstore_app/features/search/presentation/ui/widgets/search_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 48,
        height: 48,
        child: FloatingActionButton(
          backgroundColor: AppColors.whiteColor,
          onPressed: () {    
            selectedIndex = 2;
            setState(() {});
          },
          shape: CircleBorder(),
          child: Icon(
            Icons.search,
            size: 20,
            color: selectedIndex == 2 ? AppColors.pinkprimary : AppColors.blackColor,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.whiteColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomNavBarIcon(
                isActive: selectedIndex == 0,
                onTap: () {
                  selectedIndex = 0;
                  setState(() {});
                },
                icon: Icons.home_rounded,
                labelText: 'Home'),
            BottomNavBarIcon(
                isActive: selectedIndex == 1, 
                onTap: () {
                  selectedIndex = 1;
                  setState(() {});
                },
                icon: Icons.book_outlined,
                labelText: 'Books'),
            BottomNavBarIcon(
                isActive: selectedIndex == 3,
                onTap: () {
                  selectedIndex = 3;
                  setState(() {});
                },
                icon: Icons.shopping_cart,
                labelText: 'My Cart'),
            BottomNavBarIcon(
                isActive: selectedIndex == 4,
                onTap: () {
                  selectedIndex = 4;
                  setState(() {});
                },
                icon: Icons.person_pin,
                labelText: 'Profile'),
          ],
        ),
      ),
      body: _getBody(),
    );
  }

Widget _getBody() {
  switch (selectedIndex) {
    case 0:
      return HomeScreen();
    case 1:
      return AllBooksScreen();
    
    case 2: 
      return SearchScreen();

      case 3: 
      return MyCartScreen();
      case 4: 
      return ProfileScreen();
    default:
      return Center(child: Text('Page not found'));
  }
}
}
