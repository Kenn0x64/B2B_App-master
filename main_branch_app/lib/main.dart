import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
import './products.dart';
import './requests.dart';
import './additems.dart';
import './chart.dart';




void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: MyWidget()));
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int index=0;
  final screen = [
    const Products(),
    Requests(bg:const Color.fromARGB(255, 140, 13, 13),),
    const Chart(),
    const AddItem()
    ];
  
  List<Color? > c=[
    Colors.black,
    const Color.fromARGB(255, 140, 13, 13),
    Colors.green[900],
    const Color.fromARGB(255, 34, 48, 151)
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: c[index],
        title: const Text("HQ App"),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items:  <BottomNavigationBarItem>[
             BottomNavigationBarItem(
              icon: const Icon(Icons.laptop),
              label: "Products",
              backgroundColor: c[index],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.request_page),
              label: "Requests",
              backgroundColor: c[index],
            ),
            BottomNavigationBarItem(
              icon: const Icon(FontAwesomeIcons.chartPie,size: 19),
              label: "Chart",
              backgroundColor: c[index],
            ),
             BottomNavigationBarItem(
              icon: const Icon(Icons.add),
              label: "Add Product",
              backgroundColor: c[index],
            )
          ]
          ),
          body: IndexedStack(
            index:index,
            children: screen, ),
    );
  }
}
