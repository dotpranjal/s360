import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

void main() {
  runApp(const MyApp());
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(onPressed: (){Navigator.pushNamed(context, '/settings');}, icon: const Icon(Icons.settings,size: 30.0,))
        ],
      
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.grey.shade900,borderRadius: BorderRadius.circular(10)),
        height: 80,
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: () {Navigator.pushNamed(context, '/home');}, icon: const Icon(Icons.home, size: 30.0)),
            IconButton(onPressed: () {Navigator.pushNamed(context, '/sos');}, icon: const Icon(Icons.phone, size: 30.0)),
            IconButton(onPressed: () {Navigator.pushNamed(context, '/location');}, icon: const Icon(Icons.location_on, size: 30.0)),
            IconButton(onPressed: () {Navigator.pushNamed(context, '/news');}, icon: const Icon(Icons.feed, size: 30.0))
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context)=> const MyHomePage(title: 'S360'),
        '/sos': (context)=> const SOSPage(),
        '/location': (context)=> const LocationPage(),
        '/settings': (context)=> const SettingsPage(),
        '/news': (context)=> const NewsPage()

      },
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.pink,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontFamily: 'Sergei'),
        )
      ),
    );
  }
}
// FlutterNativeSplash.remove();
