import 'package:flutter/material.dart';
import './requests.dart';
import 'reqproduct.dart';

void main() {
  runApp(
      const MaterialApp(debugShowCheckedModeBanner: false, home: MyWidget()));
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int index = 0;

  List<Color> c = [
    const Color.fromARGB(255, 96, 24, 79),
    const Color.fromARGB(207, 199, 129, 25),
  ];

  final screen = [
    Requests(bg:  const Color.fromARGB(255, 96, 24, 79)),
    const RequestProduct(bg: Color.fromARGB(207, 199, 129, 25))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: c[index],
        title: const Text("Branch App"),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.request_page),
              label: "Requests",
              backgroundColor: c[index],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.add),
              label: "Request Product",
              backgroundColor: c[index],
            )
          ]),
      body: IndexedStack(
        index: index,
        children: screen,
      ),
    );
  }
}
