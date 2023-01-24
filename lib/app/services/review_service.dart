import 'package:mohamoon_mohamoon/app/models/doctor_model.dart';
import 'package:mohamoon_mohamoon/app/models/review_dart.dart';

class ReviewService {
  Future<List<ReviewModel>> getListReview(Doctor doctor, {int? limit}) async {
    // QueryBuilder<ReviewModel> query = QueryBuilder<ReviewModel>(ReviewModel());
    // //   ..whereEqualTo('doctor', doctor.toPointer());
    // if (limit != null) query.setLimit(limit);
    // ParseResponse apiResponse = await query.query();
    // if (apiResponse.success) {
    //   if (apiResponse.results == null) return [];
    //   var list = apiResponse.results!.cast<ReviewModel>();
    //   return list;
    // } else {
    //   return Future.error(apiResponse.error!.message);
    // }
    return [];
  }
}
