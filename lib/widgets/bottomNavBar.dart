import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hapii/screens/homescreen.dart';
import 'package:hapii/screens/profilescreen.dart';
import 'package:hapii/screens/calendarscreen.dart'; // Updated import
import 'package:hapii/services/const.dart';
import 'package:unicons/unicons.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar(this.replace, this.screen, {super.key});
  bool replace = false;
  Widget screen;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _index = 0;

  // Updated list of screens: index 1 now directs to CalendarScreen.
  final List<Widget> _screens = [
    const HomeScreen(),
    CalendarScreen(), // Replaced SearchScreen with CalendarScreen.
    const ProfileScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      widget.replace = false;
      HapticFeedback.mediumImpact();
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine if the current route can go back
    bool canPop = Navigator.canPop(context);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: widget.replace ? widget.screen : _screens[_index],
      bottomNavigationBar: Container(
        height: 56,
        width: size.width,
        color: kPrimaryBlack,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left arrow button for going back; disabled if cannot pop
            IconButton(
              onPressed: canPop
                  ? () {
                      Navigator.pop(context);
                    }
                  : null,
              icon: const Icon(
                Icons.arrow_back,
              ),
              color: canPop ? Colors.white : Colors.grey, // visually indicate disabled state
            ),
            // Home button (index 0)
            Stack(alignment: Alignment.center, children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                height: 32,
                width: _index == 0 ? 64 : 0,
                decoration: BoxDecoration(
                  color: kAccentGreen,
                  borderRadius: BorderRadius.circular(51),
                ),
              ),
              IconButton(
                onPressed: () {
                  onTabTapped(0);
                },
                icon: const Icon(UniconsLine.home_alt),
                color: _index == 0 ? kPrimaryBlack : Colors.white,
              ),
            ]),
            // Calendar button (index 1) replacing search icon
            Stack(alignment: Alignment.center, children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                height: 32,
                width: _index == 1 ? 64 : 0,
                decoration: BoxDecoration(
                  color: kAccentGreen,
                  borderRadius: BorderRadius.circular(51),
                ),
              ),
              IconButton(
                onPressed: () {
                  onTabTapped(1);
                },
                icon: const Icon(UniconsLine.calendar_alt),
                color: _index == 1 ? kPrimaryBlack : Colors.white,
              ),
            ]),
            // Profile button (index 2)
            Stack(alignment: Alignment.center, children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                height: 32,
                width: _index == 2 ? 64 : 0,
                decoration: BoxDecoration(
                  color: kAccentGreen,
                  borderRadius: BorderRadius.circular(51),
                ),
              ),
              IconButton(
                onPressed: () {
                  onTabTapped(2);
                },
                icon: const Icon(UniconsLine.user),
                color: _index == 2 ? kPrimaryBlack : Colors.white,
              ),
            ]),
          ],
        ),
      ),
    );
  }
}