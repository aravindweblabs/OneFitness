import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onefitness/phone_pe_payment_test.dart';
import 'constants.dart';

class PlansPage extends StatefulWidget {
  final int uid;
 // final int latestBookingId;
  final String? durationDate;

  PlansPage({
    required this.uid,
   // required this.latestBookingId,
    required this.durationDate,
  });

  @override
  _PlansPageState createState() => _PlansPageState();
}

class _PlansPageState extends State<PlansPage> {
  List<Plan> plans = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    print(widget.durationDate);
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

  DateTime getCurrentDate() {
    return DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plans'),
        backgroundColor: const Color(0xFFB070FA),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              const Center(
                child: Text(
                  'Trending Plans',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: plans.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: PlanContainer(
                      plan: plans[index],
                      onTap: () {
                        onTapPlan(plans[index]);
                      },
                      currentDate: getCurrentDate(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapPlan(Plan plan) {
    if (DateTime.now().isBefore(DateTime.parse(widget.durationDate!))) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ongoing Plan'),
            content: Text('You already have an ongoing plan. Please wait until your current plan expires.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PhonePePayment(
            uid: widget.uid,
            price: double.parse(plan.Price),
            id: plan.id,
            category: plan.category,
            PackageDuration: plan.PackageDuration,
          ),
        ),
      );
    }
  }

}

class Plan {
  final int id;
  final String category;
  final String titlename;
  final String PackageType;
  final String PackageDuration;
  final String Price;
  final String Description;

  Plan({
    required this.id,
    required this.category,
    required this.titlename,
    required this.PackageType,
    required this.PackageDuration,
    required this.Price,
    required this.Description,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'] as int,
      category: json['category'] as String,
      titlename: json['titlename'] as String,
      PackageType: json['PackageType'] as String,
      PackageDuration: json['PackageDuration'] as String,
      Price: json['Price'] as String,
      Description: json['Description'] as String,
    );
  }
}

class PlanContainer extends StatelessWidget {
  final Plan plan;
  final VoidCallback? onTap;
  final DateTime currentDate;

  PlanContainer({
    required this.plan,
    this.onTap,
    required this.currentDate,
  });

  @override
  Widget build(BuildContext context) {
    int packageDurationInDays = int.tryParse(plan.PackageDuration) ?? 0;
    DateTime expiryDate = currentDate.add(Duration(days: packageDurationInDays));
    bool isExpired = currentDate.isAfter(expiryDate) || currentDate.isAtSameMomentAs(expiryDate);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plan.titlename,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Price: ${plan.Price}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Package Duration: ${plan.PackageDuration} Days',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              plan.Description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  onTap?.call();
                  if (!isExpired) {
                    // Navigate to payment page
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Ongoing Plan Detected'),
                          content: Text('You already have an ongoing plan. Please wait until your current plan expires.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text(isExpired ? 'Expired' : 'Book Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isExpired ? Colors.grey : const Color(0xFFB070FA),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
