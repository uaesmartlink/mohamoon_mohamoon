import 'package:flutter/material.dart';
import '../../controllers/home_controller.dart';

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
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: Column(
        children: [
          light
              ? Text(
                  "Online",
                  style: TextStyle(
                    color: Colors.lightGreen,
                  ),
                )
              : Text(
                  "Offline",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
          Switch(
            // This bool value toggles the switch.
            value: light,
            activeColor: Colors.red,
            onChanged: (bool value) {
              // This is called when the user toggles the switch.
              setState(() {
                light = value;
                this.controller.toggle(value);
              });
            },
          )
        ],
      ),
    );
  }
}
