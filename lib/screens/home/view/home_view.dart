// home_view.dart
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinephile/screens/home/bind/home_bind.dart';
import 'package:cinephile/utilities/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              _buildScrollableContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'What do you want to watch?',
                  style: GoogleFonts.italiana(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 0,
                child: IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.white, size: 30),
                  onPressed: () {
                    Get.toNamed(Routes.wishlist);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: const TextStyle(color: Colors.white54),
              prefixIcon: const Icon(Icons.search, color: Colors.white54),
              suffixIcon: const Icon(Icons.mic, color: Colors.white54),
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildScrollableContent() {
    final HomeController logic = Get.find();

    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: logic.scrollController.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBannerSection(),
                  const SizedBox(height: 20),
                  _buildPopularMoviesSection(),
                  const SizedBox(height: 20),
                  // Loading indicator for pagination
                  Obx(() {
                    if (logic.isLoading.value && logic.allMovies.isNotEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return const SizedBox();
                  }),
                  // No more items indicator
                  Obx(() {
                    if (!logic.hasMore.value && logic.allMovies.isNotEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'No more movies to load',
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildPopularMoviesSection() {
    final HomeController logic = Get.find();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular',
            style: GoogleFonts.italiana(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Obx(() {
            if (logic.allMovies.isEmpty && logic.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (logic.allMovies.isEmpty) {
              return const Center(
                child: Text(
                  'No movies found',
                  style: TextStyle(color: Colors.white54),
                ),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: logic.allMovies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final movieData = logic.allMovies[index];
                return InkWell(
                  onTap: (){
                    Get.toNamed(Routes.details, arguments: movieData);
                  },
                  child: MovieGridItem(
                    imagePath: movieData.posterPath ?? '',
                    movieTitle: movieData.originalTitle ?? '',
                    index: index,
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBannerSection() {
    final HomeController logic = Get.find();

    return Obx(() {
      if (logic.allMovies.isEmpty && logic.isLoading.value) {
        return Container(
          height: 200,
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        );
      }

      // Show placeholder if no movies
      if (logic.allMovies.isEmpty) {
        return Container(
          height: 200,
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(
            child: Icon(Icons.movie, color: Colors.white54, size: 50),
          ),
        );
      }

      // Use the first few movies for banner (max 5)
      final bannerMovies = logic.allMovies.take(5).toList();

      return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: CarouselSlider.builder(
          itemCount: bannerMovies.length,
          itemBuilder: (context, index, realIndex) {
            final movieData = bannerMovies[index];
            final imageUrl = movieData.posterPath ?? '';

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    // Movie poster image
                    imageUrl.isNotEmpty
                        ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildPlaceholderImage(),
                    )
                        : _buildPlaceholderImage(),

                    // Gradient overlay for better text visibility
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),

                    // Movie title overlay
                    Positioned(
                      bottom: 20,
                      left: 15,
                      right: 15,
                      child: Text(
                        movieData.originalTitle ?? 'No Title',
                        style: GoogleFonts.italiana(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 16 / 9,
            enlargeCenterPage: true,
            viewportFraction: 1,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            enableInfiniteScroll: true,
          ),
        ),
      );
    });
  }
// Helper method for placeholder image
  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey.shade800,
      child: const Center(
        child: Icon(Icons.movie, color: Colors.white54, size: 50),
      ),
    );
  }

}

class MovieGridItem extends StatelessWidget {
  final String imagePath;
  final String movieTitle;
  final int index;

  const MovieGridItem({
    super.key,
    required this.imagePath,
    required this.movieTitle,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(color: Colors.grey.shade300),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
              ),
              child: Text(
                movieTitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.italiana(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Obx(() {
              final homeController = Get.find<HomeController>();
              if (index >= homeController.isWishlisted.length) {
                return const SizedBox.shrink();
              }
              return GestureDetector(
                onTap: () {
                  homeController.toggleWishlist(index);
                },
                child: Icon(
                  homeController.isWishlisted[index]
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: homeController.isWishlisted[index]
                      ? Colors.red
                      : Colors.white,
                ),
              );
            }),
          ),        ],
      ),
    );
  }
}