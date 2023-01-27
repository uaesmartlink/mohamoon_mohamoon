import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mohamoon_mohamoon/app/modules/add_lawyer_detail/controllers/add_lawyer_detail_controller.dart';
import 'package:mohamoon_mohamoon/app/styles/styles.dart';
import 'package:mohamoon_mohamoon/app/utils/search/search_lawyer_category.dart';

class ChoseLawyerCategoryPage extends GetView<AddLawyerDetailController> {
  @override
  Widget build(BuildContext context) {
    controller.initLawyerCategory();
    return  ControlState(controller: controller);
  }
}

class ControlState extends StatefulWidget {
  AddLawyerDetailController controller;

  ControlState({Key? key, required this.controller}) : super(key: key);

  @override
  State<ControlState> createState() => _ControlState(controller);
}

class _ControlState extends State<ControlState> {
  AddLawyerDetailController controller;

  _ControlState(this.controller);

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 15,
        ),
        child: controller.obx(
          (lawyerCategory) => Container(
            child: ListView.builder(
              itemCount: lawyerCategory!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: controller.selected[index] ? Styles.mGreyColor : null,
                  title: Text(lawyerCategory[index].categoryName!),

                  onTap: () {
                    print(lawyerCategory[index].categoryName!);
                    print(controller.selected[index]);
                    if (!controller.selected[index]) {
                      controller.categories!
                          .add(lawyerCategory[index].categoryName!);
                    } else {
                      controller.categories!
                          .remove(lawyerCategory[index].categoryName!);
                    }
                    setState(() {
                      controller.selected[index] = !controller.selected[index];
                    });
                    print(controller.categories.toString());
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
