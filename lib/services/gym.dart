import 'package:flutter/material.dart';

class Gym extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gym Page'),
        backgroundColor: const Color(0xFFB070FA),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              'Treadmills',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(
              'assets/images/gym-6.jpg',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text:
                        'At our gym, we offer a cutting-edge selection of treadmills, providing you with a convenient and effective way to improve your cardiovascular health and boost your fitness levels. Treadmill workouts offer a versatile and accessible option for individuals of all fitness levels, whether you\'re a beginner or a seasoned athlete.\n\nJoin us at our gym and experience the convenience of indoor treadmill workouts. Rain or shine, you can get your daily dose of cardio and stay committed to your fitness regimen. Whether you\'re aiming for weight loss, improved endurance, or simply a healthier lifestyle, our treadmills are here to support you on your fitness journey.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Indoor Cycling',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(
              'assets/images/gym-7.jpg',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text:
                      'At our gym, we offer exhilarating Indoor Cycling classes that take your cardio workouts to the next level. Indoor Cycling, also known as Spinning, is a high-energy and low-impact exercise that combines the benefits of cardiovascular conditioning with the thrill of group fitness.\n\nJoin our Indoor Cycling classes to enjoy a full-body workout that boosts your energy, relieves stress, and leaves you with a sense of accomplishment. Whether you\'re a beginner or an experienced cyclist, our classes are tailored to accommodate all fitness levels. So, hop on your bike and pedal your way to a healthier, happier you!',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Rowing Machines',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(
              'assets/images/gym-8.jpg',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text:
                      'At our gym, we offer a comprehensive cardio experience with the inclusion of rowing machines. Rowing is a highly effective and low-impact exercise that engages your entire body, providing an intense cardiovascular workout while also building strength and endurance.\n\nWhether you\'re new to rowing or an experienced rower, our gym provides the perfect environment for you to enjoy the benefits of this versatile exercise. Rowing can help you burn calories, enhance endurance, and develop muscular strength—all while being gentle on your joints. Join us and experience the rewarding and invigorating world of rowing at our gym!',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Free Weights',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(
              'assets/images/gym-9.jpg',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text:
                      'At Onefitness Gym, we\'re dedicated to providing you with the ultimate fitness experience. Our state-of-the-art gym facilities include a comprehensive range of free weights that cater to all fitness levels.\n\n',
                    ),
                    TextSpan(
                      text:
                      'Unleash Your Potential:\nAt our gym, we provide a dedicated space for free weight training, allowing you to unlock the full potential of your strength and build a sculpted physique. Free weights are a fundamental component of any comprehensive fitness routine, offering versatility, functional strength development, and unparalleled muscle engagement.\n\nThe versatility of free weights allows for a wide range of exercises that target various muscle groups. From dumbbells to barbells and kettlebells, our gym provides you with the tools to perform exercises that promote functional strength development and engage muscles like never before.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Kettlebells',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(
              'assets/images/gym-10.jpg',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                        text:
                        'Kettlebells are versatile fitness tools that have gained immense popularity in recent years. These cannonball-shaped weights with handles offer a unique and effective way to improve strength, endurance, and overall fitness.\n\nWith kettlebells, you can perform a wide range of exercises that target various muscle groups, including swings, squats, and presses. Their design allows for fluid, functional movements that engage the entire body, making them ideal for full-body workouts.\n\nIncorporating kettlebells into your fitness regimen not only helps you build strength and endurance but also promotes core stability, flexibility, and improved posture. Whether you re a seasoned fitness enthusiast or just beginning your fitness journey, kettlebell training offers a rewarding and effective path to your health and wellness goals.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Power Yoga',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(
              'assets/images/gym-11.jpg',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text:
                      'Power Yoga is a dynamic and energetic form of yoga that blends traditional yoga poses with elements of strength training and cardio. This vigorous practice focuses on building both physical and mental endurance, helping you achieve balance, flexibility, and strength in every session.\n\n',
                    ),
                    TextSpan(
                      text:
                      'With its fast-paced sequences and emphasis on breath control, Power Yoga not only enhances your physical fitness but also promotes mindfulness and stress relief. It s a perfect choice for those seeking a challenging workout that engages both body and mind.\n\nOur Yoga Studio: A Sanctuary for Transformation\nJoin us at OneFitness to experience the invigorating and transformative effects of Power Yoga. Whether you re a seasoned yogi or a newcomer, our experienced instructors will guide you through empowering routines that leave you feeling refreshed, reenergized, and ready to take on the world.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
