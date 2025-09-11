import 'package:cinephile/model/movies_model.dart';
import 'package:cinephile/screens/home/bind/home_bind.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_utils/flutter_custom_utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      body: Obx(() {
        final wishlistedMovies = homeController.wishlistedMovies;

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
                  child: wishlistedMovies.isEmpty
                      ? _buildEmptyWishlist()
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: wishlistedMovies.length,
                          itemBuilder: (context, index) {
                            final movie = wishlistedMovies[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: MovieWishlistCard(
                                movie: movie,
                                onRemove: () {
                                  homeController.wishlistedMovies.remove(movie);
                                  // Also update the wishlist status in home screen
                                  final movieIndex = homeController.allMovies
                                      .indexWhere(
                                          (m) => m.movieId == movie.movieId);
                                  if (movieIndex != -1) {
                                    homeController.isWishlisted[movieIndex] =
                                        false;
                                  }
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHeader() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Wishlist',
        style: GoogleFonts.italiana(
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Get.back(),
      ),
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.favorite_border, size: 64, color: Colors.white54),
          const SizedBox(height: 16),
          Text(
            'Your wishlist is empty',
            style: GoogleFonts.italiana(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add movies to your wishlist by tapping the 🤍 icon',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}

class MovieWishlistCard extends StatelessWidget {
  final Data movie;
  final VoidCallback onRemove;

  const MovieWishlistCard({
    super.key,
    required this.movie,
    required this.onRemove,
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
            child: movie.posterPath != null && movie.posterPath!.isNotEmpty
                ? Image.network(
                    movie.posterPath!,
                    width: 100,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                        _buildPlaceholderImage() as String,
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover),
                  )
                : Image.asset(_buildPlaceholderImage() as String,
                    width: 100, height: 150, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.originalTitle ?? 'No Title',
                  style: GoogleFonts.italiana(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      movie.voteAverage?.toStringAsFixed(1) ?? 'N/A',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.how_to_vote,
                        color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      movie.voteCount?.toString() ?? '0',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      movie.releaseDate ?? 'Unknown date',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.language_outlined,
                        color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      movie.originalLanguage ?? 'Unknown',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey.shade800,
      child: const Center(
        child: Icon(Icons.movie, color: Colors.white54, size: 50),
      ),
    );
  }
}
