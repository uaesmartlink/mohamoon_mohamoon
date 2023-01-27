import 'package:flutter/material.dart';
import 'package:mohamoon_mohamoon/app/models/lawyer_category.dart';

class SearchLawyerCategory extends SearchDelegate<LawyerCategory> {
  late List<LawyerCategory> lawyerCategory;
  late List<LawyerCategory> lawyerCategorySugestion;
  SearchLawyerCategory({
    required this.lawyerCategory,
    required this.lawyerCategorySugestion,
  });

  //Action button, right button
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  //Back Button
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        //close(context, query);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    var allLawyerCategory = lawyerCategory
        .where(
          (category) => category.categoryName!.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    return ListView.builder(
      itemCount: allLawyerCategory.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(allLawyerCategory[index].categoryName!),
        onTap: () {
          close(context, allLawyerCategory[index]);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var allLawyerCategorySuggestion = lawyerCategorySugestion
        .where(
          (categorySuggestion) =>
              categorySuggestion.categoryName!.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
        )
        .toList();

    return ListView.builder(
      itemCount: allLawyerCategorySuggestion.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(allLawyerCategorySuggestion[index].categoryName!),
        onTap: () {
          close(context, allLawyerCategorySuggestion[index]);
        },
      ),
    );
  }
}
