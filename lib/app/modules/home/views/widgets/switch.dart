import 'package:flutter/material.dart';
import '../../controllers/home_controller.dart';
import 'package:mohamoon_mohamoon/app/styles/styles.dart';

class SwitchExample extends StatefulWidget {
  final HomeController controller;

  const SwitchExample(this.controller);

  @override
  State<SwitchExample> createState() => _SwitchExampleState(this.controller);
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light = false;
  final HomeController controller;

  _SwitchExampleState(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          light
              ? Text(
                  "Online",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : Text(
                  "Offline",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,

                  ),
                ),
          Switch(
            // This bool value toggles the switch.
            value: light,
            activeColor: Color(0xFFFFE400),

            activeTrackColor: Styles.primaryColor,
            onChanged: (bool value) {
              // This is called when the user toggles the switch.
              setState(() {
                light = value;
                controller.toggle(value);
              });
            },
          )
        ],
      ),
    );
  }
}
