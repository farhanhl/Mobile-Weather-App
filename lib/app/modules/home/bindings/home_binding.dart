import 'package:get/get.dart';

import '../../../core/api.dart';
import '../controllers/home_controller.dart';
import '../services/home_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        HomeService(
          Get.find<Api>(),
        ),
      ),
    );
  }
}
