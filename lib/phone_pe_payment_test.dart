import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class PhonePePayment extends StatefulWidget {
  final int uid;
  final double price;
  final int id;
  final String category;
  final String PackageDuration;

  PhonePePayment({
    required this.uid,
    required this.price,
    required this.id,
    required this.category,
    required this.PackageDuration,
  });


  @override
  State<PhonePePayment> createState() => _PhonePePaymentState();
}

class _PhonePePaymentState extends State<PhonePePayment> {
  String environment = 'SANDBOX';
  String appId = "";
  String merchantId = "PGTESTPAYUAT";
  bool enableLogging = true;
  String checkSum = "";
  String saltKey = "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399";
  String saltIndex = "1";
  String callBackUrl =
  //"abconefitness123://paymentsweblabs123";
     // "https://www.google.com/?client=safari";
  "https://webhook.site/919d1ec6-af39-490d-890f-99ee193c0fff";
 // "https://$ipAddress/$ProjectName/payments.php?uid=${widget.uid}";


  String body = "";
  String apiEndPoint = "/pg/v1/pay";
  Object? result;

  @override
  void initState() {
    super.initState();
    //callBackUrl ='https://$ipAddress/$ProjectName/payments.php?user_id=${widget.uid}';
    phonePayInit();
    body = getCheckSum().toString();
    startPgTransaction();

  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Text("Result \n $result"),
            Text("Loading..."),
          ],
        ),
      ),
    );
  }

  void phonePayInit() {
    PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) => {
      setState(() {
        result = 'PhonePe SDK Initialized - $val';
      })
    })
        .catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
  }

  void handleError(error) {
    setState(() {
      result = {"error": error};
    });
  }

  void startPgTransaction() async {
    // Make sure body is initialized before using it
    if (body.isEmpty) {
      handleError("Body not initialized");
      return;
    }

    PhonePePaymentSdk.startTransaction(body, callBackUrl, checkSum, "")
        .then((response) => {
      setState(() {
        if (response != null) {
          String status = response['status'].toString();
          String error = response['error'].toString();
          if (status == 'SUCCESS') {
            result = "Flow Complete - Status : Success";
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SuccessPage(uid: widget.uid,
                  id: widget.id,
                  price: widget.price,
                  category: widget.category,
                  PackageDuration: widget.PackageDuration,
                )),
              );
          } else {
            result = "Flow Complete - Status : $status and error $error";
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FailurePage(
                widget.uid,
              )),
            );
          }
        } else {
          result = "Flow Incomplete";
        }
      })
    })
        .catchError((error) {
      // handleError(error)
      return <dynamic>{};
    });
  }

  String getCheckSum() {
    int amount = (widget.price * 100).round();
    final requestData = {
      "merchantId": merchantId,
      "merchantTransactionId": "MT7850590068188104",
      "merchantUserId": "MUID123",
      "amount": amount.toString(),
      "callbackUrl": callBackUrl,
      "mobileNumber": "9999999999",
      "paymentInstrument": {"type": "PAY_PAGE"}
    };

    String base64Body = base64Encode(utf8.encode(jsonEncode(requestData)));

    checkSum =
    '${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex';
    print('Base64 Body: $base64Body');


    return base64Body;
  }
}


class SuccessPage extends StatefulWidget {
  final int uid;
  final int id;
  final double price;
  final String category;
  final String PackageDuration;

  SuccessPage({
    required this.uid,
    required this.id,
    required this.price,
    required this.category,
    required this.PackageDuration,
  });

  @override
  _SuccessPageState createState() => _SuccessPageState();
}


class _SuccessPageState extends State<SuccessPage> {
  late String transactionId;
  Future<void> addBooking(int userId, int id, String category,String PackageDuration) async {
    Map<String, dynamic> bookingDetails = {
      'userid': userId.toString(),
      'package_id': id.toString(),
      'cate_id': category,
      'PackageDuration':PackageDuration,
    };

// Error adding payment details: type 'int' is not a subtype of type 'String' in type cast
    var response = await http.post(
      Uri.parse('http://$ipAddress/$ProjectName/addPlan.php'),
      body: bookingDetails,
    );

    // Check the response status
    if (response.statusCode == 200) {
      print('Booking details sent successfully');
    } else {
      print('Failed to send booking details');
    }
  }

  Future<void> addIntoTblBooking(int userId, int id, double price,String PackageDuration) async {
    Map<String, dynamic> tblbookingDetails = {
      'userid': userId.toString(),
      'package_id': id.toString(),
      'Booking_amount':widget.price.toString(),
      'PackageDuration':PackageDuration,
    };

// Error adding payment details: type 'int' is not a subtype of type 'String' in type cast
    var response = await http.post(
      Uri.parse('http://$ipAddress/$ProjectName/addBooking.php'),
      body: tblbookingDetails,
    );

    // Check the response status
    if (response.statusCode == 200) {
      print('tblBooking details sent successfully');
    } else {
      print('Failed to send tblbooking details');
    }
  }

  Future<void> sendPaymentDetails() async {
    // Construct the payment details payload
    transactionId = generateTransactionId();

    Map<String, dynamic> paymentDetails = {
      'user_id': widget.uid.toString(),
      'payment': widget.price.toString(),
      'TransactionId': transactionId,
      'userpackageid': widget.id.toString(),
    };

    // Send the payment details via HTTP POST request
    var response = await http.post(
      Uri.parse('http://$ipAddress/$ProjectName/payments.php'),
      body: paymentDetails,
    );

    // Check the response status
    if (response.statusCode == 200) {
      print('Payment details sent successfully');
    } else {
      print('Failed to send payment details');
    }
  }


  String generateTransactionId() {
    int randomNumber = Random().nextInt(900000) + 100000;
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    String transactionId = 'wl$randomNumber$timestamp';
    return transactionId;
  }


  @override
  void initState() {
    super.initState();
    addBooking(widget.uid, widget.id, widget.category, widget.PackageDuration).then((_) {
      print('Booking details added successfully');
    }).catchError((error) {
      print('Error adding booking details: $error');
    });
    addIntoTblBooking(widget.uid, widget.id, widget.price, widget.PackageDuration).then((_) {
      print('Booking details added successfully');
    }).catchError((error) {
      print('Error adding booking details: $error');
    });
    sendPaymentDetails().then((_) {
      print('Payment details added successfully');
    }).catchError((error) {
      print('Error adding payment details: $error');
    });


    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(uid:widget.uid)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success Page'),
      ),
      body: Center(
        child: Text('Payment Successful!'),
      ),
    );
  }
}




class FailurePage extends StatefulWidget {
  final int uid;
  FailurePage(this.uid);
  @override
  _FailurePageState createState() => _FailurePageState();
}

class _FailurePageState extends State<FailurePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(
          uid:widget.uid,
        )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Failure Page'),
      ),
      body: const Center(
        child: Text('Payment Failed!'),
      ),
    );
  }
}