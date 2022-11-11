// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:main_branch/models/requets.dart';
import 'package:main_branch/widget/buttons.dart';
import 'package:main_branch/widget/text.dart';
import 'package:main_branch/models/products.dart';

class RequestProduct extends StatefulWidget {
  final Color bg;
  const RequestProduct({super.key, required this.bg});

  @override
  State<RequestProduct> createState() => _RequestProductState(bg: bg);
}

class _RequestProductState extends State<RequestProduct> {
  final _formkey = GlobalKey<FormBuilderState>();
  Color bg;
  Future<dynamic>? data;

  _RequestProductState({required this.bg});

  @override
  void initState() {
    super.initState();
    data = Product.getProducts();
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
                    width: 200,
                    margin: const EdgeInsets.fromLTRB(0, 40, 160, 50),
                    child: MText('Request Product', 30, FontWeight.bold)),
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 280, 0),
                    child: MText('Product', 20, FontWeight.normal)),
                Flexible(
                  fit: FlexFit.loose,
                  child: FormBuilder(
                    key: _formkey,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(25, 0, 25, 15),
                      child: Column(
                        children: [
                          Flexible(
                            child: FutureBuilder(
                              future: data,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<dynamic> pdata = snapshot.data;
                                  if (pdata.isEmpty) {
                                    // reset();
                                    return const Text("NO PRODUCTS ");
                                  }
                                  return FormBuilderDropdown(
                                      name: 'products',
                                      items: [
                                        ...(pdata.map((element) =>
                                            DropdownMenuItem(
                                              value: element['_id'].toString(),
                                              child:
                                                  Text(element['productName']),
                                            )))
                                      ]);
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                          ),
                          const Flexible(
                            fit: FlexFit.loose,
                            child: SizedBox(
                              height: 30,
                            ),
                          ),
                          Container(
                              width: 200,
                              margin: const EdgeInsets.fromLTRB(0, 0, 250, 0),
                              child: MText('Request Product Capcity', 17,
                                  FontWeight.normal)),
                          FormBuilderSlider(
                              activeColor: bg,
                              inactiveColor:
                                  const Color.fromARGB(255, 135, 108, 18),
                              divisions: 99,
                              name: 'requestedCapacity',
                              initialValue: 1,
                              min: 1,
                              max: 100),
                          Flexible(
                              fit: FlexFit.loose,
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    MButton(
                                      bg: bg,
                                      name: "Reset",
                                      fun: (() {
                                        _formkey.currentState!.reset();
                                        FocusScope.of(context).unfocus();
                                      }),
                                    ),
                                    MButton(
                                        bg: bg,
                                        name: "Request",
                                        fun: () {
                                          if (_formkey.currentState!.validate()) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Requested Product")));
                                            var proid = _formkey.currentState!
                                                .fields['products']!.value;
                                            var reqCap = _formkey
                                                .currentState!
                                                .fields['requestedCapacity']!
                                                .value;
                                            Request req = Request(
                                                product: proid,
                                                requestedCapacity: reqCap,
                                                currntStatus: 2);
                                            req.makeRequest();
                                          }
                                        }),
                                  ],
                                ),
                              )),
                          const SizedBox(
                            height: 24,
                          ),
                          MButton(
                              bg: bg,
                              name: "Refresh",
                              fun: () {
                                setState(() {
                                  data = Product.getProducts();
                                });
                              }),
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
