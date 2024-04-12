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
  List<dynamic> data = [];
//  Map<String, dynamic>? userDetails;

  @override
  void initState() {
    super.initState();
    fetchBookingId();
    latestBookingId();
  }

  Future<void> fetchBookingId() async {
    var response = await http.get(Uri.parse('http://$ipAddress/$ProjectName/myBooking.php?userid=${widget.uid}'));
    if (response.statusCode == 200) {
      setState(() {
        bookingids = jsonDecode(response.body);
      });
      int id = bookingids.isNotEmpty ? bookingids[0]['id'] : -1;

      // await fetchUserDetails(id);//displaying user plans
       //fetchData(id); //displaying plans

     /* if (bookingids.isNotEmpty) {
        int id = bookingids[0]['id'];
        await fetchUserDetails(id); // Display user details
      } else {
        fetchData(-1); // Fetch plans when no booking ID is available
      }*/

    } else {
      throw Exception('Failed to load Booking id');
    }
  }

  Future<void> fetchUserDetails(int id) async {
    try {
      var response = await http.get(Uri.parse('http://$ipAddress/$ProjectName/booking-details.php?bookingid=$id'));
      if (response.statusCode == 200) {
        setState(() {
          userDetailsList = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to load user details: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching user details: $error');
    }
  }

  Future<void> latestBookingId() async {
    var response = await http.get(Uri.parse('http://$ipAddress/$ProjectName/latestBookingId.php?userid=${widget.uid}'));
    if (response.statusCode == 200) {
      setState(() {
        bookinglatestId = jsonDecode(response.body);
      });
      int id = bookinglatestId.isNotEmpty ? bookingids[0]['id'] : -1;
     // await fetchUserDetails(id); tried
      if (bookinglatestId.isNotEmpty) {
        int id = bookinglatestId[0]['id'];
        await fetchUserDetails(id); // Display user details
      } else {
        fetchData(-1); // Fetch plans when no booking ID is available
      }
    } else {
      throw Exception('Failed to load Booking id');
    }
  }

  void fetchData(int id) async {

    String url = 'http://$ipAddress/$ProjectName/booking-details.php';
    Map<String, String> headers = {"Content-type": "application/json"};

    try {
      http.Response response = await http.get(Uri.parse('$url?bookingid=$id'), headers: headers);
      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
        });
        return; // Booking details fetched successfully, exit the function
      }
    } catch (e) {
      print('Error fetching booking details: $e');
    }

    // If booking details couldn't be fetched or are empty, fetch plans
    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
        });
      }
    } catch (e) {
      print('Error fetching plans: $e');
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

    /* String? durationDate = calculateDurationDate(
      userDetailsList.isNotEmpty ? userDetailsList[0]['bookingdate'] : null,
      userDetailsList.isNotEmpty ? userDetailsList[0]['PackageDuration'] : null,
    );*/

    String? durationDate;
    if (userDetailsList.isNotEmpty &&
        userDetailsList[0]['bookingdate'] != null) {
      durationDate = calculateDurationDate(
        userDetailsList[0]['bookingdate'],
        userDetailsList[0]['PackageDuration'],
      );
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

      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            //  HomeSlider(),
              const SizedBox(height: 25),
              const Center(
                child: Text(
                  'Your Plans',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Expanded(
                child:
                userDetailsList.isNotEmpty
                    ? ListView.builder(
                  itemCount: userDetailsList.length,
                  itemBuilder: (context, index) {
                    var userDetails = userDetailsList[index];
                    print(userDetails);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Row(
                            children: [
                              const Text(
                                'Email:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  userDetails['email'] ?? 'N/A',
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
                )
                    :  Center(
                //  child: Text('No current plans'),
                    child: PlansPage( uid: widget.uid,
                    durationDate:DateTime.now().toString(),
                ),
                ),
              ),
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
