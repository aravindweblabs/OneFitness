import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';
import 'home.dart';
import 'logindummy.dart';
import 'myplanDetails.dart';


class MyPlan extends StatefulWidget {

  final int uid;

  MyPlan({required this.uid});

  @override
  _MyPlanState createState() => _MyPlanState();
}


class _MyPlanState extends State<MyPlan> {
  List<dynamic> packages = [];
  List<dynamic> bookingids = [];

  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchBookingId();
  }

  Future<void> fetchData() async {

    var response = await http.get(Uri.parse('http://$ipAddress/$ProjectName/myplan.php?userid=${widget.uid}'));
    if (response.statusCode == 200) {
      setState(() {
        packages = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<void> fetchBookingId() async {

    var response = await http.get(Uri.parse('http://$ipAddress/$ProjectName/myBooking.php?userid=${widget.uid}'));
    if (response.statusCode == 200) {
      setState(() {
        bookingids = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load Booking id');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Plan'),
        backgroundColor: const Color(0xFFB070FA),
      ),
      body: bookingids.isEmpty
          ? Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage(uid: authController.uid.value)),
            );
          },
          child: const Text(
            'No plans available.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
      )
          : ListView.builder(
        itemCount: bookingids.length,
        itemBuilder: (context, index) {
          final booking = bookingids[index];
          String packageDate = booking['booking_date'];
          String expiryDate = booking['duration_date'];

          DateTime packageDateTime = DateTime.parse(packageDate);
          DateTime expiryDateTime = DateTime.parse(expiryDate);

          int totalDays = expiryDateTime.difference(packageDateTime).inDays;

          return Card(
            elevation: 3,
            margin: EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPlanDetails(id: booking['id'])),
                );
              },
              child: ListTile(
                title: Text('S.No: ${index + 1}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Booking Date: $packageDate'),
                    Text('Expiry Date: $expiryDate'),
                    Text('Total Number of Days: $totalDays'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
     /*: ListView.builder(
        itemCount: packages.length,
        itemBuilder: (context, index) {
          final package = packages[index];
          String packageDate = package['package_date'];
          String expiryDate = package['expiry_date'];

          DateTime packageDateTime = DateTime.parse(packageDate);
          DateTime expiryDateTime = DateTime.parse(expiryDate);

          int totalDays = expiryDateTime.difference(packageDateTime).inDays;

          return Card(
            elevation: 3,
            margin: EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPlanDetails(id: package['id'])),
                );
              },
              child: ListTile(
                title: Text('S.No: ${index + 1}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Booking Date: $packageDate'),
                    Text('Expiry Date: $expiryDate'),
                    Text('Total Number of Days: $totalDays'),
                  ],
                ),
              ),
            ),
          );
        },
      ),*/
    );
  }
}



class Package {
  final int id;
  final String package_date;
  final String expiry_date;


  Package({
    required this.id,
    required this.package_date,
    required this.expiry_date,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'] as int,
      package_date: json['package_date'] as String,
      expiry_date: json['expiry_date'] as String,
    );
  }
}


class Booking{
  final int id;
  final String booking_date;
  final String duration_date;

  Booking({
    required this.id,
    required this.booking_date,
    required this.duration_date,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as int,
      booking_date: json['booking_date'] as String,
      duration_date: json['duration_date'] as String,
    );
  }
}

