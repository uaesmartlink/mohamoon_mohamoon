import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mohamoon_mohamoon/app/models/lawyer_category.dart';

class LawyerCategoryService {
  FirebaseFirestore? _instance;

  final List<LawyerCategory> _lawyerCategory = [];

  List<LawyerCategory> get getCategories => _lawyerCategory;

  Future<List<LawyerCategory>> getListLawyerCategory() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference lawyerCategory =
        _instance!.collection('LawyerCategory');

    QuerySnapshot snapshot = await lawyerCategory.get();
    final allData = snapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      data['categoryId'] = doc.reference.id;
      return data;
    });

    for (var category in allData) {
      LawyerCategory doc = LawyerCategory.fromJson(category);
      if (doc.categoryName != "All Lawyers") _lawyerCategory.add(doc);
    }

    return _lawyerCategory;
  }
}