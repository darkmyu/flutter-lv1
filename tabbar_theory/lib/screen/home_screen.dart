import 'package:flutter/material.dart';
import 'package:tabbar_theory/screen/appbar_using_controller_screen.dart';
import 'package:tabbar_theory/screen/basic_appbar_tabbar_screen.dart';
import 'package:tabbar_theory/screen/bottom_navigation_bar_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const BasicAppbarTabbarScreen(),
                  ),
                );
              },
              child: const Text('Basic AppBar TabBar Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const AppbarUsingControllerScreen(),
                  ),
                );
              },
              child: const Text('AppBar Using Controller Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const BottomNavigationBarScreen(),
                  ),
                );
              },
              child: const Text('Bottom Navigation Bar Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
