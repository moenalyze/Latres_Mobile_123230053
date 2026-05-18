import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_controller.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DetailController controller = Get.put(DetailController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Detail'),
        actions: [
          Obx(() {
            if (controller.isLoading.value || controller.showDetails.value == null) {
              return const SizedBox.shrink();
            }

            bool isFav = controller.favoriteController.favoriteShows.any((element) => element.id == controller.showDetails.value!.id);
            return IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.red : null,
              ),
              onPressed: controller.toggleFavorite,
            );
          }),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final show = controller.showDetails.value;
        if (show == null) {
          return const Center(child: Text('Failed to load show details'));
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (show.imageUrl != null)
                Image.network(
                  show.imageUrl!,
                  height: 300,
                  fit: BoxFit.cover,
                )
              else
                Container(
                  height: 300,
                  color: Colors.grey[300],
                  child: const Icon(Icons.tv, size: 100),
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      show.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          show.rating?.toString() ?? 'N/A',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Genres:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(show.genres.isNotEmpty ? show.genres.join(', ') : 'N/A'),
                    const SizedBox(height: 16),
                    const Text(
                      'Summary:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _stripHtmlIfNeeded(show.summary ?? 'No summary available.'),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  String _stripHtmlIfNeeded(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');
  }
}
