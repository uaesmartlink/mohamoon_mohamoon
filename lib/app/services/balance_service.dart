import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mohamoon_mohamoon/app/models/lawyer_model.dart';
import 'package:mohamoon_mohamoon/app/services/lawyer_service.dart';

class BalanceService {
  Future<double> getBalance() async {
    try {
      var userSnapshot = await FirebaseFirestore.instance
          .collection('Lawyers')
          .doc(LawyerService.lawyer!.lawyerId)
          .get();
      Lawyer lawyer = Lawyer.fromJson(userSnapshot.data() as Map<String, dynamic>);
      return lawyer.lawyerBalance!;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future createBalance(User user, Lawyer lawyer) async {
    try {
      CollectionReference balances =
          FirebaseFirestore.instance.collection('Balance');

      Map<String, dynamic> balance = {
        'user': user.uid,
        'lawyerId': lawyer.lawyerId
      };
      balances.add(balance);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
