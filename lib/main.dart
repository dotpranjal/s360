import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

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
        '/settings': (context)=> const SettingsPage(),
      },

      home: const HomeScreen(),
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
                  height:170,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Hey",style: TextStyle(fontSize: 26),),
                      Text('User',style: TextStyle(fontSize: 26),),
                    ],
                  )
                  ),

                Container( 
                  margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  decoration: BoxDecoration(color: Colors.grey.shade900, borderRadius: BorderRadius.circular(10.0)),
                  width: MediaQuery.of(context).size.width/2.2,
                  height:170,
                  child: IconButton(onPressed: (){}, icon: const Icon(Icons.person, size: 150,))),
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
        title: const Text('Location'),
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

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  Future<List<Map<String, dynamic>>> fetchNews() async {
    const apiKey = 'aee608c5307e4bfb8fe356a983b7cfd4';
    const url = 'https://newsapi.org/v2/everything?q=women%20safety&from=2024-09-05&to=2024-09-05&sortBy=popularity&apiKey=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final articles = data['articles'] as List<dynamic>;
      return articles.map((article) => article as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No news available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final article = snapshot.data![index];
                return ListTile(
                  title: Text(article['title'] ?? 'No Title'),
                  subtitle: Text(article['description'] ?? 'No Description'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
