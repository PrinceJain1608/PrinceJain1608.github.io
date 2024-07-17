import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:wheather/API.dart';

class WheatherScreen extends StatefulWidget {
  const WheatherScreen({super.key});

  @override
  State<WheatherScreen> createState() => _WheatherScreenState();
}

class _WheatherScreenState extends State<WheatherScreen> {
  @override
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = "London";
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
            onPressed: () {},
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
                  "Weather Forecast",
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
                        width: 100,
                        child: Card(
                          elevation: 6,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16)),
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "09:00",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
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
                                Text("301.17")
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
                                "12:00",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Icon(
                                Icons.sunny,
                                size: 32,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text("301.54")
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
                                "15:00",
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
                              Text("301.11")
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
                                "18:00",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Icon(
                                Icons.sunny,
                                size: 32,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text("300.79")
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
                                "21:00",
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
                      Card(
                        elevation: 6,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                "00:00",
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
