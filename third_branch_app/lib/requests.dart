// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:main_branch/models/requets.dart';
import 'package:main_branch/widget/buttons.dart';
import './pay.dart';

// ignore: must_be_immutable
class Requests extends StatefulWidget {
  Requests({required this.bg, super.key});
  Color bg;

  @override
  State<Requests> createState() => _Requests(bg: bg);
}

class _Requests extends State<Requests> {
  _Requests({required this.bg});
  Color bg;
  Future<dynamic>? data;

  @override
  void initState() {
    super.initState();
    data = Request.getRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        FutureBuilder(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if ((snapshot.data as List<dynamic>).isEmpty) {
                  return const Center(
                      heightFactor: 2, child: Text("NO REQUESTS"));
                }
                return PaginatedDataTable(
                  source: RequestData(snapshot.data),
                  columns: const [
                    DataColumn(label: Text('Product Name')),
                    DataColumn(label: Text('Requested Capacity')),
                    DataColumn(label: Text('Price Per Item')),
                    DataColumn(label: Text('Total Price')),
                    DataColumn(label: Text('Status')),
                  ],
                  header: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: const Center(child: Text('Requsets'))),
                  columnSpacing: 30,
                  horizontalMargin: 20,
                  rowsPerPage: 5,
                );
              } else {
                return Container(
                    margin: const EdgeInsets.all(150),
                    child: const Center(child: CircularProgressIndicator()));
              }
            }),
        const SizedBox(
          height: 30,
        ),
        MButton(
          bg: bg,
          name: 'Refresh',
          fun: () async {
            setState(() {
              data = Request.getRequests();
            });
          },
        ),
        MButton(
          bg: bg,
          name: 'Add Payment',
          fun: () async {
            Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
              return Pay();
            })));
          },
        ),
      ],
    );
  }
}

class RequestData extends DataTableSource {
  List<dynamic> data = [];
  RequestData(this.data);

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: <DataCell>[
      DataCell(Text(data[index]['product']['productName'])),
      DataCell(Text("${data[index]['requestedCapacity']} Units")),
      DataCell(Text("${data[index]['product']['price']}\$")),
      DataCell(Text(
          "${data[index]['product']['price'] * data[index]['requestedCapacity']}\$")),
      DataCell(Text(Request.status.elementAt(data[index]['status']))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
