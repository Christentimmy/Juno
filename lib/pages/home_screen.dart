import 'package:flutter/material.dart';
import 'package:juno/pages/first_screen.dart';
import 'package:juno/pages/fourth_screen.dart';
import 'package:juno/pages/second_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int selectedIndex = 0;

final List _pages = [
  const FirstScreen(),
  const SecondScreen(),
  const Center(
    child: Text(
      'Messages',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  const ProfileEdit(),

];

class _HomeScreenState extends State<HomeScreen> {
  void navigateTap(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: navigateTap,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 28,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_rounded,
              size: 28,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              size: 28,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 28,
            ),
            label: '',
          ),
        ],
      ),
      body: _pages[selectedIndex],
    );
  }
}
