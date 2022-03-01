//

import 'package:flutter/material.dart';

class BookShelf extends StatefulWidget {
  const BookShelf({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<BookShelf> createState() => BookShelfState();
}

enum ShelfModel {
  list,
  grid,
}

class BookShelfState extends State<BookShelf> {

  ShelfModel _shelfModel = ShelfModel.grid;

  @override
  Widget build(BuildContext context) {

    List<PopupMenuItem<String>> pmItem = [];
    SliverGridDelegate gridDelegate;
    if(_shelfModel == ShelfModel.grid){
      pmItem.add(createSelectView(Icons.list, '列表模式', 'AA'));
      gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        childAspectRatio: 0.75,
      );
    } else {
      pmItem.add(createSelectView(Icons.apps, '网格模式', 'AB'));
      gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        childAspectRatio: 3,
      );
    }
    pmItem.add(createSelectView(Icons.file_download, '导入图书', 'B'));

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text(
            "书架",
            textAlign: TextAlign.center,
          ),
          actions: [
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) => pmItem,
              onSelected: (String action) {
                // 点击选项的时候
                switch (action) {
                  case 'AA':
                    setState(() {
                      _shelfModel = ShelfModel.list;
                    });
                    break;
                  case 'AB':
                    setState(() {
                      _shelfModel = ShelfModel.grid;
                    });
                    break;
                  case 'B':
                    break;
                }
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10.0),
              scrollDirection: Axis.vertical,
              gridDelegate: gridDelegate,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return getItemContainer("data");
              },
            )),
          ],
        ));
  }

  Widget getItemContainer(String item) {
    return Container(
      width: 5.0,
      height: 5.0,
      alignment: Alignment.center,
      child: Text(
        item,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      color: Colors.blue,
    );
  }

  // 返回每个隐藏的菜单项
  PopupMenuItem<String> createSelectView(
      IconData icon, String text, String id) {
    return PopupMenuItem<String>(
        value: id,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(icon, color: Colors.blue),
            Text(text),
          ],
        ));
  }
}
