import 'package:cinephile/model/movies_model.dart';
import 'package:cinephile/res/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_utils/flutter_custom_utils.dart';
import 'package:get/get.dart';
import 'package:cinephile/screens/details/bind/details_bind.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DetailsController>(builder: (logic) {
        // Check if we have movie data
        final movie = logic.movieData;

        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0B5A3D),
                Color(0xFF1B0320),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: Get.height * 0.46,
                      width: Get.width,
                      child: movie.posterPath != null &&
                              movie.posterPath!.isNotEmpty
                          ? Image.network(
                              movie.posterPath!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                      _buildPlaceholderImage() as String,
                                      fit: BoxFit.cover),
                            )
                          : Image.asset(_buildPlaceholderImage() as String,
                              fit: BoxFit.cover),
                    ),
                    _buildHeaderIcons(logic),
                  ],
                ),

                Transform.translate(
                  offset: const Offset(0, -60),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: Get.width,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: [
                            Color(0xFF0B5A3D),
                            Color(0xFF3A0442),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            blurRadius: 15,
                            offset: const Offset(2, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            movie.originalTitle ?? 'No Title',
                            style: GoogleFonts.italiana(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                movie.releaseDate ?? 'Unknown date',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Popularity: ${movie.popularity?.toStringAsFixed(1) ?? 'N/A'}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _buildStarRating(movie.voteAverage ?? 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Description and cast sections
                Transform.translate(
                  offset: const Offset(0, -50),
                  child: Column(
                    children: [
                      _buildDescriptionSection(movie),
                      _buildCastSection(movie),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  List<Widget> _buildStarRating(double rating) {
    final fullStars = rating ~/ 2;
    final hasHalfStar = (rating % 2) >= 0.5;
    final emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return [
      for (int i = 0; i < fullStars; i++)
        const Icon(Icons.star, color: Colors.amber, size: 20),
      if (hasHalfStar)
        const Icon(Icons.star_half, color: Colors.amber, size: 20),
      for (int i = 0; i < emptyStars; i++)
        const Icon(Icons.star_border, color: Colors.white, size: 20),
    ];
  }

  Widget _buildHeaderIcons(DetailsController logic) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back button
            Container(
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
            // Wishlist button
            Obx(() => Container(
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
                      onTap: () => logic.toggleWishlist(),
                      child: Icon(
                        logic.isWishlisted.value
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: logic.isWishlisted.value
                            ? Colors.red
                            : Colors.white,
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionSection(Data movie) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: GoogleFonts.italiana(
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ).cPadOnly(t: 16),
          Text(
            movie.overview ?? 'No overview available.',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.justify,
          ).cPadOnly(t: 15),
        ],
      ),
    );
  }

  Widget _buildCastSection(Data movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Casts',
          style: GoogleFonts.italiana(
            textStyle: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ).cPadOnly(l: 16, t: 16, b: 5),
        if (movie.casts != null && movie.casts!.isNotEmpty)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: movie.casts!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 3,
            ),
            itemBuilder: (context, index) {
              final cast = movie.casts![index];
              return _buildCastCard(
                  cast.name ?? 'Unknown', cast.profilePath ?? user);
            },
          ).cPadOnly(l: 16, r: 16)
        else
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'No cast information available',
              style: TextStyle(color: Colors.white70),
            ),
          ),
      ],
    );
  }

  Widget _buildCastCard(String name, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          ClipOval(
            child: imagePath.isNotEmpty && imagePath != user
                ? Image.network(
                    imagePath,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                        user,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover),
                  )
                : Image.asset(user, width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
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
