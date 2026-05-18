import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../views/login_page.dart';
import '../views/main_page.dart';
import '../views/detail_page.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
    ),
    GetPage(
      name: Routes.MAIN,
      page: () => MainPage(),
    ),
    GetPage(
      name: Routes.DETAIL,
      page: () => DetailPage(),
    ),
  ];
}
