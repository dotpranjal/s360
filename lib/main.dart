import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

void main() {
  runApp(const MyApp());
}

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

      home: HomeScreen(),
    );
  }
}

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
          SOSPage(),
          LocationPage(),
          NewsPage()
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


class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child:Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container( 
                  margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(10.0)),
                  width: MediaQuery.of(context).size.width/2.2,
                  height:170),

                Container( 
                  margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(10.0)),
                  width: MediaQuery.of(context).size.width/2.2,
                  height:170),
              ],
            ),
            Container(decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(10.0)),
                      height: MediaQuery.of(context).size.height-500,
                      width: MediaQuery.of(context).size.width-40,
                      margin: const EdgeInsets.fromLTRB(0, 200, 0, 0),
                      ),
            const Text('Made with love.',)
          ],
        ),
      ),
    );
  }
}

class LocationPage extends StatelessWidget{
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SOS'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
          foregroundColor: Colors.red,
          backgroundColor: Colors.white,
          shape: const CircleBorder(), minimumSize: const Size(200, 200)),
          onPressed: (){}, child: const Text('SOS')),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('General'),
            onTap: () {
              // Navigate to the general settings page
              // Navigator.pushNamed(context, '/general_settings');
            },
          ),
          ListTile(
            title: const Text('Notifications'),
            onTap: () {
              // Navigate to the notifications settings page
              // Navigator.pushNamed(context, '/notifications_settings');
            },
          ),
          // Add more settings options here
        ],
      ),
    );
  }
}

class SOSPage extends StatelessWidget{
  const SOSPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SOS'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          shape: const CircleBorder(), minimumSize: const Size(200, 200)),
          onPressed: (){}, child: const Text('SOS')),
      ),
    );
  }
}

class NewsPage extends StatelessWidget{
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      // body: SingleChildScrollView(
      //   child: Column(),
      // )
    );
  }
}