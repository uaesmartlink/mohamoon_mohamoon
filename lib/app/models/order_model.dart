import 'package:mohamoon_mohamoon/app/models/timeslot_model.dart';
import 'package:mohamoon_mohamoon/app/models/user_model.dart';

class Order {
  TimeSlot timeSlot;
  UserModel orderByWho;
  Order({required this.timeSlot, required this.orderByWho});
}
