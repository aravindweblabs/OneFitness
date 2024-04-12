import 'package:flutter/material.dart';

class Genetics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Genetics Page'),
        backgroundColor: const Color(0xFFB070FA),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
    Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Muscle Fiber Type',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Image.asset(
                  'assets/images/gym-18.jpg',
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Fast-Twitch Dominance: If you have a genetic predisposition for fast-twitch muscle fibers, you may excel in explosive, power-based activities. Workout plans could include strength training, plyometrics, and sprinting.\n\nSlow-Twitch Dominance: On the other hand, if your genetics favor slow-twitch muscle fibers, you excel in endurance-based activities. These muscle fibers are well-suited for sustained efforts over extended periods. This genetic bias makes exercises like long-distance running, swimming, or cycling particularly effective for you. At our gym, we acknowledge the significance of genetic diversity and design workout routines that cater to individuals with slow-twitch dominance. We can help you develop the endurance and stamina needed to thrive in these types of activities, all while supporting your fitness goals.',
                  textAlign: TextAlign.start,
                ),
              ],
            ),
    ),
            const SizedBox(height: 20),
    Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
              children: [
                const Text(
                  'Metabolism',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Image.asset(
                  'assets/images/gym-19.jpg',
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Fast Metabolism: Individuals with a fast metabolism may find it easier to stay lean but might need more calories to support muscle growth. High-intensity interval training (HIIT) and weight training can complement this genetic trait.\n\nSlow Metabolism: Conversely, if you have a slower metabolism, you may need to pay closer attention to calorie management. People with slower metabolisms tend to burn calories at a slower rate, which can make it easier to gain weight. However, consistent cardiovascular exercise, including steady-state cardio, can be highly beneficial for individuals with slow metabolisms. This type of exercise helps create a calorie deficit, supporting weight management and overall health. Our gym offers tailored workout routines and nutritional guidance to help individuals with slow metabolisms achieve their fitness goals.',
                  textAlign: TextAlign.start,
                ),
              ],
            ),
    ),
            const SizedBox(height: 20),
    Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
              children: [
                const Text(
                  'Injury Susceptibility',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Image.asset(
                  'assets/images/gym-20.jpg',
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Higher Injury Risk: At our gym, we prioritize your safety and well-being. If you have a genetic predisposition to specific injuries such as joint problems or tendon issues, our experienced trainers and fitness professionals will work with you to develop a customized fitness plan. This plan will include injury prevention exercises, mobility work, and strict attention to proper form during strength training. Our goal is to help you build strength while minimizing the risk of injury, allowing you to achieve your fitness objectives safely.\n\nLower Injury Risk: For those whose genetics suggest a lower risk of injuries, our gym offers a dynamic environment where you can push your limits. You can engage in more intense or high-impact workouts with appropriate caution, knowing that our expert trainers are available to guide and support you. Our focus remains on helping you achieve your fitness goals while ensuring that you exercise safely. Your well-being is our priority.',
                  textAlign: TextAlign.start,
                ),
              ],
            ),
    ),
            const SizedBox(height: 20),
    Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
              children: [
                const Text(
                  'Nutrient Sensitivity',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Image.asset(
                  'assets/images/gym-21.png',
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Carbohydrate Sensitivity: If you are sensitive to carbohydrates, a lower-carb or balanced macronutrient diet may complement your workouts. This might include carb cycling to optimize energy for workouts\n\nFat Sensitivity: Similarly, genetic factors can impact how your body metabolizes fats. For those with specific fat-related genetic factors, a diet emphasizing healthy fats and balanced macronutrients can be highly beneficial. At our gym, we offer guidance on nutrition plans that align with your genetic makeup, ensuring that you\'re fueling your body effectively and promoting optimal fitness outcomes.',
                  textAlign: TextAlign.start,
                ),
              ],
            ),
    ),
            const SizedBox(height: 20),
    Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
              children: [
                const Text(
                  'Recovery and Adaptation',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Image.asset(
                  'assets/images/gym-22.jpg',
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Recovery: At our gym, we understand that genetic variations can play a role in how your body recovers from workouts. That\'s why we emphasize the importance of recovery as an integral part of your fitness journey. Our trainers and coaches will guide you on effective recovery strategies, including optimizing your sleep patterns, maintaining a balanced and nutritious diet, and incorporating active recovery workouts into your routine. By paying close attention to your body\'s recovery needs, you can enhance your overall fitness progress and well-being.\n\nAdaptation: Genetics may influence the rate at which your body adapts to exercise. To ensure continuous progress and prevent plateaus, we employ a periodized approach to your workouts. Our trainers will create personalized training programs that challenge your body in different ways over time. This strategic variation keeps your workouts fresh and helps you continually improve your strength, endurance, and overall fitness. Our goal is to maximize your genetic potential and help you achieve lasting results.',
                  textAlign: TextAlign.start,
                ),
              ],
            ),
    ),
            const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
              children: [
                const Text(
                  'Cardiovascular Health',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Image.asset(
                  'assets/images/gym-23.jpg',
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Heart Health: Genetics indeed play a role in cardiovascular health, but the good news is that regular aerobic exercise can benefit your heart regardless of your genetic predispositions. At our gym, we prioritize cardiovascular workouts as an integral part of your fitness routine. Our goal is to help you improve your heart health, boost endurance, and enhance overall well-being. Our certified trainers will guide you through cardio exercises tailored to your needs, ensuring you receive the full benefits of cardiovascular training.\n\nAt our gym, we recognize the significance of cardiovascular health and its connection to genetics and nutrition. We\'re committed to providing you with a comprehensive fitness experience that addresses these factors, helping you achieve and maintain optimal heart health.',
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
