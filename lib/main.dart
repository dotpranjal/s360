import 'package:flutter/material.dart';
import 'sos.dart';
import 'homepage.dart';
import 'settingspage.dart';
import 'location.dart';
import 'news.dart';



void main() {
  runApp(const MyApp());
}


//this is the outer frame on which the s360 and 
//settings button is showed 
//this doesn't include bottom nav bar 
//and the middle content
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        appBarTheme: const AppBarTheme(
          color: Colors.black
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        )
      ),
      themeMode: ThemeMode.dark,

      initialRoute: '/',
      routes: {
        '/settings': (context)=> SettingsPage(),
      },

      home: const HomeScreen(),
    );
  }
}

//this is the main frame and the bottom nav bar code
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int page){
    setState(() {
      _currentPage = page;
    });
  }

  void _onNavItemTapped(int index){
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('S360'),
        actions: [
          IconButton(onPressed: (){Navigator.pushNamed(context, '/settings');}, icon: const Icon(Icons.settings,size: 30.0,))
        ],
      
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const <Widget>[
          HomePage(),
          Sos(),
          Location(),
          News()
        ],
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        
        currentIndex: _currentPage,
        onTap: _onNavItemTapped,
        
        items:const  [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30.0,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sos, size: 30.0,),
            label: 'Alarm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on, size: 30.0,),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feed, size: 30.0,),
            label: 'Feed',
          ),
        ],
        ),
      );
  }
}

