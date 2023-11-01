import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({this.parseWeatherData});
  final parseWeatherData;


  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  String? cityName;
  int? temp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(widget.parseWeatherData);
  }

  void updateData(dynamic weatherData) {

    double temp2 = weatherData['main']['temp'];
    temp = temp2.round();
    cityName = weatherData['name'];

    print('temp : $temp');
    print('CityName : $cityName');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'cityName: $cityName',
                style: const TextStyle(fontSize: 30.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                'Temperature : $temp',
                style: const TextStyle(fontSize: 30.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
