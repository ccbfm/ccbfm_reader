//

import 'dart:collection';

import 'package:ccbfm_reader/db/db_helper.dart';
import 'package:ccbfm_reader/db/entity/json_data.dart';
import 'package:ccbfm_reader/generated/l10n.dart';
import 'package:ccbfm_reader/model/book.dart';
import 'package:ccbfm_reader/persistent/sp.dart';
import 'package:ccbfm_reader/util/log_utils.dart';
import 'package:flutter/material.dart';

const String _tag = "BookShelf";
const bool _out = true;

class BookShelf extends StatefulWidget {
  BookShelf({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final List<Book> _listBook = [];
  final HashMap<String, Object> _keyValue = HashMap();

  @override
  State<BookShelf> createState() => BookShelfState();
}

const String keyShelfModel = "ShelfModel";
enum ShelfModel {
  none,
  list,
  grid,
}

class BookShelfState extends State<BookShelf> {
  ShelfModel _shelfModel = ShelfModel.none;
  List<Book> _bookList = [];

  @override
  void initState() {
    super.initState();
    if (widget._listBook.isEmpty) {
      //widget._listBook.addAll(_bookList);
      widget._listBook.add(Book("bookName1bookName1", ""));
      widget._listBook.add(Book("bookName2", ""));
      widget._listBook.add(Book("bookName3", ""));
      widget._listBook.add(Book("bookName4", ""));
      widget._listBook.add(Book("bookName1", ""));
      widget._listBook.add(Book("bookName2", ""));
      widget._listBook.add(Book("bookName3", ""));
      widget._listBook.add(Book("bookName4", ""));
      _bookList = (widget._listBook);
      _bookList.add(Book("bookName5", ""));
      SP.getStringHasDefault(keyShelfModel, ShelfModel.grid.name).then((value) {
        if (value == ShelfModel.grid.name) {
          _shelfModel = ShelfModel.grid;
        } else if (value == ShelfModel.list.name) {
          _shelfModel = ShelfModel.list;
        }
        widget._keyValue[keyShelfModel] = _shelfModel;
        setState(() {});
      });
    } else {
      _shelfModel = widget._keyValue[keyShelfModel] as ShelfModel;
      _bookList = (widget._listBook);
    }
    loadData();
  }

  void loadData() {
    DBHelper.db().then((value) {
      value.jsonDataDao.findAllByType(JsonDataType.book).then((value) {
        LogUtils.v(_out, _tag, "loadData-length=${value.length}");

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem<String>> pmItem = [];
    Widget body;
    if (_shelfModel == ShelfModel.none) {
      body = const Center(
        child: Text("加载中..."),
      );
    } else {
      SliverGridDelegate gridDelegate;
      if (_shelfModel == ShelfModel.grid) {
        pmItem.add(createSelectView(Icons.list, '列表模式', 'AA'));
        gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
          childAspectRatio: 0.55,
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

      body = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10.0),
            scrollDirection: Axis.vertical,
            gridDelegate: gridDelegate,
            itemCount: _bookList.length,
            itemBuilder: (BuildContext context, int index) {
              return getItemContainer(_shelfModel, _bookList[index]);
            },
          )),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          S.of(context).book_shelf,
          textAlign: TextAlign.center,
        ),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => pmItem,
            onSelected: onSelectedPopupMenu,
          ),
        ],
      ),
      body: body,
    );
  }

  void onSelectedPopupMenu(String action) {
    switch (action) {
      case 'AA':
        changeItemLayout(ShelfModel.list);
        break;
      case 'AB':
        changeItemLayout(ShelfModel.grid);
        break;
      case 'B':
        break;
    }
  }

  void changeItemLayout(ShelfModel shelfModel) {
    setState(() {
      _shelfModel = shelfModel;
      widget._keyValue[keyShelfModel] = _shelfModel;
      SP.setString(keyShelfModel, _shelfModel.name);
    });
  }

  Widget getItemContainer(ShelfModel shelfModel, Book book) {
    if (shelfModel == ShelfModel.list) {
      return Container(
        alignment: Alignment.center,
        child: Row(
          children: [
            Flexible(
              child: Container(
                color: const Color(0xffdcdcdc),
                width: 90,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    book.bookName,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              padding: const EdgeInsets.all(5.0),
            )
          ],
        ),
        color: Colors.transparent,
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: const Color(0xffdcdcdc),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              child: Text(
                book.bookName,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              height: 50,
            ),
          ],
        ),
        color: Colors.transparent,
      );
    }
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
