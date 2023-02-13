import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget titleApp() {
  // return Row(
  //   mainAxisAlignment: MainAxisAlignment.center,
  //   children: [
  //     /*Image.asset(
  //       'assets/icons/ic_launcher.png',
  //       width: 45,
  //       height: 45,
  //     ),
  //     SizedBox(
  //       width: 10,
  //     ),*/
  //     RichText(
  //       textAlign: TextAlign.center,
  //       text: TextSpan(
  //           text: 'Mohamoon for'.tr,
  //           style: TextStyle(
  //               fontSize: 30,
  //               fontWeight: FontWeight.w700,
  //               color: Colors.white,),
  //           children: [
  //             TextSpan(
  //               text: ' Lawyer'.tr,
  //               style: TextStyle(color: Colors.white, fontSize: 30),
  //             ),
  //           ]),
  //     ),
  //   ],
  // );
  return Container(
    height: 100,
    width: 220,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/logo.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}
