import 'dart:collection';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:mohamoon_mohamoon/app/models/timeslot_model.dart';
import 'package:mohamoon_mohamoon/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:mohamoon_mohamoon/app/services/timeslot_service.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppointmentController extends GetxController
    with StateMixin<LinkedHashMap<DateTime, List<TimeSlot>>> {
  //TODO: Implement AppointmentController

  final formKey = GlobalKey<FormBuilderState>();
  var selectedDay = DateTime.now().obs;
  var focusDay = DateTime.now().obs;
  var calendarFormat = CalendarFormat.month;
  List<TimeSlot> timeSlots = [];
  LinkedHashMap<DateTime, List<TimeSlot>> groupedEvents =
      LinkedHashMap<DateTime, List<TimeSlot>>();

  List<TimeSlot> eventSelectedDay = [];

  DashboardController dashboardController = Get.find();

  double? price;
  int? duration = 15;
  bool available = true;

  @override
  void onClose() {}

  initLawyerSchedule() {
    selectedDay = DateTime.now().obs;
    focusDay = DateTime.now().obs;
    calendarFormat = CalendarFormat.month;
    TimeSlotService().getLawyerTimeSlot().then(
      (value) {
        groupedEvents = groupEvent(value);

        change(groupedEvents, status: RxStatus.success());
        update();
        updateEventList(selectedDay.value);
      },
    ).catchError((err) {
      change(groupedEvents, status: RxStatus.success());
    });
  }

  List<TimeSlot> getEventsfromDay(DateTime date) {
    return groupedEvents[date] ?? [];
  }

  groupEvent(List<TimeSlot> events) {
    groupedEvents = LinkedHashMap(equals: isSameDay, hashCode: getHashCode);
    for (var event in events) {
      DateTime date = DateTime(
          event.timeSlot!.year, event.timeSlot!.month, event.timeSlot!.day, 12);
      if (groupedEvents[date] == null) groupedEvents[date] = [];
      groupedEvents[date]!.add(event);
    }
    return groupedEvents;
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 * key.month * 10000 * key.year;
  }

  void updateEventList(DateTime date) {
    eventSelectedDay = getEventsfromDay(date);
    update();
    timeSlots = [];
    groupedEvents.forEach((key, value) {
      if (key.year == selectedDay.value.year &&
          key.month == selectedDay.value.month &&
          key.day == selectedDay.value.day) {
        print(key.day);
        value.forEach((element) {
          timeSlots.add(element);
        });
      }
    });
  }

  void updateEventsCalendar() {
    TimeSlotService().getLawyerTimeSlot().then((value) {
      groupedEvents = groupEvent(value);
      updateEventList(selectedDay.value);
      change(groupedEvents, status: RxStatus.success());
    });
  }

  Future deleteOneTimeSlot(TimeSlot timeslot) async {
    bool? result = await Get.defaultDialog(
        title: 'Delete Linked TimeSlot'.tr,
        middleText:
            'This timeslot is connected to several timeslots that were previously created simultaneously, do you also want to delete all timeslots that are connected to this timeslot'
                .tr,
        radius: 15,
        textCancel: 'Cancel'.tr,
        textConfirm: 'Delete'.tr,
        onConfirm: () {
          Get.back(result: true);
        },
        onCancel: () {
          Get.back(result: false);
        });

    if (result == true) {
      TimeSlotService().deleteTimeSlot(timeslot!).then((value) {
        Fluttertoast.showToast(msg: 'Success delete timeslot'.tr);
        updateEventsCalendar();
        Get.back(closeOverlays: true);
      });
    }
  }
}
