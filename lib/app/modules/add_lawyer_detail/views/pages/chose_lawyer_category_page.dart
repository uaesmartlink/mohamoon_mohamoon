import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mohamoon_mohamoon/app/modules/add_lawyer_detail/controllers/add_lawyer_detail_controller.dart';
import 'package:mohamoon_mohamoon/app/utils/search/search_lawyer_category.dart';

class ChoseLawyerCategoryPage extends GetView<AddLawyerDetailController> {
  @override
  Widget build(BuildContext context) {
    controller.initLawyerCategory();
    return Scaffold(
      appBar: AppBar(
        title: Text('Lawyer Category'.tr),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          controller.obx(
            (lawyerCategory) => IconButton(
              onPressed: () async {
                controller.lawyerCategory = await showSearch(
                  context: context,
                  delegate: SearchLawyerCategory(
                      lawyerCategory: lawyerCategory!,
                      lawyerCategorySugestion: lawyerCategory),
                );
                Get.back();
              },
              icon: Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: controller.obx(
        (lawyerCategory) => Container(
          child: ListView.builder(
            itemCount: lawyerCategory!.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(lawyerCategory[index].categoryName!),
                onTap: () {
                  controller.lawyerCategory = lawyerCategory[index];
                  Get.back();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
