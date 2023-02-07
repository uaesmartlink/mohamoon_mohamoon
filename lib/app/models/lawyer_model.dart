import 'dart:core';

class Lawyer {
  Lawyer({
    required this.lawyerId,
    required this.lawyerName,
    required this.lawyerPhone,
    required this.lawyerPicture,
    required this.certificateUrl,
    required this.lawyerPrice,
    required this.lawyerShortBiography,
    required this.categories,
    required this.lawyerHospital,
    required this.lawyerBalance,
    required this.accountStatus,
    required this.isOnline,
  });
  static const String _lawyerId = 'lawyerId';
  static const String _lawyerName = 'lawyerName';
  static const String _lawyerPhone = 'lawyerPhone';
  static const String _lawyerPicture = 'lawyerPicture';
  static const String _certificateUrl = 'certificateUrl';
  static const String _lawyerPrice = 'lawyerBasePrice';
  static const String _lawyerShortBiography = 'lawyerBiography';
  static const String _lawyerCategory = 'lawyerCategory';
  static const String _lawyerHospital = 'lawyerHospital';
  static const String _lawyerBalance = 'balance';
  static const String _accountStatus = 'accountStatus';
  static const String _isOnline = 'isOnline';
  String? lawyerId;
  String? lawyerName;
  String? lawyerPhone;
  String? lawyerPicture;
  String? certificateUrl;
  int? lawyerPrice;
  String? lawyerShortBiography;
  List<String>? categories;
  String? lawyerHospital;
  double? lawyerBalance;
  String? accountStatus;
  bool? isOnline;

  factory Lawyer.fromJson(Map<String, dynamic> data) {
    return Lawyer(
        lawyerId: data[_lawyerId],
        lawyerName: data[_lawyerName],
        lawyerPhone: data[_lawyerPhone],
        lawyerPicture: data[_lawyerPicture],
        certificateUrl: data[_certificateUrl],
        lawyerPrice: data[_lawyerPrice],
        lawyerShortBiography: data[_lawyerShortBiography],
        categories: data[_lawyerCategory],
        lawyerHospital: data[_lawyerHospital],
        lawyerBalance: double.parse(((data[_lawyerBalance])??0.0).toString()),
        accountStatus: data[_accountStatus],
        isOnline: data[_isOnline],
    );
  }
}
