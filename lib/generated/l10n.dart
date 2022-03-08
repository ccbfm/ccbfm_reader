// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `CcReader`
  String get app_name {
    return Intl.message(
      'CcReader',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `BookShelf`
  String get book_shelf {
    return Intl.message(
      'BookShelf',
      name: 'book_shelf',
      desc: '',
      args: [],
    );
  }

  /// `听书`
  String get book_listen {
    return Intl.message(
      '听书',
      name: 'book_listen',
      desc: '',
      args: [],
    );
  }

  /// `搜索`
  String get book_search {
    return Intl.message(
      '搜索',
      name: 'book_search',
      desc: '',
      args: [],
    );
  }

  /// `设置`
  String get book_settings {
    return Intl.message(
      '设置',
      name: 'book_settings',
      desc: '',
      args: [],
    );
  }

  /// `加载中...`
  String get load_loading {
    return Intl.message(
      '加载中...',
      name: 'load_loading',
      desc: '',
      args: [],
    );
  }

  /// `没有数据`
  String get data_none {
    return Intl.message(
      '没有数据',
      name: 'data_none',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
