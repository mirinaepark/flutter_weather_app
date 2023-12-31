import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:flutter_weather_app/model/weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key, this.parseWeatherData, this.parseAirData});

  final dynamic parseWeatherData;
  final dynamic parseAirData;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  // weather api 변수 선언
  Weather weather = Weather();
  String? cityName;
  int? temp;
  Widget? icon;

  String? message;
  var data = DateTime.now();

  // air api 변수 선언
  Widget? airIcon;
  double? dust;
  double? micDust;

  Widget? airState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(widget.parseWeatherData);
    updateAirData(widget.parseAirData);
  }

  // weather api 변수에 값 넣어 주기
  void updateData(dynamic weatherData) {
    double temp2 = weatherData['main']['temp'];
    int condition = weatherData['weather'][0]['id'];
    temp = temp2.round();
    cityName = weatherData['name'];
    icon = weather.getWeatherIcon(condition);
    message = weatherData['weather'][0]['main'];
    print('message: $message');
  }

  // air api 변수에 값 넣어 주기
  void updateAirData(dynamic airData) {
    int index = airData['list'][0]['main']['aqi'];
    airIcon = weather.getAirIcon(index);
    airState = weather.getAirCondition(index);

    dust = airData['list'][0]['components']['pm10'];
    micDust = airData['list'][0]['components']['pm2_5'];

  }

    String getSystemTime() {
      var now = DateTime.now();
      return DateFormat("h:mm a").format(now);
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          /*title: Text(''),*/
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.near_me),
            iconSize: 30.0,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.location_searching),
              iconSize: 30.0,
            ),
          ],
        ),
        body: Container(
          child: Stack(
            children: [
              Image.asset(
                'image/background.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 150.0,
                              ),
                              Text(
                                '$cityName',
                                style: GoogleFonts.lato(
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  TimerBuilder.periodic(
                                    (const Duration(minutes: 1)),
                                    builder: (context) {
                                      print(
                                          'getSystemTime :  ${getSystemTime()}');
                                      return Text(
                                        '${getSystemTime()}',
                                        style: GoogleFonts.lato(
                                            fontSize: 16.0,
                                            color: Colors.white),
                                      );
                                    },
                                  ),
                                  Text(
                                    DateFormat('  - EEEE, ').format(data),
                                    style: GoogleFonts.lato(
                                        fontSize: 16.0, color: Colors.white),
                                  ),
                                  Text(
                                    DateFormat('d MMM, yyy').format(data),
                                    style: GoogleFonts.lato(
                                        fontSize: 16.0, color: Colors.white),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$temp\u2103',
                                style: GoogleFonts.lato(
                                  fontSize: 85.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  icon!,
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    '$message',
                                    style: GoogleFonts.lato(
                                        fontSize: 16.0, color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const Divider(
                          height: 15.0,
                          thickness: 2.0,
                          color: Colors.white30,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'AQI(대기질지수)',
                                    style: GoogleFonts.lato(
                                        fontSize: 14.0, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  airIcon!,
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  airState!,
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '미세먼지',
                                    style: GoogleFonts.lato(
                                        fontSize: 14.0, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    '$dust',
                                    style: GoogleFonts.lato(
                                        fontSize: 24.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    '단위',
                                    style: GoogleFonts.lato(
                                        fontSize: 14.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    '$micDust',
                                    style: GoogleFonts.lato(
                                        fontSize: 14.0, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    '85',
                                    style: GoogleFonts.lato(
                                        fontSize: 24.0, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    '단위',
                                    style: GoogleFonts.lato(
                                        fontSize: 14.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
