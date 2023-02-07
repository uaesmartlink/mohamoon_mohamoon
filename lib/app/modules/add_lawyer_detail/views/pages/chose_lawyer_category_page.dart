import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mohamoon_mohamoon/app/modules/add_lawyer_detail/controllers/add_lawyer_detail_controller.dart';
import 'package:mohamoon_mohamoon/app/styles/styles.dart';
import 'package:mohamoon_mohamoon/app/modules/login/views/widgets/submit_button.dart';

class ChoseLawyerCategoryPage extends GetView<AddLawyerDetailController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 600,
          child: ControlState(controller: controller),
        ),
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            width: Get.width / 1.3,
            padding: EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Styles.thirdlyColor,
              borderRadius: BorderRadius.all(
                Radius.circular(17),
              ),
            ),
            child: Text(
              'Save'.tr,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ],
    );
    controller.initLawyerCategory();
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
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 15,
        ),
        child: controller.obx(
          (categories) => Container(
            child: ListView.builder(
              itemCount: categories!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor:
                      controller.selected[index] ? Styles.mGreyColor : null,
                  title: Text(categories[index].categoryName!),
                  onTap: () {
                    print(categories[index].categoryName!);
                    print(controller.selected[index]);
                    if (!controller.selected[index]) {
                      controller.categories!
                          .add(categories[index].categoryName!);
                    } else {
                      controller.categories!
                          .remove(categories[index].categoryName!);
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
