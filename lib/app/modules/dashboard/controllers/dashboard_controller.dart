import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mohamoon_mohamoon/app/modules/appointment/controllers/appointment_controller.dart';
import 'package:mohamoon_mohamoon/app/modules/order/controllers/order_controller.dart';

import '../../../services/notification_service.dart';
import '../../../services/user_service.dart';

class DashboardController extends GetxController {
  //TODO: Implement DashboardController

  final _selectedIndex = 0.obs;
  get selectedIndex => _selectedIndex.value;
  set selectedIndex(index) => _selectedIndex.value = index;
  NotificationService notificationService = Get.find<NotificationService>();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    EasyLoading.show();
    notificationService.listenNotification();
    await UserService()
        .updateUserToken(await notificationService.getNotificationToken());
    EasyLoading.dismiss();
  }

  @override
  void onClose() {}

  void initTabAppointment() {
    // interval(count1, (_) => Network
    // print("interval $_"), time: Duration(seconds: 1));
    Get.find<AppointmentController>().initLawyerSchedule();
    //print('init appointment');
  }

  void initTabOrder() {
    Get.find<OrderController>().initOrderedTimeSlot();
  }
}
