import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'package:flutter_psu_course_review/pages/pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Center(child: PSUEventHub()),
    const Center(child: HomePage()),
    const Center(child: MyProfilePage()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/psu_event_hub.png',
              width: 130,
              height: 130,
            ),
            StatefulBuilder(builder: (context, setState) {
              return _selectedIndex == 1
                  ? TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyPostPage()),
                        );
                      },
                      child: const Text("My posts"))
                  : const SizedBox();
            }),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Navbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
