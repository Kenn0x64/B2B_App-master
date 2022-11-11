import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MButton extends StatelessWidget {
  String? name;
  double? height = 50;
  double? width = 80;
  Color? bg=Colors.black;
  // Color? tc=Colors.white;

  void Function()? fun;

  MButton({super.key,this.bg, this.name, this.fun, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor:bg),
          onPressed: fun,
          child: Text(
            name as String,
            style: const TextStyle(
              color: Colors.white,
            ),
          )),
    );
  }
}
