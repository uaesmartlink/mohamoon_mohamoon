class LawyerCategory {
  String? categoryId;
  String? categoryName;
  String? categoryTranslation;
  String? iconUrl;
  LawyerCategory(
      {required this.categoryId, this.categoryName,this.categoryTranslation , required this.iconUrl});
  static const String _categoryId = 'categoryId';
  static const String _categoryName = 'categoryName';
  static const String _categoryTranslation = 'categoryTranslation';
  static const String _iconUrl = 'iconUrl';
  
  factory LawyerCategory.fromJson(Map<String, dynamic> data) {
    return LawyerCategory(
      categoryId: data[_categoryId],
      categoryName: data[_categoryName],
      categoryTranslation: data[_categoryTranslation],
      iconUrl: data[_iconUrl],
    );
  }
}
