import 'package:flutter/cupertino.dart';

abstract class BaseView<T, R> {
  void result(T data);

  void error(R error);
}

class BasePresenter<V extends BaseView> {

  V view;

  BuildContext context;

  BasePresenter(this.view, this.context);
}
