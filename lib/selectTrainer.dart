import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';

class SelectTrainer extends StatefulWidget {
  final int uid;

  SelectTrainer({required this.uid});

  @override
  _SelectTrainerState createState() => _SelectTrainerState();
}

class _SelectTrainerState extends State<SelectTrainer> {
  late Future<List<Trainer>> _trainersFuture;
  List<dynamic> yourTrainerDetails = [];

  @override
  void initState() {
    super.initState();
    _trainersFuture = fetchTrainers();
    yourTrainer();
  }

  Future<List<Trainer>> fetchTrainers() async {
    final response = await http.get(
        Uri.parse(
            'http://$ipAddress/$ProjectName/getTrainerDetails.php?userid=${widget
                .uid}'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => Trainer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> selectTrainer(int trainerId) async {
    // Send the trainer ID to the PHP code using HTTP request
    var response = await http.post(
      Uri.parse('http://$ipAddress/$ProjectName/addTrainerToUser.php'),
      // headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'trainerId': trainerId.toString(),
        'userid': widget.uid.toString(),
      },
    );

    if (response.statusCode == 200) {
      print('Trainer selected successfully');
    } else {
      print('Failed to select trainer');
    }
  }


  Future<void> yourTrainer() async {
    try {
      var response = await http.get(Uri.parse(
          'http://$ipAddress/$ProjectName/yourTrainer.php?userid=${widget
              .uid}'));
      if (response.statusCode == 200) {
        setState(() {
          yourTrainerDetails = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to load trainer details: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching user details: $error');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Trainer'),
        backgroundColor: const Color(0xFFB070FA),
      ),
      body: FutureBuilder<List<Trainer>>(
        future: _trainersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Trainer>? trainers = snapshot.data;
            return ListView.builder(
              itemCount: trainers!.length + 1,
              itemBuilder: (context, index) {
                if (index < trainers.length) {
                  Trainer trainer = trainers[index];
                  return ListTile(
                    title: Text('${trainer.fname} ${trainer.lname}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Expertise: ${trainer.expertise}'),
                        Text('Email: ${trainer.email}'),
                        Text('Phone: ${trainer.phno}'),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm Selection'),
                              content: Text('Do you want to select ${trainer
                                  .fname} ${trainer.lname}?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    selectTrainer(trainer.trainerId);
                                    Navigator.of(context).pop();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<
                                        Color>(const Color(0xFFB070FA)),
                                  ),
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFB070FA)),
                      ),
                      child: Text('Select'),
                    ),
                  );
                }else {
                  if (yourTrainerDetails.isNotEmpty) {
                    Map<String, dynamic> trainerDetails = yourTrainerDetails.first;
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Your Trainer',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Name: ${trainerDetails['fname']} ${trainerDetails['lname']}'),
                          Text('Email: ${trainerDetails['email']}'),
                          Text('Phone Number: ${trainerDetails['phno']}'),
                          Text('Expertise: ${trainerDetails['expertise']}'),
                        ],
                      ),
                    );
                  } else {
                    const Text('No trainer selected');
                  }
                }
              },
            );
          }
        },
      ),
    );
  }
}

class Trainer {
  final int trainerId;
  final String fname;
  final String lname;
  final String email;
  final String phno;
  final String expertise;

  Trainer({
    required this.trainerId,
    required this.fname,
    required this.lname,
    required this.email,
    required this.phno,
    required this.expertise,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      trainerId: json['trainerId'] as int,
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      email: json['email'] as String,
      phno: json['phno'] as String,
      expertise: json['expertise'] as String,
    );
  }
}
