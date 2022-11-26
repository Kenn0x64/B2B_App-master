import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main_branch/widget/buttons.dart';
import 'package:main_branch/models/products.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _Products();
}

class _Products extends State<Products> {
  late Future<dynamic>? data;

  @override
  void initState() {
    super.initState();
    data = Product.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
               if ((snapshot.data as List<dynamic>).isEmpty) {
                return const Center(heightFactor: 5,child: Text("NO PRODUCTS"));
                }
              return PaginatedDataTable(
                source: ProductsData(snapshot.data),
                columns: const [
                  DataColumn(label: Text('Product Name')),
                  DataColumn(label: Text('Capacity')),
                  DataColumn(label: Text('Price Per Item')),
                  DataColumn(label: Text('Delete')),
                ],
                header: const Center(child: Text('Products')),
                columnSpacing: 60,
                horizontalMargin: 30,
                rowsPerPage: 5,
              );
            } else {
              return Container(
                  margin: const EdgeInsets.all(150),
                  child: const Center(child: CircularProgressIndicator()));
            }
          },
        ),
        const SizedBox(
          height: 30,
        ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MButton(
              bg: Colors.black,
              name: 'Reset Database',
              fun: () async {
                setState(() {
                  Product.reset();
                });
              },
            ),
            MButton(
              bg: Colors.black,
              name: 'Refresh',
              fun: () async {
                setState(() {
                  data = Product.getProducts();
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}

class ProductsData extends DataTableSource {
  List<dynamic> x = [];
  ProductsData(this.x);

  @override
  DataRow? getRow(int index) {
      return DataRow(cells: <DataCell>[
        DataCell(Text(x[index]['productName'])),
        DataCell(Text("${x[index]['capacity']} Units")),
        DataCell(Text("${x[index]['price']}\$")),
        DataCell(IconButton(
          icon: const Icon(FontAwesomeIcons.trashCan),
          onPressed: () {
            Product.deleteItem(x[index]['_id']);
          },
        ))
      ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => x.length;

  @override
  int get selectedRowCount => 0;
}
