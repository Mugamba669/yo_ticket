import 'package:flutter/material.dart';
import 'package:miic/pages/homePage.dart';
import 'package:miic/pages/upcoming_matches.dart';
import 'package:miic/payments/reports.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const upComingMatches(),
    // const upComingMatches(),
    const Reports()
  ];
  PageController pageController = PageController();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(_selectedIndex,
        duration: const Duration(milliseconds: 450), curve: Curves.decelerate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: _widgetOptions,
        controller: pageController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        // fixedColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey[500],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.sports_soccer),
          //   label: 'Matches',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_esports),
            label: 'Tournaments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Reports',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange[800],
        onTap: _onItemTapped,
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //     currentIndex: _selectedIndex,
      //     onTap: (index) =>
      //         _onItemTapped(index), //METHOD TO be called when an icon is tapped
      //     elevation: 10.0,
      //     showSelectedLabels: false,
      //     showUnselectedLabels: false,
      //     type: BottomNavigationBarType.fixed,
      //     selectedItemColor: Colors.blueGrey,
      //     unselectedItemColor: Colors.amber,
      //     items: const [
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         activeIcon: Icon(Icons.home_filled),
      //         label: "Home",
      //       ),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.home),
      //           activeIcon: Icon(Icons.live_tv_rounded),
      //           label: "Search"),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.airplane_ticket),
      //           activeIcon: Icon(Icons.airplane_ticket),
      //           label: "Ticket"),
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.person),
      //           activeIcon: Icon(Icons.person_sharp),
      //           label: "Person"),
      //     ]),
    );
  }
}
