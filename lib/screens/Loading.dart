import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:Weather/models/weather.dart';
import 'package:simple_location_picker/simple_location_result.dart';

class Loading extends StatefulWidget {
  Loading({Key key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String apiKey = "19ce5a3c4a15ae4fc432b380d1590d0c";
  SimpleLocationResult arguments;

  getData({lat, lon}) async {
    

    String latitude = lat == null ? "6.27" : lat.toString();
    String longitude = lon == null ? "3.21" : lon.toString();

    Response response = await get(
        "http://api.openweathermap.org/data/2.5/weather?units=metric&lat=$latitude&lon=$longitude&appid=$apiKey");
    Map data = jsonDecode(response.body);
    print(data);

    Navigator.pushReplacementNamed(context, "/weather", arguments: {
      "weatherData": WeatherData.fromJson(data),
      "selectedLocation": arguments
    });
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments;
    Future.delayed(
      Duration(seconds: 1),
      () => {
        arguments != null
            ? getData(lat: arguments.latitude, lon: arguments.longitude)
            : getData()
      },
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LottieBuilder.asset("assets/loading.json"),
        ],
      ),
    );
  }
}
