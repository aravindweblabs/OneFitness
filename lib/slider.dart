import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: [
            Image.asset('assets/images/gym-2.jpeg', fit: BoxFit.cover),
            Image.asset('assets/images/gym-3.webp', fit: BoxFit.cover),
            Image.asset('assets/images/gym-4.jpeg', fit: BoxFit.cover),
            Image.asset('assets/images/gym-5.webp', fit: BoxFit.cover),
          ],
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
          //  aspectRatio: 17 / 10,
            aspectRatio: 20 / 25,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
          ),
        ),
      ],
    );
  }
}

