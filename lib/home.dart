import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class BoardingPass extends StatefulWidget {
  const BoardingPass({Key? key}) : super(key: key);

  @override
  _BoardingPassState createState() => _BoardingPassState();
}

class _BoardingPassState extends State<BoardingPass> {
  late Map<String, dynamic> apiResponse;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final apiUrl =
        Uri.parse("https://v1.nocodeapi.com/lunraintern/ep/dNVhXmOJGmNQOZkW");
    final requestBody =
        json.encode({"recordLocator": "D83PWG", "lastName": "ALAM"});

    final response = await http.post(
      apiUrl,
      headers: {"Content-Type": "application/json"},
      body: requestBody,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        apiResponse = responseData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Boarding')),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/images/back.jpg'),
                Positioned(
                  left: 30.0,
                  top: 100.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        apiResponse["data"][0]["legs"][0]["originCity"] ??
                            'Origin City',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 14.0),
                      ),
                      Text(
                        apiResponse["data"][0]["legs"][0]["origin"] ?? 'Origin',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat('HH:mm').format(DateTime.parse(
                            apiResponse["data"][0]["legs"][0]
                                ["estimatedDeparture"])),
                        style: const TextStyle(
                            color: Colors.white, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 30.0,
                  top: 100.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        apiResponse["data"][0]["legs"][0]["destinationCity"] ??
                            'Destination City',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 14.0),
                      ),
                      Text(
                        apiResponse["data"][0]["legs"][0]["destination"] ??
                            'Destination',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat('HH:mm').format(DateTime.parse(
                            apiResponse["data"][0]["legs"][0]
                                ["scheduledArrival"])),
                        style: const TextStyle(
                            color: Colors.white, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
                // Dotted line with flight icon
                Positioned(
                  left: 100.0,
                  right: 120.0,
                  top: 140.0,
                  child: CustomPaint(
                    painter: DottedLinePainter(),
                  ),
                ),
                const Positioned(
                  left: 150.0,
                  right: 00.0,
                  top: 130.0,
                  child: Icon(
                    Icons.flight_takeoff,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Center(
                child: Text(
                  'Yay! Your flight is on time.',
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Passenger Name'),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sinku Rajendra Kumar',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(color: Colors.black),
            const SizedBox(height: 10.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dep Terminal'),
                Text('Gate'),
                Text('Arr. Terminal'),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  apiResponse["data"][0]["legs"][0]["departureTerminal"] ??
                      'Dep Terminal',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'C3',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  apiResponse["data"][0]["legs"][0]["arrivalTerminal"] ??
                      'Arr Terminal',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date'),
                Text('Flight Status'),
                Text('Flight'),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd/MM/yyyy').format(DateTime.parse(
                      apiResponse["data"][0]["legs"][0]["scheduledDeparture"])),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  apiResponse["data"][0]["legs"][0]["status"] ??
                      'Flight Status',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  apiResponse["data"][0]["legs"][0]["flightIdentifier"] ??
                      'Flight',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    double startX = 0.0;
    double endX = size.width;
    double y = size.height / 2;

    while (startX < endX) {
      canvas.drawPoints(
        PointMode.points,
        [Offset(startX, y)],
        paint,
      );
      startX += 7.0; // Adjust the distance between dots as needed
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
