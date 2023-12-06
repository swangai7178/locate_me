import 'package:flutter/material.dart';
import 'package:locate_me/screens/chats.dart';
import 'package:locate_me/screens/dashboard.dart';
import 'package:locate_me/screens/directions.dart';
import 'package:locate_me/screens/safety.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final List<Widget> _tablist = [
    const MyDashBoard(),
    const Direction(),
    const Safety(),
    const ChatsPage()
    
  ];
  int indexpage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Stack(children: [
        _tablist.elementAt(indexpage),
        
        Padding(
          padding: const EdgeInsets.all(0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: BottomNavigationBar(
                backgroundColor: const Color.fromARGB(255, 226, 226, 226),
                selectedItemColor: const Color.fromARGB(255, 255, 153, 0),
                unselectedItemColor: Colors.grey,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                currentIndex: indexpage,
                onTap: (int index) {
                  
                  setState(() {
                    indexpage = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.map,
                      size: 24,
                    ),
                    label: "Location",
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.directions_transit, size: 24),
                      label: "Direction"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.safety_check, size: 24),
                      label: "Safety"),
                 
                  BottomNavigationBarItem(
                      icon: Icon(Icons.chat_outlined, size: 24),
                      label: "chat"),
                ],
              ),
            ),
          ),
        )
      ]),
    );
    
  }
}