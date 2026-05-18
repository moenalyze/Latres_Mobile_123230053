import 'package:get/get.dart';
import '../models/tv_show.dart';
import '../services/tv_service.dart';
import 'favorite_controller.dart';

class DetailController extends GetxController {
  final TvService _tvService = TvService();
  final FavoriteController favoriteController = Get.put(FavoriteController());
  
  var showDetails = Rxn<TvShow>();
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    final int showId = Get.arguments;
    fetchShowDetails(showId);
  }

  void fetchShowDetails(int id) async {
    try {
      isLoading(true);
      var fetchedShow = await _tvService.fetchShowDetails(id);
      showDetails.value = fetchedShow;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch show details');
    } finally {
      isLoading(false);
    }
  }

  bool get isFavorite {
    if (showDetails.value == null) return false;
    return favoriteController.isFavorite(showDetails.value!.id);
  }

  void toggleFavorite() {
    if (showDetails.value != null) {
      favoriteController.toggleFavorite(showDetails.value!);
      update();
    }
  }
}
