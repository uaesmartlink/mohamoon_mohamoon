import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mohamoon_mohamoon/app/models/lawyer_model.dart';
import 'package:mohamoon_mohamoon/app/services/user_service.dart';

class LawyerService {
  static Lawyer? lawyer;

  set currentLawyer(Lawyer? lawyer) => LawyerService.lawyer = lawyer;

  Future saveLawyerDetail(
      {required String lawyerName,
      required String lawyerPhone,
      required String hospital,
      required String shortBiography,
      required String pictureUrl,
      required String certificateUrl,
      required List<String> categories,
      bool isUpdate = false}) async {
    try {
      List cat = [];
      for (int i = 0; i < categories.length; i++) {
        cat.add({
          "name": categories[i],
        });
      }
      CollectionReference lawyers =
          FirebaseFirestore.instance.collection('Lawyers');
      Map<String, dynamic> lawyersData = {
        'lawyerName': lawyerName,
        'lawyerPhone': lawyerPhone,
        'lawyerHospital': hospital,
        'lawyerBiography': shortBiography,
        'lawyerPicture': pictureUrl,
        'certificateUrl': certificateUrl,
        'categories': FieldValue.arrayUnion(categories),
        'lawyerBasePrice': 10,
        'accountStatus': 'nonactive',
        'isOnline': false,
      };

      if (isUpdate) {
        lawyersData['updatedAt'] = FieldValue.serverTimestamp();
        await lawyers.doc(LawyerService.lawyer!.lawyerId).update(lawyersData);
        await getLawyer(forceGet: true);
      } else {
        lawyersData['createdAt'] = FieldValue.serverTimestamp();
        lawyersData['updatedAt'] = FieldValue.serverTimestamp();
        var lawyer = await lawyers.add(lawyersData);
        UserService().setLawyerId(lawyer.id);
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  ///get lawyer, if current lawyer is null will get from server
  ///[forceGet] if true will force get from server even if current lawyer is not null
  Future<Lawyer?> getLawyer({bool forceGet = false}) async {
    try {
      if (LawyerService.lawyer != null && forceGet == false) {
        return LawyerService.lawyer;
      }
      var lawyerId = await UserService().getLawyerId();
      var lawyerReference = await FirebaseFirestore.instance
          .collection('Lawyers')
          .doc(lawyerId)
          .get();
      if (!lawyerReference.exists) return null;
      var data = lawyerReference.data() as Map<String, dynamic>;
      data['lawyerId'] = lawyerId;
      Lawyer lawyer = Lawyer.fromJson(data);
      LawyerService.lawyer = lawyer;

      LawyerService().currentLawyer = lawyer;
      return lawyer;
    } catch (e) {
      return null;
    }
  }

  Future updateLawyerBasePrice(int basePrice) async {
    try {
      await FirebaseFirestore.instance
          .collection('Lawyers')
          .doc(lawyer!.lawyerId)
          .update({'lawyerBasePrice': basePrice});
      lawyer!.lawyerPrice = basePrice;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future updateLawyerStatus(bool isOnline) async {
    try {
      print(isOnline);
      await FirebaseFirestore.instance
          .collection('Lawyers')
          .doc(lawyer!.lawyerId)
          .update({'isOnline': isOnline});
      lawyer!.isOnline = isOnline;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
