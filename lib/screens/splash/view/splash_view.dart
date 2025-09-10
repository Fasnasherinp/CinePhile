import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xFF3A0442),
              Color(0xFF0B5A3D),
            ],
          ),
        ),
        child: Center(
          child: Text(
            'CinePhile',
            style: GoogleFonts.italiana(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 60,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}