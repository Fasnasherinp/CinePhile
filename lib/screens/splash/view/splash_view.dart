import 'package:cinephile/res/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            // Set the gradient to go from top to bottom
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              // Start with the top colors from your design
              Color(0xFF3A0442),
              Color(0xFF0B5A3D),
              // End with a dark color, which will be black at the very bottom
              // Color(0xFF000000),
            ],
            // Use stops to control where the colors change
            // The values must be between 0.0 and 1.0.
            // stops: [0.3, 0.7, 7.0],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Spacer(flex: 2),
            Container(
              height: Get.width * 0.8,
              width: Get.width * 0.8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color(0xFFE93BFF),
                    Color(0xFF00C7FF),
                  ],
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  splash,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Spacer(),
            const Text(
              'Watch movies in\nVirtual Reality',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFE93BFF),
                      Color(0xFF00C7FF),
                    ],
                  ),
                ),
                child: OutlinedButton(
                  onPressed: () {
                    Get.toNamed('/home');
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.transparent,
                    side: BorderSide.none,
                  ),
                  child: const Text(
                    'Enter Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Spacer(),

          ],
        ),
      ),
    );
  }
}