import 'dart:convert';

import 'package:ccbfm_reader/db/db_helper.dart';
import 'package:ccbfm_reader/db/entity/json_data.dart';
import 'package:ccbfm_reader/generated/l10n.dart';
import 'package:ccbfm_reader/model/book.dart';
import 'package:ccbfm_reader/persistent/sp.dart';
import 'package:ccbfm_reader/util/log_utils.dart';
import 'package:ccbfm_reader/view/constant/shelf_constant.dart';
import 'package:ccbfm_reader/view/p/base_presenter.dart';
import 'package:flutter/cupertino.dart';

const String _tag = "BookShelf";
const bool _out = true;

abstract class ShelfView extends BaseView<List<Book>, String> {
  void poseModel(PoseModel poseModel);
}

class ShelfPresenter extends BasePresenter<ShelfView> {
  ShelfPresenter(ShelfView view, BuildContext? context) : super(view, context);

  void loadBook() {
    DBHelper.db().then((value) {
      value.jsonDataDao.findAllByType(JsonDataType.book).then((value) {
        LogUtils.v(_out, _tag, "loadData-length=${value.length}");
        List<Book> books = [];
        for (JsonData data in value) {
          Book book = Book.fromJson(jsonDecode(data.jsonString));
          books.add(book);
        }
        if (books.isNotEmpty) {
          view.result(books);
          _loadPoseModel();
        } else {
          LogUtils.d(S.of(context!).data_none);
          view.error(S.of(context!).data_none);
        }
      });
    });
  }

  void _loadPoseModel(){
    SP.getStringHasDefault(keyShelfPoseModel, PoseModel.grid.name).then((value) {
      PoseModel poseModel = PoseModel.grid;
      if (value == PoseModel.grid.name) {
        poseModel = PoseModel.grid;
      } else if (value == PoseModel.list.name) {
        poseModel = PoseModel.list;
      }
      view.poseModel(poseModel);
    });
  }
}
