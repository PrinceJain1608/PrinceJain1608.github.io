import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class WheatherScreen extends StatelessWidget {
  const WheatherScreen({super.key});
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
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "300° F",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.cloud,
                        size: 64,
                      ),
                      Text(
                        "Rain",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Placeholder(
              fallbackHeight: 250,
            ),
            SizedBox(
              height: 25,
            ),
            Placeholder(
              fallbackHeight: 150,
            ),
            SizedBox(
              height: 25,
            ),
            Placeholder(
              fallbackHeight: 150,
            )
          ],
        ),
      ),
    );
  }
}
