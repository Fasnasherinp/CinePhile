import 'package:cinephile/res/images.dart';
import 'package:cinephile/utilities/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xFF3A0442),
              Color(0xFF0B5A3D),
            ],
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
            Text(
              'Watch movies in\nVirtual Reality',
              textAlign: TextAlign.center,
              style: GoogleFonts.italiana(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
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
                    Get.toNamed(Routes.home);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.transparent,
                    side: BorderSide.none,
                  ),
                  child: const Text(
                    'Next',
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
