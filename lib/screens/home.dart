import 'package:app/models/weather.dart';
import 'package:app/services/weatherService.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    const apiKey = '3d9ec4980ff14e71bd662f2ecd0c7b28';
    final _weatherService = WeatherService(apiKey: apiKey);
    Weather? _weather;

    _fetchWeather() async {
      final city = await _weatherService.getCurrentCity();
      try {
        final weather = await _weatherService.getWeather(city);
        setState(() {
          _weather = weather;
        });
      } catch (e) {
        print(e);
      }
    }

    initState() {
      super.initState();
      _fetchWeather();
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              _weather?.city ?? 'Loading...',
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              '${_weather?.temperature ?? 0}°C',
              style: const TextStyle(fontSize: 48),
            ),
          ],
        ),
      ),
    );
  }
}
