import 'package:effectips/components/habit_card.dart';
import 'package:flutter/material.dart';
import 'package:effectips/components/home/blog_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  final List<Widget> _screens = [
    BlogListScreen(),
    HabitCard(
      color: Colors.red[500],
      frequency: "Daily",
      habit: "Gym",
    ),
    HabitCard(
      color: Colors.red[500],
      frequency: "Daily",
      habit: "Gym",
    ),
  ];

  int _selectedIndex = 0;

  static const List<BottomNavigationBarItem> _navBarsItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.today_outlined), label: 'Calender'),
    BottomNavigationBarItem(icon: Icon(Icons.face), label: 'Homepage'),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _selectedIndex = index);
            },
            children: _screens,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: _navBarsItems,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.orange[900],
          selectedItemColor: Colors.white,
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      //
      //
      //using this page controller you can make beautiful animation effects
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }
}


/* 
  Widget build(BuildContext context) {
    final String _text = 'Hello World';
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(22, 30, 49, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(22, 30, 49, 1),
          title: Text(_text),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Blogs',
              ),
              Tab(text: 'Progress'),
              Tab(text: 'Profile'),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
*/