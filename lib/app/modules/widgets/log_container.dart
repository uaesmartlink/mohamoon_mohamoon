import 'package:flutter/material.dart';
import 'package:mohamoon_mohamoon/app/styles/styles.dart';

class LogContainer extends StatelessWidget{

  final Widget? widget;
  const LogContainer({Key? key,@required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient:const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Styles.primaryColor,
                Styles.secondaryColor,
              ]
          )
      ),
      child: widget,
    );
  }
}