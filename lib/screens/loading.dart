import 'package:flutter/material.dart';
import 'package:flutter_weather_app/data/my_location.dart';
import 'package:flutter_weather_app/data/network.dart';
import 'package:flutter_weather_app/screens/weather_screen.dart';
const apikey = 'd4349ed40b1f867e37ada21602d029ac';


class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  double? latitude3;
  double? longitude3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getLocation() async{

    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;

    Network network = Network('https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apikey&units=metric');

    var weatherData = await network.getJsonData();
    print('weatherData : $weatherData');

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(parseWeatherData : weatherData,);
    }));

  }

  /*void fetchData() async{
       var myJson = parsingData['weather'][0]['description'];
       print('myJson: $myJson');
    print('Response body: ${response.body}');
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.purple[300])
          ),
          child: const Text('Get My Location'),
        ),
      ),
    );
  }
}
