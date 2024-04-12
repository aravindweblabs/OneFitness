import 'package:flutter/material.dart';

class Nutrition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition Page'),
        backgroundColor: const Color(0xFFB070FA),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.all(20),
          child:
            Column(
              children: [
                const Text(
                  'Lean Proteins',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Image.asset(
                  'assets/images/gym-12.jpg',
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Lean proteins are an indispensable component of a balanced diet, particularly for individuals pursuing fitness and health goals. These protein sources are characterized by their relatively low fat content while being rich in essential nutrients. Here\'s a closer look at some popular lean protein options:\n\nChicken breast, Turkey, Lean beef, Salmon, Tuna, Eggs (especially egg whites)',
                  textAlign: TextAlign.start,
                ),
              ],
            ),
        ),
            const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.all(20),
          child:
            Column(
              children: [
                const Text(
                  'Complex Carbohydrates',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Image.asset(
                  'assets/images/gym-13.jpg',
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Complex carbohydrates are a fundamental component of a balanced diet, especially for individuals engaged in regular physical activity and fitness routines. These carbohydrates are rich in fiber and provide a sustained source of energy, making them a valuable choice for fueling workouts and promoting overall well-being. Here\'s a brief overview of some excellent sources of complex carbohydrates:\n\nBrown rice, Quinoa, Oats, Sweet potatoes, Whole wheat pasta, Legumes (e.g., lentils, chickpeas, black beans)!',
                  textAlign: TextAlign.start,
                ),
              ],
            ),
        ),
            const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.all(20),
          child:
            Column(
              children: [
                const Text(
                  'Healthy Fats',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Image.asset(
                  'assets/images/gym-14.jpg',
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Healthy fats are an essential part of a balanced diet, especially for individuals focused on maintaining good health and fitness. They provide a concentrated source of energy and offer various health benefits. Here\'s a brief overview of some excellent sources of healthy fats:\n\nAvocado Nuts (e.g., almonds, walnuts), Seeds (e.g., chia seeds, flaxseeds), Olive oil, Fatty fish (e.g., salmon, mackerel)',
                  textAlign: TextAlign.start,
                ),
              ],
            ),
        ),
            const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.all(20),
          child:
            Column(
              children: [
                const Text(
                  'Fruits and Vegetables',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Image.asset(
                  'assets/images/gym-15.jpg',
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Fruits and vegetables are vital components of a balanced diet for gym-goers and anyone seeking to maintain good health and fitness. They provide a wide range of essential vitamins, minerals, fiber, and antioxidants that support overall well-being and physical performance. Here\'s a brief overview of some nutrient-rich fruits and vegetables commonly included in fitness-oriented diets:\n\nBerries (blueberries, strawberries, etc.), Leafy greens (spinach, kale, broccoli), Bananas, Oranges, Apples, Carrots',
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Dairy and Dairy Alternatives',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Image.asset(
                  'assets/images/gym-16.jpg',
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Dairy and dairy alternatives are valuable sources of essential nutrients, particularly protein and calcium, which are essential for muscle health, bone strength, and overall well-being. Gym-goers often include these options in their diets to support their fitness goals. Here\'s a brief overview of some common dairy and dairy alternatives:\n\nGreek yogurt, Cottage cheese, Almond milk, Soy milk',
                  textAlign: TextAlign.start,
                ),
              ],
            ),
        ),
            const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(20),
          child:
            Column(
              children: [
                const Text(
                  'Supplements',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Image.asset(
                  'assets/images/gym-17.jpg',
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Supplements can be a useful addition to a gym-goer\'s diet, but they should be considered as supplements rather than replacements for whole foods. Here are a few common supplements often used by individuals pursuing fitness goals:\n\nWhey protein powder, Creatine, Branched-Chain Amino Acids (BCAAs), Pre-workout supplements (consult a healthcare professional)',
                  textAlign: TextAlign.start,
                ),
              ],
            ),
        ),
          ],
        ),
      ),
    );
  }
}