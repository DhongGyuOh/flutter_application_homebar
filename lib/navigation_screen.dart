import 'package:flutter/material.dart';
import 'package:flutter_application_homebar/home/home_screen.dart';
import 'package:flutter_application_homebar/profile/profile_screen.dart';
import 'package:flutter_application_homebar/receipt/receipt_screen.dart';
import 'package:flutter_application_homebar/search/search_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class NavigationScreen extends ConsumerStatefulWidget {
  const NavigationScreen({super.key, required this.tab});
  static String routeName = "navigation";
  final String tab;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NavigationScreenState();
}

class _NavigationScreenState extends ConsumerState<NavigationScreen> {
  final List<String> _tab = ["home", "search", "receipt", "profile"];
  late int _tabIndex = _tab.indexOf(widget.tab);

  void _onTapNavButton(int index) {
    context.go("/${_tab[index]}");
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: 키보드 입력창이 나와도 화면이 resize되지 않게 함(false)
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Offstage(
            offstage: _tabIndex != 0,
            child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _tabIndex != 0 ? 0.0 : 1.0,
                child: const HomeScreen()),
          ),
          Offstage(
            offstage: _tabIndex != 1,
            child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _tabIndex != 1 ? 0.0 : 1.0,
                child: const SearchScreen()),
          ),
          Offstage(
            offstage: _tabIndex != 2,
            child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _tabIndex != 2 ? 0.0 : 1.0,
                child: const ReceiptScreen()),
          ),
          Offstage(
            offstage: _tabIndex != 3,
            child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _tabIndex != 3 ? 0.0 : 1.0,
                child: const ProfileScreen()),
          )
        ],
      ),
      bottomNavigationBar: WaterDropNavBar(
          backgroundColor: Colors.deepOrangeAccent,
          waterDropColor: Colors.pink,
          inactiveIconColor: Colors.lime,
          iconSize: 35,
          selectedIndex: _tabIndex,
          onItemSelected: (index) => _onTapNavButton(index),
          barItems: [
            BarItem(
                filledIcon: Icons.other_houses,
                outlinedIcon: Icons.other_houses_outlined),
            BarItem(
                filledIcon: FontAwesomeIcons.wineGlass,
                outlinedIcon: FontAwesomeIcons.wineGlassEmpty),
            BarItem(
                filledIcon: Icons.receipt,
                outlinedIcon: Icons.receipt_outlined),
            BarItem(
                filledIcon: Icons.person, outlinedIcon: Icons.person_outline),
          ]),
    );
  }
}
