import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey[900]),
      ),
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();
  String _weather = "Enter city name";
  String _iconUrl = "";

  Future<void> fetchWeather(String city) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=211922dc4575ca7aa489da81548a4965&units=metric';
    final response = await http.get(Uri.parse(url));

    setState(() {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _weather = "${data['main']['temp']}°C, ${data['weather'][0]['description']}";
        _iconUrl = "https://openweathermap.org/img/wn/${data['weather'][0]['icon']}@2x.png";
      } else {
        _weather = "Error fetching weather";
        _iconUrl = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _controller, decoration: const InputDecoration(labelText: 'Enter City')),
            const SizedBox(height: 15),
            ElevatedButton(onPressed: () => fetchWeather(_controller.text), child: const Text('Get Weather')),
            const SizedBox(height: 20),
            if (_iconUrl.isNotEmpty) Image.network(_iconUrl, width: 100),
            Text(_weather, style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
