import 'package:covid19_app/screens/home.dart';
import 'package:covid19_app/screens/statistics.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'person.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedScreen = 0;
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: selectedScreen);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print('width: $width');
    print('height: $height');
    return Scaffold(
      body: PageView(
       children: [
         Home(),
         Statistics(),
         Person()
       ],
        restorationId: selectedScreen.toString(),
        onPageChanged: (value) {
          setState(() {
            selectedScreen = value;
          });
        },
        controller: pageController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: greyColor,
              ),
              label: '',
              activeIcon: Icon(
                Icons.home,
                color: orangeColor,
              )),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bar_chart,
              color: greyColor,
            ),
            label: '',
            activeIcon: Icon(Icons.bar_chart, color: orangeColor),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: greyColor,
            ),
            label: '',
            activeIcon: Icon(Icons.person, color: orangeColor),
          )
        ],
        currentIndex: selectedScreen,
        onTap: (value) {
          setState(() {
            selectedScreen = value;
            pageController.animateToPage(
                selectedScreen,
                duration: Duration(milliseconds: 300),
                curve: Curves.ease
            );
          });
        },
      ),
    );
  }
}
