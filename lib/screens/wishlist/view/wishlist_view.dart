import 'package:cinephile/res/images.dart';
import 'package:cinephile/screens/wishlist/bind/wishlist_bind.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_utils/flutter_custom_utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<WishListController>(
          builder: (logic) {
            return Container(
              width: context.cWidth,
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
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: 5, // Set the item count to 5
                        itemBuilder: (context, index) {
                          // You can use a list of data here, but for this example, we'll use static data.
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 16.0), // Add padding between items
                            child: MovieWishlistCard(
                              title: 'Spiderman',
                              voteAverage: '9.5',
                              voteCount: '323',
                              releaseDate: '2019',
                              language: 'En',
                              imagePath: movie, // Placeholder
                            ),
                          );
                        },
                      ),
                    )                  ],
                ),
              ),
            );
          }
      ),
    );
  }
  Widget _buildHeader() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title:  Text(
        'Wishlist',
        style: GoogleFonts.italiana(
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 24,fontWeight: FontWeight.bold
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Get.back(),
      ),
    );
  }
}

class MovieWishlistCard extends StatelessWidget {
  final String title;
  final String voteAverage;
  final String voteCount;
  final String releaseDate;
  final String language;
  final String imagePath;

  const MovieWishlistCard({
    super.key,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
    required this.language,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              width: 100,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.italiana(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      voteAverage,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.how_to_vote, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      voteCount,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      releaseDate,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.language_outlined, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      language,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}