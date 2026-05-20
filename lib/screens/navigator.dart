import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:diskominfo_test/services/provider/auth_provider.dart';

import 'package:diskominfo_test/screens/home/home_screen.dart';

import 'package:diskominfo_test/screens/riwayat/riwayat_screen.dart';

class NavigatorScreen
    extends StatefulWidget {

  const NavigatorScreen({
    super.key,
  });

  @override
  State<NavigatorScreen>
      createState() {

    return _NavigatorScreenState();
  }
}

class _NavigatorScreenState
    extends State<NavigatorScreen> {

  int _selectedIndex = 0;

  final List<Widget> _pages = [

    const HomeScreen(),

    const RiwayatScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title:
            const Text("Diskominfo"),

        actions: [

          IconButton(

            onPressed: () {

              context
                  .read<AuthProvider>()
                  .signOut();
            },

            icon:
                const Icon(Icons.logout),
          ),
        ],
      ),

      body: _pages[_selectedIndex],

      bottomNavigationBar:
          BottomNavigationBar(

        currentIndex:
            _selectedIndex,

        onTap: (index) {

          setState(() {

            _selectedIndex =
                index;
          });
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "Riwayat",
          ),
        ],
      ),
    );
  }
}