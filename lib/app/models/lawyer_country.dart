class LawyerCountry {
  String? countryId;
  String? countryName;
  String? countryTranslation;
  String? iconUrl;
  LawyerCountry(
      {required this.countryId, this.countryName,this.countryTranslation , required this.iconUrl});
  static const String _countryId = 'categoryId';
  static const String _countryName = 'categoryName';
  static const String _countryTranslation = 'countryTranslation';
  static const String _iconUrl = 'iconUrl';

  factory LawyerCountry.fromJson(Map<String, dynamic> data) {
    return LawyerCountry(
      countryId: data[_countryId],
      countryName: data[_countryName],
      countryTranslation: data[_countryTranslation],
      iconUrl: data[_iconUrl],
    );
  }
}
