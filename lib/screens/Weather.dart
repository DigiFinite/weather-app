import 'package:Weather/models/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_location_picker/simple_location_picker_screen.dart';
import 'package:simple_location_picker/simple_location_result.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:Weather/models/weather.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class Weather extends StatefulWidget {
  Weather({Key key}) : super(key: key);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  WeatherData weather;
  SimpleLocationResult selectedLocation;

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context).settings.arguments;
    weather = arguments['weatherData'];
    selectedLocation = arguments['selectedLocation'];

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          Navigator.pushReplacementNamed(context, '/loading',
              arguments: selectedLocation);
          return null;
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(0),
            child: ListView(
              children: [
                buildWavyWidget(context),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).accentColor,
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white),
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  FontAwesome5Solid.eye,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text("Visibility",
                                  style: GoogleFonts.lato(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                "${weather.visibility} km",
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).accentColor,
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white),
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Ionicons.ios_water,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text("Humidity",
                                  style: GoogleFonts.lato(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                "${weather.humidity}%",
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Theme.of(context).accentColor,
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white),
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  FontAwesome5Solid.wind,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text("Wind Speed",
                                  style: GoogleFonts.lato(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                "${weather.windSpeed.floor()} km/hr",
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(padding: const EdgeInsets.all(25)),
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        color: Theme.of(context).accentColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showLocationPicker();
        },
        tooltip: "Select a Location",
        child: Icon(
          Icons.location_on_rounded,
          color: Colors.white,
          size: 32,
        ),
        backgroundColor: Theme.of(context).accentColor,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  ClipPath buildWavyWidget(BuildContext context) {
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        padding: EdgeInsets.all(20),
        color: Theme.of(context).accentColor,
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weather.name,
                          style: GoogleFonts.lato(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          DateFormat("yMMMEd").format(DateTime.now()),
                          style: GoogleFonts.lato(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Provider.of<AppSettingsChangeNotifier>(context, listen: false).themeMode == AppThemeMode.Dark ? FontAwesome5.lightbulb : FontAwesome5.moon ,
                      size: 32,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Provider.of<AppSettingsChangeNotifier>(context, listen: false)
                          .toggleTheme();
                    },
                    tooltip: "Toggle Theme Mode",
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: Column(
                children: [
                  Transform.scale(
                    scale: 1.6,
                    child: SvgPicture.asset("assets/svgs/${weather.icon}.svg"),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        weather.temperature.toString(),
                        style: GoogleFonts.lato(
                          fontSize: 65,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "°C",
                        style: GoogleFonts.lato(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Text(
                    weather.condition,
                    style: GoogleFonts.lato(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Weather kon be like ${weather.feelsLike}°C",
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLocationPicker() {
    double latitude =
        selectedLocation != null ? selectedLocation.latitude : 6.4661;
    double longitude =
        selectedLocation != null ? selectedLocation.longitude : 3.3337;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SimpleLocationPicker(
          initialLatitude: latitude,
          initialLongitude: longitude,
          appBarTitle: "Pick a location",
          zoomLevel: 16,
          appBarColor: Theme.of(context).accentColor,
          markerColor: Color(0xFFEF2929),
        ),
      ),
    ).then(
      (value) {
        if (value != null) {
          setState(
            () {
              selectedLocation = value;
              Navigator.pushReplacementNamed(context, "/loading",
                  arguments: selectedLocation);
            },
          );
        }
      },
    );
  }
}
