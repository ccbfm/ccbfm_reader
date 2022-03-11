import 'package:ccbfm_reader/db/db_helper.dart';
import 'package:ccbfm_reader/db/entity/book.dart';
import 'package:ccbfm_reader/persistent/sp.dart';
import 'package:ccbfm_reader/util/log_utils.dart';
import 'package:ccbfm_reader/view/constant/shelf_constant.dart';
import 'package:ccbfm_reader/view/p/base_presenter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

const String _tag = "BookShelf";
const bool _out = true;

abstract class ShelfView extends BaseView<List<Book>, String> {
  void resultPoseModel(PoseModel poseModel);

  void resultAdd(Book book);
}

class ShelfPresenter extends BasePresenter<ShelfView> {
  ShelfPresenter(ShelfView view, BuildContext context) : super(view, context);

  void loadBook() {
    DBHelper.db().then((value) {
      value.bookDao.findAll().then((books) {
        LogUtils.v(_out, _tag, "loadData-length=${books.length}");
        view.result(books);
        _loadPoseModel();
      }).catchError((error) {
        view.error(error.toString());
      });
    });
  }

  void addBook() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile pFile = result.files.single;
      LogUtils.v(_out, _tag, "addBook-path=$pFile");
      String? path = pFile.path;
      if (path != null) {
        Book book = Book.build(pFile.name, path);
        LogUtils.v(_out, _tag, "addBook-book=$book");
        DBHelper.db().then((value) {
          value.bookDao.insertData(book).then((value) {
            LogUtils.v(_out, _tag, "addBook-value=$value");
            view.resultAdd(book);
          }).catchError((error) {
            LogUtils.v(_out, _tag, "addBook-error=$error");
            view.error("文件已存在");
          });
        });
      } else {
        view.error("路径为空");
      }
    }
  }

  void _loadPoseModel() {
    SP
        .getStringHasDefault(keyShelfPoseModel, PoseModel.grid.name)
        .then((value) {
      PoseModel poseModel = PoseModel.grid;
      if (value == PoseModel.grid.name) {
        poseModel = PoseModel.grid;
      } else if (value == PoseModel.list.name) {
        poseModel = PoseModel.list;
      }
      view.resultPoseModel(poseModel);
    });
  }

  void savePoseModel(PoseModel poseModel){
    SP.setString(keyShelfPoseModel, poseModel.name);
  }
}
