import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mohamoon_mohamoon/app/services/auth_service.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ForgotPasswordController extends GetxController {
  final RoundedLoadingButtonController roundedBtnController =
      RoundedLoadingButtonController();

  void resetPassword(String email) {
    AuthService().resetPassword(email).then((value) {
      Fluttertoast.showToast(
          msg: 'Please check your email for reset your password'.tr,
          toastLength: Toast.LENGTH_LONG);
      roundedBtnController.success();
    });
  }
}
