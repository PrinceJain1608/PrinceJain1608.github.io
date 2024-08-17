import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:wheather/API.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WheatherScreenState();
}

class _WheatherScreenState extends State<WeatherScreen> {
  @override
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = "India";
      final result = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$APIKey"));
      final data = jsonDecode(result.body);
      if (data["cod"] != "200") {
        throw "An unexpected error occured";
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.hasError.toString()));
          }
          final data = snapshot.data!;
          final currentTemp = data["list"][0]["main"]["temp"];
          final currentSky = data["list"][0]["weather"][0]["main"];
          final currentPressure = data["list"][0]["main"]["pressure"];
          final currentWind = data["list"][0]["wind"]["speed"];
          final currentHumidity = data["list"][0]["main"]["humidity"];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                "$currentTemp K",
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                currentSky == "Clouds" || currentSky == "Rain"
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 64,
                              ),
                              Text(
                                currentSky,
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Hourly Forecast",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(
                  height: 16,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        child: Card(
                          elevation: 6,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16)),
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  DateFormat.j().format(DateTime.parse(
                                      data["list"][0]["dt_txt"])),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Icon(
                                  data["list"][1]["weather"][0]["main"] ==
                                              "Clouds" ||
                                          data["list"][1]["weather"][0]
                                                  ["main"] ==
                                              "Rain"
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 32,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                    data["list"][1]["main"]["temp"].toString()),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 6,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                DateFormat.j().format(
                                    DateTime.parse(data["list"][1]["dt_txt"])),
                                //data["list"][2]["dt_txt"].toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Icon(
                                data["list"][2]["weather"][0]["main"] ==
                                            "Clouds" ||
                                        data["list"][2]["weather"][0]["main"] ==
                                            "Rain"
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 32,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(data["list"][2]["main"]["temp"].toString())
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 6,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                DateFormat.j().format(
                                    DateTime.parse(data["list"][2]["dt_txt"])),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Icon(
                                data["list"][3]["weather"][0]["main"] ==
                                            "Clouds" ||
                                        data["list"][3]["weather"][0]["main"] ==
                                            "Rain"
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 32,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(data["list"][3]["main"]["temp"].toString())
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 6,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                DateFormat.j().format(
                                    DateTime.parse(data["list"][3]["dt_txt"])),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Icon(
                                data["list"][4]["weather"][0]["main"] ==
                                            "Clouds" ||
                                        data["list"][4]["weather"][0]["main"] ==
                                            "Rain"
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 32,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(data["list"][4]["main"]["temp"].toString())
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 6,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                DateFormat.j().format(
                                    DateTime.parse(data["list"][4]["dt_txt"])),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Icon(
                                data["list"][5]["weather"][0]["main"] ==
                                            "Clouds" ||
                                        data["list"][5]["weather"][0]["main"] ==
                                            "Rain"
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 32,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(data["list"][5]["main"]["temp"].toString())
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 6,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                DateFormat.j().format(
                                    DateTime.parse(data["list"][5]["dt_txt"])),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Icon(
                                Icons.cloud,
                                size: 32,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text("320.12")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Additional Information",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Card(
                        elevation: 6,
                        child: Column(
                          children: [
                            Icon(
                              Icons.water_drop,
                              size: 40,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Humidity",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "$currentHumidity",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 6,
                      child: Column(
                        children: [
                          Icon(
                            Icons.air,
                            size: 40,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Wind Speed",
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "$currentWind",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Card(
                      elevation: 6,
                      child: Column(
                        children: [
                          Icon(
                            Icons.beach_access,
                            size: 40,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Pressure",
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "$currentPressure",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
