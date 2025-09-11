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
                                  // homeController.wishlistedMovies.remove(movie);
                                  // // Also update the wishlist status in home screen
                                  // final movieIndex = homeController.allMovies
                                  //     .indexWhere(
                                  //         (m) => m.movieId == movie.movieId);
                                  // if (movieIndex != -1) {
                                  //   homeController.isWishlisted[movieIndex] =
                                  //       false;
                                  // }
                                  homeController.removeFromWishlist(movie);

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
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [
                Color(0xFF2E0249),
                Color(0xFF0B5A3D),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
            ),
          ),
        ),
      ),

    );
  }

  Widget _buildEmptyWishlist() {
    return Container(
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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated icon with shadow
              const Icon(
                Icons.auto_awesome,
                size: 80,
                color: Color(0x510E98FF),
              ),
              const SizedBox(height: 30),
              // Title with custom styling
              Text(
                'No Favorites Yet',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Description text
              Text(
                'Movies you love will appear here',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              // Decorative elements
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star_border, color: Colors.amber.shade300, size: 16),
                  const SizedBox(width: 8),
                  Icon(Icons.star_border, color: Colors.amber.shade300, size: 20),
                  const SizedBox(width: 8),
                  Icon(Icons.star_border, color: Colors.amber.shade300, size: 16),
                ],
              ),
              const SizedBox(height: 30),
              // Hint text with icon
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(Icons.touch_app, size: 18, color: Colors.pink.shade200),
                  const SizedBox(width: 8),
                  Text(
                    'Tap the 🤍 to add movies',
                    style: TextStyle(
                      color: Colors.white54,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }}

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
                  movie.originalTitle ?? ' Title',
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
                      movie.voteAverage?.toStringAsFixed(1) ?? '',
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
