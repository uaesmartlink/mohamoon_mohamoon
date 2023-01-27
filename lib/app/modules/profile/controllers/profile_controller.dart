import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mohamoon_mohamoon/app/services/auth_service.dart';
import 'package:mohamoon_mohamoon/app/services/chat_service.dart';
import 'package:mohamoon_mohamoon/app/services/lawyer_service.dart';
import 'package:mohamoon_mohamoon/app/services/notification_service.dart';
import 'package:mohamoon_mohamoon/app/services/user_service.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../models/lawyer_model.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  var user = UserService().currentUser;
  bool tap = false;
  var photoUrl = ''.obs;
  var displayName = ''.obs;
  String accountStatus = '';
  bool isAccountActivated = false;
  @override
  void onReady() async {
    super.onReady();
    photoUrl.value = await UserService().getPhotoUrl();
    Lawyer? doc = await LawyerService().getLawyer();
    accountStatus = doc!.accountStatus!;
    if (accountStatus == 'active') {
      isAccountActivated = true;
    }
    update();
  }

  @override
  void onClose() {}

  void toEditProfile() {
    Get.toNamed('/edit-profile');
  }

  void toBalance() {
    Get.toNamed('/balance');
  }

  void toEditLawyerDetail() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    var lawyer = LawyerService.lawyer;
    EasyLoading.dismiss();
    Get.toNamed('/add-lawyer-detail', arguments: lawyer);
  }

  void logout() async {
    Get.defaultDialog(
      title: 'Logout'.tr,
      middleText: 'Are you sure you want to Logout'.tr,
      radius: 15,
      textCancel: 'Cancel'.tr,
      textConfirm: 'Logout'.tr,
      onConfirm: () {
        AuthService().logout();
        Get.offAllNamed('/login');
      },
    );
  }

  void test() async {
    // //await ChatService().getListChat();
    // NotificationService().testNotification();
  }
}
