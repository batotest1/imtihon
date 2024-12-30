import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String apiKey = "YOUR_API_KEY"; // Bu yerga o'zingizning API kalitingizni qo'ying
  String location = "Kokand"; // Siz ko'rsatmoqchi bo'lgan joy nomi
  Map<String, dynamic>? weatherData;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    final response = await http.get(Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$location&days=2&aqi=yes&alerts=yes"));

    if (response.statusCode == 200) {
      setState(() {
        weatherData = jsonDecode(response.body);
      });
    } else {
      print("Failed to load weather data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: weatherData == null
          ? Center(child: CircularProgressIndicator()) // Ma'lumot yuklanmoqda
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.brown, Colors.deepPurple],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Text(
                    "📍 ${weatherData!['location']['name']}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Good Afternoon",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/sun_cloud.png', // Rasmni o'zingiz qo'shasiz
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${weatherData!['current']['temp_c']}°C",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${weatherData!['current']['condition']['text']}",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${weatherData!['location']['localtime']}",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.wb_sunny, color: Colors.yellow, size: 40),
                          Text(
                            "Sunrise",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            weatherData!['forecast']['forecastday'][0]['astro']
                                ['sunrise'],
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.nightlight_round,
                              color: Colors.blue, size: 40),
                          Text(
                            "Sunset",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            weatherData!['forecast']['forecastday'][0]['astro']
                                ['sunset'],
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.thermostat, color: Colors.red, size: 40),
                          Text(
                            "Temp Max",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "${weatherData!['forecast']['forecastday'][0]['day']['maxtemp_c']}°C",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.thermostat, color: Colors.blue, size: 40),
                          Text(
                            "Temp Min",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "${weatherData!['forecast']['forecastday'][0]['day']['mintemp_c']}°C",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
