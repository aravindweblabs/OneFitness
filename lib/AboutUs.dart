import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: const Color(0xFFB070FA),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'ABOUT US',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Image.asset(
              'assets/images/gym-24.jpg',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 15),
            const Text(
              'At OneFitness Gym, we are more than just a fitness center.'
                  ' We are a community dedicated to helping individuals achieve their health and '
                  'wellness goals. With state-of-the-art facilities and a team of experienced trainers,'
                  ' we provide a holistic approach to fitness that combines personalized workouts, '
                  'nutrition guidance, and ongoing support. Our mission is to empower our members to '
                  'transform their bodies and elevate their overall well-being, making fitness an '
                  'enjoyable and sustainable lifestyle.',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
