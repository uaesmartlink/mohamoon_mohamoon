import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mohamoon_mohamoon/app/models/dashboard_model.dart';
import 'package:mohamoon_mohamoon/app/models/lawyer_model.dart';
import 'package:mohamoon_mohamoon/app/services/lawyer_service.dart';
import 'package:mohamoon_mohamoon/app/services/review_service.dart';
import 'package:mohamoon_mohamoon/app/services/timeslot_service.dart';
import 'package:mohamoon_mohamoon/app/services/user_service.dart';
import 'package:mohamoon_mohamoon/app/utils/constants.dart';
import 'package:synchronized/synchronized.dart';
import '../../dashboard/controllers/dashboard_controller.dart';

class HomeController extends GetxController with StateMixin<DashboardModel> {
  //TODO: Implement HomeController

  final count = 0.obs;
  final username = ''.obs;
  final profilePic = ''.obs;
  DashboardModel dashboardModel = DashboardModel();
  var lock = Lock();

  @override
  void onReady() async {
    super.onReady();
    var lawyer = await LawyerService().getLawyer();

    if (lawyer == null) {
      if (await UserService().checkIfUserExist() == false) {
        return Get.offNamed('/login');
      } else {
        return Get.offNamed('/add-lawyer-detail');
      }
    }
    username.value = UserService().currentUser!.displayName!;
    UserService().getPhotoUrl().then((urlPicture) => profilePic.value = urlPicture);

    await getListAppointment();
    //await getListReview(lawyer);
    getBalance();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  //Check whether, user is already set his detail lawyer
  bool checkDetailLawyer() {
    bool? check = GetStorage().read(checkLawyerDetail);
    if (check == null || !check) return false;
    return true;
  }
  void toProfile() {
    Get.find<DashboardController>().selectedIndex = 3;
  }

  getListAppointment() async {
    try {
      dashboardModel.listAppointment =
          await TimeSlotService().getOrderedTimeSlot(limit: 5);
    } catch (err) {
      print(err);
      print('--------------');
      printError(info: err.toString());
    }
  }

  getListReview(Lawyer lawyer) async {
    try {
      dashboardModel.listReview = await ReviewService().getListReview(lawyer);
    } catch (err) {
      printError(info: err.toString());
    }
  }

  getBalance() {
    dashboardModel.balance = LawyerService.lawyer!.lawyerBalance;
    change(dashboardModel, status: RxStatus.success());
  }
}
