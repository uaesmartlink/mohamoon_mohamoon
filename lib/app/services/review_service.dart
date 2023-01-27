import 'package:mohamoon_mohamoon/app/models/lawyer_model.dart';
import 'package:mohamoon_mohamoon/app/models/review_dart.dart';

class ReviewService {
  Future<List<ReviewModel>> getListReview(Lawyer lawyer, {int? limit}) async {
    // QueryBuilder<ReviewModel> query = QueryBuilder<ReviewModel>(ReviewModel());
    // //   ..whereEqualTo('lawyer', lawyer.toPointer());
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
