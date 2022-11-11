import 'package:main_branch/models/products.dart';
import 'package:main_branch/widget/buttons.dart';
import 'package:main_branch/widget/text.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});
  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<ChartType> types = [ChartType.disc, ChartType.ring];
  int selectType = 0;
  late Future<dynamic>? data;

  @override
  void initState() {
    super.initState();
    data = Product.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> chartData = {};
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(30),
          height: 35,
          child: Center(child: MText("Chart Type", 25, FontWeight.normal)),
        ),
        SizedBox(
          width: 300,
          child: FormBuilderDropdown(initialValue: 0, name: 'ct', items: [
            DropdownMenuItem(
              value: 0,
              child: const Text('Disc'),
              onTap: () {
                setState(() {
                  selectType = 0;
                });
              },
            ),
            DropdownMenuItem(
              value: 1,
              child: const Text('Ring'),
              onTap: () {
                setState(() {
                  selectType = 1;
                });
              },
            )
          ]),
        ),
        Flexible(
            child: SizedBox(
          height: 350,
          child: FutureBuilder(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<dynamic> data = snapshot.data;
                for (var element in data) {
                  chartData.addAll(
                      {element['productName']: element['capacity'].toDouble()});
                }
                if (chartData.isEmpty) {
                  return const Center(child:Text("NO PRODUCTS")) ;
                }
                return PieChart(
                  chartType: types[selectType],
                  chartRadius: 210,
                  dataMap: chartData,
                );
              } else {
                return Container(
                    margin: const EdgeInsets.all(150),
                    child: const Center(child: CircularProgressIndicator()));
              }
            },
          ),
        )),
        MButton(
          bg: Colors.green[900],
          name: 'Refresh',
          fun: () async {
            // toChartData(Product.getProducts());
            setState(() {
              data = Product.getProducts();
            });
          },
        ),
      ],
    );
  }
}
