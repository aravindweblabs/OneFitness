import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController enquiryController = TextEditingController();


  Future<void> _sendEnquiry() async {
    final String uri = 'http://$ipAddress/$ProjectName/submit_form.php';
    try {
      final response = await http.post(
        Uri.parse(uri),
        body: {
       'name': nameController.text,
       'email': emailController.text,
       'phone' : mobileController.text,
       'message': enquiryController.text,
        },
      );

      if (response.statusCode == 200) {
        nameController.clear();
        emailController.clear();
        mobileController.clear();
        enquiryController.clear();
          print('User details updated successfully');
        } else {
          print('Failed to update user details');
        }
    } catch (error) {
      print('Error updating user details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
        backgroundColor: const Color(0xFFB070FA),
      ),
      body: SingleChildScrollView(
      child:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Enquiry Details',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextFormField(
              controller: mobileController,
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
              ),
            ),
            TextFormField(
              controller: enquiryController,
              decoration: const InputDecoration(
                labelText: 'Enquiry',
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Container(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    _sendEnquiry();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFB070FA)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Adjust the radius as needed
                      ),
                    ),
                  ),
                  child: const Text('Submit'),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Trainer:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            const Text(
              'IMRAN KHAN',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Email:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            const Text(
              'razzakfitness1997@gmail.com',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Contact No:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            const Text(
              '9951667220, 9700112209',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Address:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            const Text(
              'Onefitness, Vijetha Super Market opposite, Bachupally, '
                  'Hyderabad. Telangana, 500090',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
