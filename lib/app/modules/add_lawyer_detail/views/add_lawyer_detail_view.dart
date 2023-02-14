import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mohamoon_mohamoon/app/modules/add_lawyer_detail/views/pages/chose_lawyer_category_page.dart';
import 'package:mohamoon_mohamoon/app/modules/lawyer_country/views/lawyer_country_view.dart';
import 'package:mohamoon_mohamoon/app/modules/add_lawyer_detail/views/widgets/display_image.dart';
import 'package:mohamoon_mohamoon/app/modules/login/views/widgets/submit_button.dart';
import 'package:mohamoon_mohamoon/app/services/lawyer_country_service.dart';
import 'package:mohamoon_mohamoon/app/services/lawyer_service.dart';
import 'package:mohamoon_mohamoon/app/styles/styles.dart';
import '../controllers/add_lawyer_detail_controller.dart';
import 'package:mohamoon_mohamoon/app/services/user_service.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AddLawyerDetailView extends GetView<AddLawyerDetailController> {
  static const List<String> langage = ['English', 'Arabic', 'English & Arabic'];

  var dropDownLangage = langage.map((e) {
    return DropdownMenuItem(
      value: e,
      child: Text(e),
    );
  }).toList();

  static const List<String> countries = [
    'UAE',
    'Syria',
    'Lebanon',
    'Egypt',
    'Bahrain',
    'Jordan',
    'Turkey',
    'Saudi Arabia',
    'Kuwait',
    'Qatar',
    'Iraq',
  ];
  var dropDownCountries = countries.map((e) {
    return DropdownMenuItem(
      value: e,
      child: Text(e),
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    LawyerCountryService().getListLawyerCountry();
    final node = FocusScope.of(context);
    var username = UserService().currentUser!.displayName;
    controller.lawyerName.value = username!;
    return Scaffold(
      body: Container(
        height: 800,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: <Color>[
              Styles.primaryColor,
              Styles.secondaryColor,
            ],
            // Gradient from https://learnui.design/tools/gradient-generator.html
            tileMode: TileMode.mirror,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(30, 51, 30, 20),
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: controller.formkey,
            child: GetX<AddLawyerDetailController>(
              builder: (controller) => Column(
                children: [
                  DisplayImage(
                      imagePath: controller.profilePicUrl.value,
                      onPressed: () {
                        controller.toEditProfilePic();
                      }),
                  SizedBox(height: 20),
                  /*TextFormField(
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    node.nextFocus();
                  },
                  validator: ((value) {
                    if (value!.length < 7) {
                      return 'phone must be valid'.tr;
                    } else {
                      return null;
                    }
                  }),
                  initialValue: controller.lawyer == null
                      ? ''
                      : controller.lawyerPhone.value,
                  onSaved: (phone) {
                    controller.lawyerPhone.value = phone!;
                  },
                  decoration: InputDecoration(
                      hintText: controller.lawyer == null ? 'phone'.tr : '',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),*/
                  IntlPhoneField(
                    decoration: InputDecoration(
                        // labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true),
                    initialValue: controller.lawyer == null
                        ? ''
                        : controller.lawyerPhone.value,
                    initialCountryCode: "AE",
                    onSaved: (phone) {
                      controller.lawyerPhone.value =
                          phone == null ? '' : phone.number;
                    },
                  ),
                  SizedBox(height: 20),
                  FormBuilderDropdown(
                    initialValue: controller.lawyerHospital,
                    name: 'lawyerHospital',
                    items: dropDownLangage,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true),
                    onChanged: (langage) {
                      controller.lawyerHospital = langage.toString();
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    maxLines: null,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      node.nextFocus();
                    },
                    onSaved: (shortBiography) {
                      controller.shortBiography.value = shortBiography!;
                    },
                    initialValue: controller.lawyer == null
                        ? null
                        : controller.shortBiography.value,
                    decoration: InputDecoration(
                      hintText: 'Short Biography',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                  if (!controller.isEdit) SizedBox(height: 10),
                  if (!controller.isEdit)
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Styles.thirdlyColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Color(0xFFF5F6F9),
                      ),
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf'],
                        );
                        if (result != null) {
                          File? file = File(result.files.single.path!);
                          controller.uploadCertificate(file);
                          controller.certificateUrl.value =
                              result.files.single.name;
                        } else {
                          return;
                        }
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              controller.certificateUrl.value == ''
                                  ? 'Add certificate'
                                  : 'Added successfully, to edit the certificate click again',
                            ),
                          ),
                          Icon(Icons.upload),
                        ],
                      ),
                    ),
                  if (!controller.isEdit) SizedBox(height: 10),
                  if (!controller.isEdit)
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Styles.thirdlyColor,
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Color(0xFFF5F6F9),
                      ),
                      onPressed: () {
                        Get.to(() => ChoseLawyerCategoryPage());
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(controller.categories!.isEmpty
                                ? 'Chose Lawyer Category'.tr
                                : controller.categories!.toString()),
                          ),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  /*     SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Styles.thirdlyColor,
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Color(0xFFF5F6F9),
                    ),
                    onPressed: () {
                      Get.to(
                        () => LawyerCountryView(),
                      );
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Expanded(child: Text('Chose Country')
                            // ? ''
                            // : controller.country.countryName,),
                            ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),*/
                  if (!controller.isEdit)
                    Container(
                      alignment: FractionalOffset.centerLeft,
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Chose Country:",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  if (!controller.isEdit)
                    SizedBox(
                      child: FormBuilderDropdown(
                        initialValue: 'UAE',
                        name: 'country',
                        items: dropDownCountries,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            fillColor: Colors.grey[200],
                            filled: true),
                        onChanged: (countrySelected) {
                          controller.country = countrySelected.toString();
                          print(controller.country);
                        },
                      ),
                    ),
                  Divider(
                    height: 40,
                  ),
                  submitButton(
                      onTap: () {
                        controller.saveLawyerDetail();
                      },
                      text: 'Save'.tr)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
