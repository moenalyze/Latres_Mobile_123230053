import 'package:get/get.dart';
import '../models/tv_show.dart';
import '../services/tv_service.dart';

class HomeController extends GetxController {
  final TvService _tvService = TvService();
  
  var shows = <TvShow>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchShows();
  }

  void fetchShows() async {
    try {
      isLoading(true);
      var fetchedShows = await _tvService.fetchShows();
      shows.assignAll(fetchedShows);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch TV shows');
    } finally {
      isLoading(false);
    }
  }
}
