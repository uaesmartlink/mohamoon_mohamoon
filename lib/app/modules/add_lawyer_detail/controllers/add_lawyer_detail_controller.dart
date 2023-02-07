import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:get_storage/get_storage.dart';
import 'package:mohamoon_mohamoon/app/models/lawyer_category.dart';
import 'package:mohamoon_mohamoon/app/models/lawyer_model.dart';
import 'package:mohamoon_mohamoon/app/modules/add_lawyer_detail/views/pages/edit_image_page.dart';
import 'package:mohamoon_mohamoon/app/services/lawyer_category_service.dart';
import 'package:mohamoon_mohamoon/app/services/lawyer_service.dart';
import 'package:mohamoon_mohamoon/app/services/user_service.dart';

//import 'package:mohamoon_mohamoon/app/utils/constants.dart';
import 'package:mohamoon_mohamoon/app/utils/exceptions.dart';


class AddLawyerDetailController extends GetxController
    with StateMixin<List<LawyerCategory>> {
  //TODO: Implement AddLawyerDetailController
  final List<bool> selected = List.generate(100, (i) => false);

  final count = 0.obs;

  var formkey = GlobalKey<FormState>();
  var lawyerName = ''.obs;
  var lawyerPhone = ''.obs;
  var lawyerHospital = 'English';
  var shortBiography = ''.obs;
  List<String>? categories = [];
  Lawyer? lawyer = Get.arguments;
  var profilePicUrl = ''.obs;
  var certificateUrl = ''.obs;
  var lawyerCertificateUrl =''.obs;
  bool isEdit = false;

  @override
  void onInit() {
    super.onInit();

    if (lawyer != null) {
      isEdit = true;
      profilePicUrl.value = lawyer!.lawyerPicture!;
      lawyerName.value = lawyer!.lawyerName!;
      lawyerPhone.value = lawyer!.lawyerPhone!;
      lawyerHospital = lawyer!.lawyerHospital!;
      shortBiography.value = lawyer!.lawyerShortBiography!;
      categories = lawyer!.categories!;
      lawyerCertificateUrl.value = lawyer!.certificateUrl!;
      update();
    }

  }

  @override
  void onClose() {}

  void increment() => count.value++;

  void updateProfilePic(File filePath) {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    UserService().updatePhoto(filePath).then((imgUrl) {
      profilePicUrl.value = imgUrl;
      Get.back();
      EasyLoading.dismiss();
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(), toastLength: Toast.LENGTH_LONG);
      EasyLoading.dismiss();
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  void uploadCertificate(File filePath) {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    UserService().updatePhoto(filePath).then((certifUrl) {
      certificateUrl.value = certifUrl;
      EasyLoading.dismiss();
      Get.back();
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(), toastLength: Toast.LENGTH_LONG);
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  void toEditProfilePic() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image;
    File? imageFile;
    image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    imageFile = File(image!.path);
    print(imageFile);
    print("Hello");
    var imageCropped = await ImageCropper().cropImage(
        sourcePath: image!.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square]);
    if (imageCropped == null) return;
    imageFile = File(imageCropped.path);
    updateProfilePic(imageFile!);
  }

  void initLawyerCategory() {
    LawyerCategoryService().getListLawyerCategory().then((lawyerCategory) {
      change(lawyerCategory, status: RxStatus.success());
    });
  }

  void saveLawyerDetail() async {
    if (lawyer == null) {
      if (profilePicUrl.value.isEmpty) {
        exceptionToast('Please choose your profile photo'.tr);
        return;
      }

      if (certificateUrl.value.isEmpty) {
        exceptionToast('Please choose your certificate'.tr);
        return;
      }
      if (categories == null) {
        exceptionToast('Please chose lawyer Specialty or Category'.tr);
        return;
      }
    }

    if (formkey.currentState!.validate() && categories != null && categories!.isNotEmpty) {
      formkey.currentState!.save();
      EasyLoading.show(
          status: 'loading...'.tr, maskType: EasyLoadingMaskType.black);
      try {
        await LawyerService().saveLawyerDetail(
            lawyerName: lawyerName.value,
            lawyerPhone: lawyerPhone.value,
            hospital: lawyerHospital,
            shortBiography: shortBiography.value,
            pictureUrl: profilePicUrl.value,
            certificateUrl: certificateUrl.value,
            categories: categories!,
            isUpdate: isEdit,);
        EasyLoading.dismiss();
        Get.offNamed('/dashboard');

      } catch (e) {

        Fluttertoast.showToast(msg: e.toString());
        EasyLoading.dismiss();
      }
    }
  }
}


