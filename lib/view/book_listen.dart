//

import 'package:flutter/material.dart';

class BookListen extends StatefulWidget {
   const BookListen({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<BookListen> createState() => BookListenState();
}

class BookListenState extends State<BookListen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text(
            "听书",
            textAlign: TextAlign.center,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10.0),
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                childAspectRatio: 0.75,
              ),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Text("data");
              },
            )),
          ],
        ));
  }
}
