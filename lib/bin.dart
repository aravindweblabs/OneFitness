//home.dart

/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:onefitness/profile.dart';
import 'package:onefitness/selectTrainer.dart';
import 'package:onefitness/slider.dart';
import 'AboutUs.dart';
import 'Plans.dart';
import 'constants.dart';
import 'contactUs.dart';
import 'services/genetics.dart';
import 'services/gym.dart';
import 'logindummy.dart';
import 'myplan.dart';
import 'services/nutrition.dart';


class HomePage extends StatefulWidget {
  final int uid;

  const HomePage({Key? key, required this.uid}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> fetchedData = [];
  List<Plan> plans = [];
  final AuthController authController = Get.find<AuthController>();
  List<dynamic> userDetailsList = [];
  List<dynamic> bookingids = [];
  List<dynamic> bookinglatestId = [];
//  Map<String, dynamic>? userDetails;

  @override
  void initState() {
    super.initState();
    //fetchBookingId();
    fetchBookingIdLatest();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }


  void fetchData() async {
    try {
      var response = await http.get(Uri.parse('http://$ipAddress/$ProjectName/booking-details.php?bookingid=$id'));
      if (response.statusCode == 200) {
        // Decode response body and check if it's not null
        var decodedBody = jsonDecode(response.body);
        if (_isMounted && decodedBody != null) {
          setState(() {
            userDetailsList = decodedBody;
          });
        }
      } else {
        throw Exception('Failed to load user details: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching user details: $error');
    }
  }

  Future<void> fetchUserDetails(int id) async {
    try {
      var response = await http.get(Uri.parse('http://$ipAddress/$ProjectName/booking-details.php?bookingid=$id'));
      if (response.statusCode == 200) {
        // Print response body for debugging
        print('Response body: ${response.body}');

        // Decode response body and check if it's not null
        var decodedBody = jsonDecode(response.body);
        if (decodedBody != null) {
          if (mounted) {
            setState(() {
              userDetailsList = decodedBody;
            });
          } else {
            print('Widget is not mounted, cannot call setState()');
          }
        } else {
          print('Decoded body is null');
        }
      } else {
        throw Exception('Failed to load user details: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching user details: $error');
    }

  }

  Future<void> fetchBookingIdLatest() async {
    var response = await http.get(Uri.parse('http://$ipAddress/$ProjectName/latestBookingId.php?userid=${widget.uid}'));
    if (response.statusCode == 200) {
      setState(() {
        bookinglatestId = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load Booking id');
    }
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://$ipAddress/$ProjectName/plans.php'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      setState(() {
        plans = responseData.map((json) => Plan.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Do you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreendummy()),
                      (route) => false,
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String calculateDurationDate(String? bookingDate, String? packageDuration) {
    if (bookingDate != null && packageDuration != null) {
      // Convert booking date to DateTime object
      DateTime dateTime = DateTime.parse(bookingDate);
      // Parse package duration to integer
      int duration = int.tryParse(packageDuration) ?? 0;
      // Add the package duration to the booking date
      DateTime durationDate = dateTime.add(Duration(days: duration));
      // Format the duration date as needed
      String formattedDurationDate = DateFormat('yyyy-MM-dd').format(durationDate);
      return formattedDurationDate;
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if userDetailsList is empty
    if (userDetailsList.isEmpty) {
      // If empty, navigate to PlansPage and return empty container
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PlansPage(uid: widget.uid, durationDate: DateTime.now().toString()),
          ),
        );
      });
      return Container(); // Return empty container while navigating
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color(0xFFB070FA),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _showLogoutConfirmationDialog(context);
            },
          ),
        ],
      ),
      drawer: Drawer(
          child: Container(
            color:const Color(0xFFB070FA).withOpacity(0.5),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height:70),
                ListTile(
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile(uid: widget.uid)),
                    );
                  },
                ),
                ExpansionTile(
                  title: const Text('Services'),
                  children: [
                    ListTile(
                      title: const Text('Gym'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Gym()),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('Nutrition'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Nutrition()),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('Genetics'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Genetics()),
                        );
                      },
                    ),
                  ],
                ),
                ListTile(
                  title: const Text('Plans'),
                  onTap: () {
                    if (bookinglatestId.isNotEmpty) {
                      int latestBookingId = bookinglatestId[0]['id'];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlansPage(
                            uid: widget.uid,
                            // latestBookingId: latestBookingId,
                            //durationDate: durationDate,//working when there is a booking
                            durationDate: userDetailsList.isNotEmpty && userDetailsList[0]['bookingdate'] != null
                                ? calculateDurationDate(userDetailsList[0]['bookingdate'], userDetailsList[0]['PackageDuration'])
                                : null,
                          ),
                        ),
                      );
                    }
                  },
                ),
                ListTile(
                  title: const Text('About Us'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutUs()),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Contact Us'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactUs()),
                    );
                  },
                ),
                ListTile(
                  title: const Text('My Plan'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyPlan(uid: widget.uid)),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Select Trainer'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SelectTrainer(uid: widget.uid)),
                    );
                  },
                ),
              ],
            ),
          )
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeSlider(),
              SizedBox(height: 25),
              Center(
                child: Text(
                  'Your Plans',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 25),
              if (userDetailsList.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: userDetailsList.length,
                    itemBuilder: (context, index) {
                      var userDetails = userDetailsList[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Row(
                              children: [
                                Text(
                                  'Email:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    userDetails['email'] ?? 'N/A',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            title: Row(
                              children: [
                                const Text(
                                  'Booked Date:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(width: 8), // Add spacing between label and data
                                Expanded(
                                  child: Text(
                                    userDetails['bookingdate'] ?? 'N/A',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            title: Row(
                              children: [
                                const Text(
                                  'Title:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(width: 8), // Add spacing between label and data
                                Expanded(
                                  child: Text(
                                    userDetails['title'] ?? 'N/A',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            title: Row(
                              children: [
                                const Text(
                                  'Package Duration:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(width: 8), // Add spacing between label and data
                                Expanded(
                                  child: Text(
                                    userDetails['PackageDuration'] ?? 'N/A',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            title: Row(
                              children: [
                                const Text(
                                  'Price:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(width: 8), // Add spacing between label and data
                                Expanded(
                                  child: Text(
                                    userDetails['Price'] ?? 'N/A',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            title: Row(
                              children: [
                                const Text(
                                  'Description:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(width: 8), // Add spacing between label and data
                                Expanded(
                                  child: Text(
                                    userDetails['Description'] ?? 'N/A',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            title: Row(
                              children: [
                                const Text(
                                  'Category Name:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(width: 8), // Add spacing between label and data
                                Expanded(
                                  child: Text(
                                    userDetails['category_name'] ?? 'N/A',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            title: Row(
                              children: [
                                const Text(
                                  'Package Name:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    userDetails['PackageName'] ?? 'N/A',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}


//add plans class from Plans.dart



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

class Booking1 {
  final int id;

  Booking1({
    required this.id,
  });

  factory Booking1.fromJson(Map<String, dynamic> json) {
    return Booking1(
      id: json['id'] as int,
    );
  }
}
*/
