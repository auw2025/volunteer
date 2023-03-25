import 'package:flutter/material.dart';
import 'package:hapii/screens/homescreen.dart';
import 'package:hapii/screens/searchscreen.dart';
import 'package:hapii/services/const.dart';
import 'package:unicons/unicons.dart';

class BottomNavBar extends StatefulWidget {
  int currentIndex;
  BottomNavBar({super.key, required this.currentIndex});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 56,
      width: size.width,
      color: kPrimaryBlack,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(alignment: Alignment.center, children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: 32,
              width: widget.currentIndex == 0 ? 64 : 0,
              decoration: BoxDecoration(
                color: kAccentGreen,
                borderRadius: BorderRadius.circular(51),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                  widget.currentIndex = 0;
                });
              },
              icon: const Icon(UniconsLine.home_alt),
              color: widget.currentIndex == 0 ? kPrimaryBlack : Colors.white,
            ),
          ]),
          Stack(alignment: Alignment.center, children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: 32,
              width: widget.currentIndex == 1 ? 64 : 0,
              decoration: BoxDecoration(
                color: kAccentGreen,
                borderRadius: BorderRadius.circular(51),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.currentIndex = 1;
                });
              },
              icon: const Icon(UniconsLine.chat),
              color: widget.currentIndex == 1 ? kPrimaryBlack : Colors.white,
            ),
          ]),
          Stack(alignment: Alignment.center, children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: 32,
              width: widget.currentIndex == 2 ? 64 : 0,
              decoration: BoxDecoration(
                color: kAccentGreen,
                borderRadius: BorderRadius.circular(51),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchScreen()));
                  widget.currentIndex = 2;
                });
              },
              icon: const Icon(UniconsLine.search),
              color: widget.currentIndex == 2 ? kPrimaryBlack : Colors.white,
            ),
          ]),
          Stack(alignment: Alignment.center, children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: 32,
              width: widget.currentIndex == 3 ? 64 : 0,
              decoration: BoxDecoration(
                color: kAccentGreen,
                borderRadius: BorderRadius.circular(51),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.currentIndex = 3;
                });
              },
              icon: const Icon(UniconsLine.user),
              color: widget.currentIndex == 3 ? kPrimaryBlack : Colors.white,
            ),
          ]),
        ],
      ),
    );
  }
}
