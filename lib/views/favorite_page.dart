import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorite_controller.dart';
import '../routes/app_routes.dart';

class FavoritePage extends StatelessWidget {
  final FavoriteController _favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Shows')),
      body: Obx(() {
        if (_favoriteController.favoriteShows.isEmpty) {
          return const Center(child: Text('No favorite shows yet.'));
        }

        return ListView.builder(
          itemCount: _favoriteController.favoriteShows.length,
          itemBuilder: (context, index) {
            final show = _favoriteController.favoriteShows[index];
            return ListTile(
              leading: show.imageUrl != null
                  ? Image.network(show.imageUrl!, width: 50, fit: BoxFit.cover)
                  : const Icon(Icons.tv, size: 50),
              title: Text(show.name),
              subtitle: Text('Rating: ${show.rating ?? "N/A"}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _favoriteController.removeFavorite(show.id);
                },
              ),
              onTap: () {
                Get.toNamed(Routes.DETAIL, arguments: show.id);
              },
            );
          },
        );
      }),
    );
  }
}
