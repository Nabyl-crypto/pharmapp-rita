import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PharmApp Rita',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String zone = 'Chargement…';

  Future<void> _detectZone() async {
    final pos = await Geolocator.getCurrentPosition();
    final d = Geolocator.distanceBetween(pos.latitude, pos.longitude, 33.6118552, -7.5110977);
    setState(() {
      zone = d <= 300 ? 'Résidentielle' : d <= 800 ? 'Commerciale' : 'Industrielle';
    });
  }

  @override
  void initState() {
    super.initState();
    _detectZone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PharmApp Rita')),
      body: Center(
        child: Text('Zone actuelle : $zone', style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
