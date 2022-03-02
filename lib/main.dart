import 'package:ccbfm_reader/generated/l10n.dart';
import 'package:ccbfm_reader/view/book_search.dart';
import 'package:ccbfm_reader/view/book_settings.dart';
import 'package:ccbfm_reader/view/book_shelf.dart';
import 'package:ccbfm_reader/view/book_listen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
  final _pageController = PageController(initialPage: 0);
  final List<StatefulWidget> _pageView = [
    BookShelf(),
    const BookListen(),
    const BookSearch(),
    const BookSettings(),
  ];

  void clickFloatingButton() {}

  @override
  Widget build(BuildContext context) {
    List<String> _navigationTitle = [
      S.of(context).book_shelf,
      S.of(context).book_listen,
      "",
      S.of(context).book_search,
      S.of(context).book_settings,
    ];
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      /*appBar: AppBar(
        centerTitle: true,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          _navigationTitle[_index],
          textAlign: TextAlign.center,
        ),
      ),*/
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: onPageChanged,
          itemBuilder: (BuildContext context, int index) {
            switch (index) {
              case 0:
              case 1:
              case 2:
              case 3:
                return _pageView[index];
            }
            return const Text("未定义");
          },
          itemCount: 4,

          ///禁止滑动
          physics: const NeverScrollableScrollPhysics(),
        ),
      ),

      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 35),

        ///边框
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: Colors.grey,
            border: Border.all(color: Colors.white, width: 3.0)),
        child: FloatingActionButton(
          onPressed: clickFloatingButton,
          tooltip: '听书',
          child: const Icon(
            Icons.play_arrow,
          ),
          backgroundColor: Colors.blueGrey,
        ),
      ),
      // This trailing comma makes auto-format
      //floatingActionButtonLocation: CustomFloatingActionButtonLocation(FloatingActionButtonLocation.centerDocked, 0, 16),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // ting nicer for build methods.
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          items: [
            getNavigationItemContainer(Icons.book, _navigationTitle[0]),
            getNavigationItemContainer(Icons.hearing, _navigationTitle[1]),
            getNavigationItemFloatingActionButton(),
            getNavigationItemContainer(Icons.search, _navigationTitle[3]),
            getNavigationItemContainer(Icons.settings, _navigationTitle[4]),
          ],

          ///显示label
          type: BottomNavigationBarType.fixed,
          onTap: onNavigationTap,
          currentIndex: _index,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
        ),
      ),
    );
  }

  void onPageChanged(int index) {
    if (index == 2) {
      index = 3;
    } else if (index == 3) {
      index = 4;
    }
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _index = index;
    });
  }

  void onNavigationTap(int index) {
    if (index == 2) {
      return;
    }
    if (index == 3) {
      index = 2;
    } else if (index == 4) {
      index = 3;
    }
    _pageController.jumpToPage(index);
    //animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  BottomNavigationBarItem getNavigationItemContainer(
      IconData icon, String item) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: item,
      backgroundColor: Colors.grey,
    );
  }

  BottomNavigationBarItem getNavigationItemFloatingActionButton() {
    return const BottomNavigationBarItem(
      icon: Icon(null),
      label: "",
      backgroundColor: Colors.transparent,
    );
  }
}

/// 自定义 floatingActionButtonLocation 偏移量
class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  FloatingActionButtonLocation location;
  double offsetX; // X方向的偏移量
  double offsetY; // Y方向的偏移量
  CustomFloatingActionButtonLocation(this.location, this.offsetX, this.offsetY);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    Offset offset = location.getOffset(scaffoldGeometry);
    return Offset(offset.dx + offsetX, offset.dy + offsetY);
  }
}
