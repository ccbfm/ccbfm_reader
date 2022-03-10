//

import 'dart:collection';

import 'package:bot_toast/bot_toast.dart';
import 'package:ccbfm_reader/db/entity/book.dart';
import 'package:ccbfm_reader/generated/l10n.dart';
import 'package:ccbfm_reader/util/log_utils.dart';
import 'package:ccbfm_reader/view/constant/shelf_constant.dart';
import 'package:ccbfm_reader/view/p/shelf_presenter.dart';
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
  State<BookShelf> createState() => _BookShelfState();

}

class _BookShelfState extends State<BookShelf> implements ShelfView {
  PoseModel _poseModel = PoseModel.none;
  List<Book> _bookList = [];
  late ShelfPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    widget._keyValue.clear();
    widget._listBook.clear();
  }

  void _loadData() {
    _presenter = ShelfPresenter(this, context);
    LogUtils.v(_out, _tag, "_listBook=${widget._listBook.isEmpty}");
    if (widget._listBook.isEmpty) {
      _presenter.loadBook();
    } else {
      var v = widget._keyValue[keyShelfPoseModel];
      LogUtils.v(_out, _tag, "keyShelfPoseModel=$v");
      if (v != null) {
        _poseModel = v as PoseModel;
      }
      _bookList = (widget._listBook);
    }
    LogUtils.v(_out, _tag, "_poseModel=$_poseModel");
  }

  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem<String>> pmItem = [];
    if (_poseModel == PoseModel.list) {
      pmItem.add(createSelectView(Icons.apps, '网格模式', 'AB'));
    } else {
      pmItem.add(createSelectView(Icons.list, '列表模式', 'AA'));
    }
    pmItem.add(createSelectView(Icons.file_download, '导入图书', 'B'));

    Widget body;
    if (_poseModel == PoseModel.none) {
      body = Center(
        child: Text(S.of(context).load_loading),
      );
    } else if (_bookList.isEmpty) {
      body = Center(
        child: Text(S.of(context).data_none),
      );
    } else {
      SliverGridDelegate gridDelegate;
      if (_poseModel == PoseModel.grid) {
        gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
          childAspectRatio: 0.55,
        );
      } else {
        gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
          childAspectRatio: 3,
        );
      }

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
              return getItemContainer(_poseModel, _bookList[index]);
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
        changeItemLayout(PoseModel.list, true);
        break;
      case 'AB':
        changeItemLayout(PoseModel.grid, true);
        break;
      case 'B':
        _presenter.addBook();
        break;
    }
  }

  void changeItemLayout(PoseModel poseModel, bool save) {
    _poseModel = poseModel;
    widget._keyValue[keyShelfPoseModel] = poseModel;
    if (save) {
      _presenter.savePoseModel(poseModel);
    }
    setState(() {});
  }

  Widget getItemContainer(PoseModel shelfModel, Book book) {
    if (shelfModel == PoseModel.list) {
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
                    book.name,
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
                book.name,
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

  @override
  void error(String error) {
    BotToast.showText(text: error);
  }

  @override
  void result(List<Book> data) {
    widget._listBook.addAll(data);
    _bookList = (widget._listBook);
  }

  @override
  void resultPoseModel(PoseModel poseModel) {
    changeItemLayout(poseModel, false);
  }

  @override
  void resultAdd(Book book) {
    _bookList.add(book);
    setState(() {});
  }
}
