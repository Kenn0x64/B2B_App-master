import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'widget/deco.dart' as deco;

class Pay extends StatefulWidget {
  const Pay({super.key});

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  var _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pay")),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            FormBuilder(
                child: Column(
              children: [
                FormBuilderTextField(
                  name: "cn",
                  decoration: deco.Decoration.deco("Card Number",
                      "Enter Card Number", FontAwesomeIcons.ccVisa),
                ),
                const SizedBox(
                  height: 10,
                ),
                FormBuilderTextField(
                  name: "cn",
                  decoration: deco.Decoration.deco(
                      "CVV", "CVV", FontAwesomeIcons.userSecret),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(_selectedDate ==
                        null //ternary expression to check if date is null
                    ? 'No date was chosen!'
                    : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}'),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: (() {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              //which date will display when user open the picker
                              firstDate: DateTime(1950),
                              //what will be the previous supported year in picker
                              lastDate: DateTime
                                  .now()) //what will be the up to supported date in picker
                          .then((pickedDate) {
                        //then usually do the future job
                        if (pickedDate == null) {
                          //if user tap cancel then this function will stop
                          return;
                        }
                        setState(() {
                          //for rebuilding the ui
                          _selectedDate = pickedDate;
                        });
                      });
                    }),
                    child: const Text("Set Expiration Date")),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Payment Send"),
                          content: const Text(
                              "Payment Is Being Processed"),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Continue"))
                          ],
                        );
                      },
                    );
                    },
                    child: Text("Buy"))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
