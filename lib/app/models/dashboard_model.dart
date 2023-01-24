import 'package:mohamoon_mohamoon/app/models/review_dart.dart';
import 'package:mohamoon_mohamoon/app/models/timeslot_model.dart';

class DashboardModel {
  DashboardModel({this.balance, this.listReview, this.listAppointment});

  double? balance;
  List<TimeSlot>? listAppointment;
  List<ReviewModel>? listReview;
}
