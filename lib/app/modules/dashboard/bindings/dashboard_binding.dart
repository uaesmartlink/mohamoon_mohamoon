import 'package:get/get.dart';
import 'package:mohamoon_mohamoon/app/modules/appointment/controllers/appointment_controller.dart';
//import 'package:mohamoon_mohamoon/app/modules/chat/controllers/chat_controller.dart';
import 'package:mohamoon_mohamoon/app/modules/home/controllers/home_controller.dart';
import 'package:mohamoon_mohamoon/app/modules/order/controllers/order_controller.dart';
import 'package:mohamoon_mohamoon/app/modules/profile/controllers/profile_controller.dart';

import '../../../services/notification_service.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<NotificationService>(
      () => NotificationService(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<AppointmentController>(
      () => AppointmentController(),
    );
    Get.lazyPut<OrderController>(
      () => OrderController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
