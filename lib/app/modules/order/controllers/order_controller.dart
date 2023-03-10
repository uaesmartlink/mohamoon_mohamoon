import 'package:get/get.dart';
import 'package:mohamoon_mohamoon/app/models/timeslot_model.dart';
import 'package:mohamoon_mohamoon/app/services/timeslot_service.dart';

class OrderController extends GetxController with StateMixin<List<TimeSlot>> {
  final count = 0.obs;
  final isTabOpen = false;

  @override
  void onClose() {}
  void increment() => count.value++;

  void initOrderedTimeSlot() {
    change([], status: RxStatus.loading());
    TimeSlotService().getOrderedTimeSlot().then((value) {
      if (value.isEmpty) {
        change(value, status: RxStatus.empty());
        return;
      }
      change(value, status: RxStatus.success());
      print(value);
      print('------------');
    }).catchError((err) {
      change([], status: RxStatus.error());
    });
  }
}
