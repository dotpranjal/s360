import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_sms/flutter_sms.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';




// global_variables.dart
const List<String> emergencyContacts = ['+917838159080','+919667536016','+919267966220'];

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
          SOSPage(emergencyContacts: emergencyContacts),
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

class LocationPage extends StatefulWidget {
 const LocationPage({super.key});

 @override
 _LocationPageState createState() => _LocationPageState();
}


class _LocationPageState extends State<LocationPage>{
  // MapController? _controller;
  // Marker? _currentMarkerId;
  String _locationMessage = "Fetching location...";
  // LatLng _currentPosition = LatLng(0.00, 70.);
  @override
  void initState() {
   super.initState();
   _getCurrentLocation();
  }
  
  Future<void> _getCurrentLocation() async {
    
     bool serviceEnabled;
     LocationPermission permission;

     // Test if location services are enabled
     serviceEnabled = await Geolocator.isLocationServiceEnabled();
     if (!serviceEnabled) {
      // await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
       // Location services are not enabled, show a message
       setState(() {
         _locationMessage = "Location services are disabled.";
       });
       return;
     }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
         // Permissions are denied, show a message
        setState(() {
          _locationMessage = "Location permissions are denied.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied, show a message
      setState(() {
        _locationMessage = "Location permissions are permanently denied.";

      });
      return;
    }

    // Get the current position
    const  LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );


    Position position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
    
    

    setState(() {
       _locationMessage = "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
      //  _currentPosition = LatLng(position.latitude, position.longitude);
       
     });

   }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
      ),
      body: Center(
        child:Column(children: [Text(_locationMessage),
        Column(children: [Container(height: 550,width: 350, child:FlutterMap(
          options: const MapOptions(backgroundColor: Color.fromARGB(255, 253, 253, 253),
          initialZoom: 16, initialCenter: LatLng(28.6318191, 77.2937431),
          ), 
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
            maxNativeZoom: 19, 
            minNativeZoom: 0, 
            
          ),
          RichAttributionWidget( // Include a stylish prebuilt attribution widget that meets all requirments
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')), // (external)
              ),
          // Also add images...
        ],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(28.631819,77.2937362),
                child: Container(
                  child:  const Icon(
                    Icons.navigation,
                    color: Colors.red,
                  ),
                ))
            ])
            
            
   

        ],
        ))],
        )
        ],)
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(()
 {
      _darkModeEnabled = prefs.getBool('dark_mode') ?? false;
      _selectedLanguage = prefs.getString('language') ?? 'English';
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', _darkModeEnabled);
    await prefs.setString('language', _selectedLanguage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: _darkModeEnabled,
            onChanged: (value) {
              setState(() {
                _darkModeEnabled = value;
                _saveSettings();
              });
            },
          ),
          DropdownButtonFormField<String>(
            value: _selectedLanguage,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value!;
                _saveSettings();
              });
            },
            items: <String>['English', 'Spanish', 'French'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),

            decoration: const InputDecoration(
              labelText: 'Language',
              border: OutlineInputBorder(),
              

            ),
          ),
          ListTile(title: const Text("Notifications"),)
          // Add more settings options here
        ],
      ),
    );
  }
}

class SOSPage extends StatefulWidget {
  final List<String> emergencyContacts;

  const SOSPage({super.key, required this.emergencyContacts});

  @override
  _SOSPageState createState() => _SOSPageState();
}


class _SOSPageState extends State<SOSPage>{

  void sendSOS() async {
    final smsPermissionStatus = await Permission.sms.request();
    if(smsPermissionStatus.isGranted){
      try {
        String message = "I need help! My location is [Your location]";
        await sendSMS(message: message, recipients: emergencyContacts);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('SOS message sent successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send SOS message: $e')),
        );
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('SMS Permission Required')),
      );
    }
  }



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
          onPressed: sendSOS, child: const Text('SOS')),
      ),
    );
  }
}

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  Future<List<Map<String, dynamic>>> fetchNews() async {
    const apiKey = 'aee608c5307e4bfb8fe356a983b7cfd4';
    const url = 'https://newsapi.org/v2/everything?q=tech&from=2024-09-06&to=2024-09-06&sortBy=popularity&apiKey=$apiKey';

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
