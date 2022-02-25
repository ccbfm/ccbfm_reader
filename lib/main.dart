import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cc阅读',
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
      home: const MyHomePage(title: 'Cc阅读'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _navigationTitle = const ["书架", "听书", "", "搜索", "设置"];
  int _index = 0;
  List<String> _data = [
    "11",
    "22",
    "11",
    "22",
    "11",
    "22",
    "11",
    "22",
    "11",
    "22",
    "11",
    "22",
    "11",
    "22",
    "11",
    "22",
  ];

  void clickFloatingButton() {}

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          _navigationTitle[_index],
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
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
              itemCount: _data.length,
              itemBuilder: (BuildContext context, int index) {
                return getItemContainer(_data[index]);
              },
            )),
          ],
        ),
      ),

      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 35),
        ///边框
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: Colors.grey,
            border: Border.all(color: Colors.white, width: 3.0)
        ),
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
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: 1,
      ),
    );
  }

  void onNavigationTap(int index) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _index = index;
    });
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
      backgroundColor: Colors.grey,
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
