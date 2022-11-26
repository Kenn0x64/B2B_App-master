import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_branch/models/products.dart';
import 'package:main_branch/widget/buttons.dart';
import 'package:main_branch/widget/text.dart';
import './widget/deco.dart' as deco;

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formkey = GlobalKey<FormBuilderState>();

  void op() async {
    if (_formkey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Added Product")));
      var name = _formkey.currentState!.fields['productName']!.value;
      var value = _formkey.currentState!.fields['capacity']!.value;
      String price = _formkey.currentState!.fields['price']!.value;
      var p = Product(productName: name, capacity: value, price: int.parse(price));
      await p.addItem();
      // await p.insert();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
            fit: FlexFit.loose,
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 30, 200, 30),
                    child: MText('Add Product', 30, FontWeight.bold)),
                Flexible(
                  fit: FlexFit.loose,
                  child: FormBuilder(
                    key: _formkey,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(25, 0, 25, 15),
                      child: Column(
                        children: [
                          FormBuilderTextField(
                            decoration: deco.Decoration.deco("Product Name",
                                "Name", FontAwesomeIcons.productHunt),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Product Name";
                              }
                              return null;
                            },
                            name: "productName",
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          FormBuilderTextField(
                            name: 'price',
                            keyboardType: TextInputType.number,
                            decoration: deco.Decoration.deco(
                                "Price", "Price", FontAwesomeIcons.tag),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          FormBuilderSlider(
                              decoration: deco.Decoration.deco(
                                  "Product Capacity",
                                  "Capacity",
                                  FontAwesomeIcons.boxesStacked),
                              activeColor:
                                  const Color.fromARGB(255, 82, 96, 206),
                              inactiveColor:
                                  const Color.fromARGB(255, 125, 134, 202),
                              divisions: 9999,
                              name: 'capacity',
                              initialValue: 1,
                              min: 1,
                              max: 10000),
                          Flexible(
                              fit: FlexFit.loose,
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    MButton(
                                      bg: const Color.fromARGB(
                                          255, 34, 48, 151),
                                      width: 90,
                                      name: "Reset",
                                      fun: () {
                                        _formkey.currentState!.reset();
                                        FocusScope.of(context).unfocus();
                                      },
                                    ),
                                    MButton(
                                      bg: const Color.fromARGB(
                                          255, 34, 48, 151),
                                      name: "Add",
                                      fun: op,
                                      width: 90,
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      ],
    );
  }
}
