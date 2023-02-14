import 'package:get/get.dart';

import '../controllers/add_lawyer_detail_controller.dart';

class AddLawyerDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddLawyerDetailController>(
      () => AddLawyerDetailController(),
    );

  }
}
