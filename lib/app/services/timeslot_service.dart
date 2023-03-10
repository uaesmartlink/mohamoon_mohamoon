import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:mohamoon_mohamoon/app/models/timeslot_model.dart';
import 'package:mohamoon_mohamoon/app/services/lawyer_service.dart';
//import 'package:jiffy/jiffy.dart';

class TimeSlotService {
  ///save lawyer timeslot, and return id
  Future<String> saveLawyerTimeslot(
      {required DateTime dateTime,
      required double price,
      required int duration,
      required bool available,
      bool isParentTimeslot = false}) async {
    TimeSlot timeSlot = TimeSlot();
    timeSlot.timeSlot = dateTime;
    timeSlot.price = price;
    timeSlot.duration = duration;
    timeSlot.available = available;
    timeSlot.lawyerid = LawyerService.lawyer!.lawyerId;
    try {
      if (isParentTimeslot) {
        var timeSlotSaved = await FirebaseFirestore.instance
            .collection('LawyerTimeslot')
            .add(TimeSlot().toMap(timeSlot));
        timeSlotSaved.update({"parentTimeslotId": timeSlotSaved.id});
        return timeSlotSaved.id;
      } else {
        var timeSlotSaved = await FirebaseFirestore.instance
            .collection('LawyerTimeslot')
            .add(TimeSlot().toMap(timeSlot));

        return timeSlotSaved.id;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<TimeSlot> getTimeSlotById(String timeslotId) async {
    try {
      var timeslotRef = await FirebaseFirestore.instance
          .collection('LawyerTimeslot')
          .doc(timeslotId)
          .get();

      TimeSlot timeslot = TimeSlot.fromFirestore(timeslotRef);
      print("MMM");
      timeslot.timeSlotId = timeslotId;
      print("MMM");
      return timeslot;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future saveMultipleTimeslot(
      {required DateTime dateTime,
      required double price,
      required int duration,
      required bool available,
      required List<DateTime> repeatTimeslot,
      required parentTimeslotId}) async {
    var batch = FirebaseFirestore.instance.batch();
    TimeSlot timeSlot = TimeSlot();
    timeSlot.timeSlot = dateTime;
    timeSlot.price = price;
    timeSlot.duration = duration;
    timeSlot.available = available;
    timeSlot.lawyerid = LawyerService.lawyer!.lawyerId;
    timeSlot.parentTimeslotId = parentTimeslotId;
    for (var dateTime in repeatTimeslot) {
      var docRef =
          FirebaseFirestore.instance.collection("LawyerTimeslot").doc();
      timeSlot.timeSlot = dateTime;
      var datanya = TimeSlot().toMap(timeSlot);
      print('datanya : ' + datanya['parentTimeslotId']);
      batch.set(docRef, datanya);
    }

    await batch.commit();
  }

  Future updateTimeSlot(TimeSlot timeSlot) async {
    try {
      print('lawyer id : ' + LawyerService.lawyer!.lawyerId!);
      print('timeslot update id : ' + timeSlot.timeSlotId!);
      await FirebaseFirestore.instance
          .collection('LawyerTimeslot')
          .doc(timeSlot.timeSlotId)
          .update(TimeSlot().toMap(timeSlot));
    } catch (e) {
      return Future.error(e);
    }
  }

  ///Update all timeslot with the same parent id, only update available timeslot
  Future updateRepeatedTimeSlot(TimeSlot timeSlot) async {
    try {
      if (timeSlot.parentTimeslotId == null) {
        return Future.error('timeslot parent null');
      }
      var batch = FirebaseFirestore.instance.batch();
      var docRef = await FirebaseFirestore.instance
          .collection("LawyerTimeslot")
          .where('parentTimeslotId', isEqualTo: timeSlot.parentTimeslotId)
          .where('available', isEqualTo: true)
          .get();
      for (var item in docRef.docs) {
        var myTimeSlot = TimeSlot.fromJson(item.data());
        var updatedHourTimeSlot = DateTime(
            myTimeSlot.timeSlot!.year,
            myTimeSlot.timeSlot!.month,
            myTimeSlot.timeSlot!.day,
            timeSlot.timeSlot!.hour,
            timeSlot.timeSlot!.minute,
            timeSlot.timeSlot!.second,
            timeSlot.timeSlot!.millisecond,
            timeSlot.timeSlot!.microsecond);
        timeSlot.timeSlot = updatedHourTimeSlot;
        batch.update(item.reference, TimeSlot().toMap(timeSlot));
      }
      await batch.commit();
      print('success edit timeslot');
    } catch (e) {
      return Future.error(e);
    }
  }

  ///delete one timeslot, use deleteRepeatedTimeslot to delete multiple timeslot
  Future deleteTimeSlot(TimeSlot timeSlot) async {
    try {
      await FirebaseFirestore.instance
          .collection('LawyerTimeslot')
          .doc(timeSlot.timeSlotId)
          .delete();
      print('success delete timeslot');
    } catch (e) {
      return Future.error(e);
    }
  }

  ///Delete all timeslot with the same parent id, only delte available timeslot
  Future deleteRepeatedTimeSlot(TimeSlot timeSlot) async {
    try {
      var batch = FirebaseFirestore.instance.batch();
      var docRef = await FirebaseFirestore.instance
          .collection("LawyerTimeslot")
          .where('parentTimeslotId', isEqualTo: timeSlot.parentTimeslotId)
          .where('available', isEqualTo: true)
          .get();
      for (var item in docRef.docs) {
        batch.delete(item.reference);
      }
      await batch.commit();
      print('success delete timeslot');
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<TimeSlot>> getLawyerTimeSlot() async {
    try {
      var lawyer = await LawyerService().getLawyer();
      var documentRef = await FirebaseFirestore.instance
          .collection('LawyerTimeslot')
          .where('lawyerId', isEqualTo: lawyer!.lawyerId)
          .where('timeSlot', isGreaterThanOrEqualTo: DateTime.now())
          .orderBy("timeSlot")
          .get();
      if (documentRef.docs.isEmpty) return [];
      int cnt = 0;
      List<TimeSlot> listTimeslot = documentRef.docs.map((doc) {
        var data = doc.data();
        data['timeSlotId'] = doc.reference.id;
        TimeSlot timeSlot = TimeSlot.fromJson(data);
        print(timeSlot.timeSlot.toString());
        return timeSlot;
      }).toList();
      return listTimeslot;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //get all timeslot that user, succesfully purchase
  Future<List<TimeSlot>> getOrderedTimeSlot({int? limit}) async {
    try {
      var lawyer = await LawyerService().getLawyer();
      var documentRef = FirebaseFirestore.instance
          .collection('LawyerTimeslot')
          .where('lawyerId', isEqualTo: lawyer!.lawyerId)
          .where('charged', isEqualTo: true);
      var documentSnapshot = limit == null
          ? await documentRef.get()
          : await documentRef.limit(limit).get();
      if (documentSnapshot.docs.isEmpty) {
        return [];
      }

      List<TimeSlot> listTimeslot = documentSnapshot.docs.map((doc) {
        var data = doc.data();
        data['timeSlotId'] = doc.reference.id;
        print(data);
        TimeSlot timeSlot = TimeSlot.fromJson(data);
        return timeSlot;
      }).toList();

      return listTimeslot;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future setTimeslotFinish(TimeSlot timeSlot) async {
    try {
      var timeSlotRef = await FirebaseFirestore.instance
          .collection('LawyerTimeslot')
          .doc(timeSlot.timeSlotId)
          .get();
      await timeSlotRef.reference.update({'status': 'complete'});
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future cancelAppointment(TimeSlot timeSlot) async {
    try {
      var callable = FirebaseFunctions.instance.httpsCallable('refundTimeslot');
      await callable({'timeSlotId': timeSlot.timeSlotId});
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
