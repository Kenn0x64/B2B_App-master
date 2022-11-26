// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_branch/models/requets.dart';
import 'package:main_branch/widget/buttons.dart';

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
                  return const Center(child: Text("NO REQUESTS"));
                }
                return PaginatedDataTable(
                  source: RequestData(snapshot.data),
                  columns: const [
                    DataColumn(label: Text('Product Name')),
                    DataColumn(label: Text('Requested Capacity')),
                    DataColumn(label: Text('Avilable Capacity')),
                    DataColumn(label: Text('Total Price')),
                    DataColumn(label: Text('Site Name')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Accept')),
                    DataColumn(label: Text('Reject')),
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
      DataCell(Text("${data[index]['product']['capacity']} Units")),
      DataCell(Text(
          "${data[index]['requestedCapacity'] * data[index]['product']['price']}\$")),
      DataCell(Text("${data[index]['siteName']}")),
      DataCell(Text(Request.status.elementAt(data[index]['status']))),
      DataCell(IconButton(
        icon: const Icon(Icons.check),
        onPressed: (() {
          Request.updateStatus(data[index]['_id'], 1);
        }),
      )),
      DataCell(IconButton(
        icon: const Icon(FontAwesomeIcons.xmark),
        onPressed: (() {
          Request.updateStatus(data[index]['_id'], 0);
        }),
      ))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
