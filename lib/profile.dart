import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'constants.dart';

class Profile extends StatefulWidget {
  final int uid;

  Profile({required this.uid});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData(widget.uid);
  }

  Future<void> _fetchUserData(int uid) async {
    final String uri = 'http://$ipAddress/$ProjectName/profile.php?uid=$uid';

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        Map<String, dynamic> userData = jsonDecode(response.body);
        bool success =userData['success'];
        if (success) {
          setState(() {
            fnameController.text = userData['fname'];
            lnameController.text = userData['lname'];
            emailController.text = userData['email'];
            mobileController.text = userData['mobile'];
            addressController.text = userData['address'];
            stateController.text = userData['state'];
            cityController.text = userData['city'];
            heightController.text = userData['height'];
            weightController.text = userData['weight'].toString();
            ageController.text = userData['age'].toString();
            genderController.text = userData['gender'];
          });
        }
      } else {
        print('Failed to fetch user data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  Future<void> _updateUserData() async {
    final String uri = 'http://$ipAddress/$ProjectName/profileUpdate.php';
    try {
      final response = await http.post(
        Uri.parse(uri),
        body: {
          'uid': widget.uid.toString(),
          'fname': fnameController.text,
          'lname': lnameController.text,
          'email': emailController.text,
          'mobile': mobileController.text,
          'address': addressController.text,
          'state': stateController.text,
          'city': cityController.text,
          'height': heightController.text,
          'weight': weightController.text,
          'age': ageController.text,
          'gender': genderController.text,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success']) {
          print('User details updated successfully');
        } else {
          print('Failed to update user details: ${responseData['message']}');
        }
      } else {
        print('Failed to update user details. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating user details: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFFB070FA),
      ),
      body: SingleChildScrollView(
       child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Profile Details',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: fnameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
              ),
            ),
            TextField(
              controller: lnameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
              ),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: mobileController,
              decoration: const InputDecoration(
                labelText: 'Mobile',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Height',
              ),
              controller: heightController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Weight',
              ),
              controller: weightController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Age',
              ),
              controller: ageController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Gender',
              ),
              controller: genderController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Address',
              ),
              controller: addressController,
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Container(
                width: 150,
                height: 40,
                child: ElevatedButton(
                  onPressed: _updateUserData,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFB070FA)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                  child: const Text('Update'),
                ),
              ),
            )
          ],
        ),
      ),
      ),
    );
  }
}
