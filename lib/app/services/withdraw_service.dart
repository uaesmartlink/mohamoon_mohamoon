import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mohamoon_mohamoon/app/models/withdraw_method_model.dart';
import 'package:mohamoon_mohamoon/app/models/withdraw_settings_detail.dart';
import 'package:mohamoon_mohamoon/app/services/auth_service.dart';
import 'package:mohamoon_mohamoon/app/services/user_service.dart';

class WithdrawService {
  Future<void> addPaypalMethod(String name, String email) async {
    try {
      FirebaseFirestore.instance.collection('WitdrawMethod').add({
        'name': name,
        'email': email,
        'method': 'paypal',
        'userId': UserService.user!.uid
      });
    } on FirebaseException catch (e) {
      return Future.error(e.message!);
    }
  }

  Future<List<WithdrawMethod>> getWithdrawMethod() async {
    try {
      var withdrawMethodRef = await FirebaseFirestore.instance
          .collection('WitdrawMethod')
          .where(
            'userId',
            isEqualTo: UserService().currentUser!.uid,
          )
          .get();
      List<WithdrawMethod> listWithdrawMethod =
          withdrawMethodRef.docs.map((doc) {
        var data = doc.data();
        data['withdrawMethodId'] = doc.reference.id;
        WithdrawMethod withdrawMethod = WithdrawMethod.fromJson(data);
        return withdrawMethod;
      }).toList();
      if (listWithdrawMethod.isEmpty) return [];
      return listWithdrawMethod;
    } on FirebaseException catch (e) {
      return Future.error(e.message!);
    }
  }

  Future requestWithdraw(
      String password, WithdrawMethod withdrawMethod, int amount) async {
    try {
      bool verifyPassword = await AuthService().verifyPassword(password);
      if (verifyPassword) {
        FirebaseFirestore.instance.collection('WithdrawRequest').add({
          'amount': amount,
          'withdrawMethod': WithdrawMethod().toMap(withdrawMethod),
          'userId': UserService.user!.uid
        });
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<WithdrawSettingsDetail> getWithdrawSettings() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('Settings')
          .doc('withdrawSetting')
          .get();
      WithdrawSettingsDetail withdrawSettingsDetail =
          WithdrawSettingsDetail.fromFirestore(snapshot);
      return withdrawSettingsDetail;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
