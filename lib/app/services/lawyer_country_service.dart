import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mohamoon_mohamoon/app/models/lawyer_country.dart';

class LawyerCountryService {
  FirebaseFirestore? _instance;

  final List<String> _lawyerCountry = [];

  List<String> get getCountries => _lawyerCountry;

  Future<List<String>> getListLawyerCountry() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference lawyerCountry =
        _instance!.collection('Country');

    QuerySnapshot snapshot = await lawyerCountry.get();
    final allData = snapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      data['countryId'] = doc.reference.id;
      print(data['countryName']);
      return data;
    });

    for (var country in allData) {
      LawyerCountry doc = LawyerCountry.fromJson(country);
      if (doc.countryName != "All Lawyers") _lawyerCountry.add(doc.countryName!);
    }

    return _lawyerCountry;
  }
}