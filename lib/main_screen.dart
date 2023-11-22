import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:stunting/balita_screen.dart';
import 'package:stunting/calon_ibu_screen.dart';
import 'package:stunting/profile_screen.dart';
import 'package:stunting/providers/page_provider.dart';
import 'package:stunting/theme.dart';

import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  final int pageIndex;
  const MainScreen({Key? key, this.pageIndex = 0}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  bool isPetugas = false;
  @override
  Widget build(BuildContext context) {
    // PAGE PROVIDER
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    // CUSTOM BUTTON NAVBAR
    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 12,
          clipBehavior: Clip.antiAlias,
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              backgroundColor: whiteColor,
              currentIndex: pageProvider.currentIndex,
              onTap: (value) {
                setState(() {
                  pageProvider.currentIndex = value;
                });
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: SvgPicture.asset(
                      'assets/home_icon.svg',
                      width: 24,
                      color: pageProvider.currentIndex == 0
                          ? primaryColor
                          : secondaryColor,
                    ),
                  ),
                  label: 'Beranda',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: SvgPicture.asset(
                      'assets/mom_icon.svg',
                      width: 24,
                      color: pageProvider.currentIndex == 1
                          ? primaryColor
                          : secondaryColor,
                    ),
                  ),
                  label: 'Calon Ibu',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: SvgPicture.asset(
                      'assets/balita_icon.svg',
                      width: 24,
                      color: pageProvider.currentIndex == 2
                          ? primaryColor
                          : secondaryColor,
                    ),
                  ),
                  label: 'Balita',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: SvgPicture.asset(
                      'assets/setting_icon.svg',
                      width: 24,
                      color: pageProvider.currentIndex == 3
                          ? primaryColor
                          : secondaryColor,
                    ),
                  ),
                  label: 'Profile',
                ),
              ],
              showUnselectedLabels: true,
              selectedItemColor: primaryColor,
              selectedLabelStyle: primaryTextStyle.copyWith(fontSize: 13),
              unselectedLabelStyle: secondaryTextStyle.copyWith(fontSize: 12),
            ),
          ),
        ),
      );
    }

    // SCREEN
    Widget body() {
      switch (pageProvider.currentIndex) {
        case 0:
          return HomeScreen();
          break;
        case 1:
          return CalonIbuScreen();
          break;
        case 2:
          return BalitaScreen();
          break;
        case 3:
          return ProfileScrenn();
          break;

        default:
          return HomeScreen();
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
