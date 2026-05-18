import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorite_controller.dart';
import '../routes/app_routes.dart';

class FavoritePage extends StatelessWidget {
  final FavoriteController _favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDE8E9),
      appBar: AppBar(
        title: const Text(
          'Favorite Shows',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pink,
        elevation: 0,
      ),
      body: Obx(() {
        if (_favoriteController.favoriteShows.isEmpty) {
          return const Center(child: Text('No favorite shows yet.'));
        }

        return ListView.builder(
          itemCount: _favoriteController.favoriteShows.length,
          itemBuilder: (context, index) {
            final show = _favoriteController.favoriteShows[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: show.imageUrl != null
                        ? Image.network(show.imageUrl!, width: 60, height: 60, fit: BoxFit.cover)
                        : Container(
                            width: 60,
                            height: 60,
                            color: Colors.pink.withOpacity(0.05),
                            child: const Icon(Icons.tv, size: 30, color: Colors.black26),
                          ),
                  ),
                  title: Text(show.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Rating: ${show.rating ?? "N/A"}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.pink),
                    onPressed: () {
                      _favoriteController.removeFavorite(show.id);
                    },
                  ),
                  onTap: () {
                    Get.toNamed(Routes.DETAIL, arguments: show.id);
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
