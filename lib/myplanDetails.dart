import 'dart:typed_data';
//import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'constants.dart';
import 'dart:io';
//import 'package:pdf/widgets.dart' as pw;

class MyPlanDetails extends StatefulWidget {

  final int id;

  MyPlanDetails({required this.id});

  @override
  _MyPlanDetailsState createState() => _MyPlanDetailsState();
}

class _MyPlanDetailsState extends State<MyPlanDetails> {
  // Map<String, dynamic> userDetails = {};

  List<dynamic> userDetailsList = [];

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

 /* Future<Uint8List> _generatePdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: userDetailsList.map((userDetails) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Email: ${userDetails['email'] ?? 'N/A'}'),
                pw.Text('Booked Date: ${userDetails['bookingdate'] ?? 'N/A'}'),
                pw.Text('Title: ${userDetails['title'] ?? 'N/A'}'),
                pw.Text('Package Duration: ${userDetails['PackageDuration'] ?? 'N/A'}'),
                pw.Text('Price: ${userDetails['Price'] ?? 'N/A'}'),
                pw.Text('Description: ${userDetails['Description'] ?? 'N/A'}'),
                pw.Text('Category Name: ${userDetails['category_name'] ?? 'N/A'}'),
                pw.Text('Package Name: ${userDetails['PackageName'] ?? 'N/A'}'),
              ],
            );
          }).toList(),
        ),
      ),
    );
    return pdf.save();
  }*/

  /*Future<void> _share() async {
    try {
      // Generate PDF bytes
      final Uint8List pdfBytes = await _generatePdf();

      // Write PDF to file
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/booking_summary.pdf';
      final file = File(filePath);
      await file.writeAsBytes(pdfBytes);

      // Share the PDF file
      await Share.shareFiles([filePath], text: 'Booking Summary');
    } catch (e) {
      print('Error sharing: $e');
    }
  }
*/

 /* void shareDetails() {
    String details = "";

    for (var userDetails in userDetailsList) {
      details += "Email: ${userDetails['email'] ?? 'N/A'}\n";
      details += "Booked Date: ${userDetails['bookingdate'] ?? 'N/A'}\n";
      details += "Title: ${userDetails['title'] ?? 'N/A'}\n";
      details +=
      "Package Duration: ${userDetails['PackageDuration'] ?? 'N/A'}\n";
      details += "Price: ${userDetails['Price'] ?? 'N/A'}\n";
      details += "Description: ${userDetails['Description'] ?? 'N/A'}\n";
      details +=
      "Category Name: ${userDetails['category_name'] ?? 'N/A'}\n";
      details +=
      "Package Name: ${userDetails['PackageName'] ?? 'N/A'}\n\n";
    }
    Share.share(details);
  }*/


  Future<void> fetchUserDetails() async {
    try {
      var response = await http.get(Uri.parse('http://$ipAddress/$ProjectName/booking-details.php?bookingid=${widget.id}'));
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Plan Details'),
        backgroundColor: const Color(0xFFB070FA),
        /*actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: shareDetails,
          ),
        ],*/
      ),
      body: userDetailsList.isNotEmpty
          ? ListView.builder(
        itemCount: userDetailsList.length,
        itemBuilder: (context, index) {
          var userDetails = userDetailsList[index];
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
                    const SizedBox(width: 8), // Add spacing between label and data
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
          : const Center(child: CircularProgressIndicator()),

    );
  }
}
