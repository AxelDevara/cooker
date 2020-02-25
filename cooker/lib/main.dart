import 'package:flutter/material.dart';
import 'package:cooker/protos/example.pb.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cooker',
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
        primarySwatch: Colors.red,
      ),
      home: DefaultTabController(
        length: 3,
        child: MyHomePage(title: 'cooker'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('cooker', style: TextStyle(color: Colors.red)),
        bottom: PreferredSize(
            child: Theme(
              data: Theme.of(context),
              child: Container(
                width: MediaQuery.of(context).size.width - 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
                alignment: Alignment.center,
              ),
            ),
            preferredSize: Size(double.infinity, 25),),
      ),
      body: TabBarView(
        children: <Widget>[
          Tab(icon: Icon(Icons.account_balance)),
          Tab(icon: Icon(Icons.account_circle)),
          Tab(icon: Icon(Icons.shopping_cart))
        ],
      ),
      bottomNavigationBar: TabBar(
        tabs: <Widget>[
          Tab(icon: Icon(Icons.fastfood)),
          Tab(icon: Icon(Icons.account_circle)),
          Tab(icon: Icon(Icons.shopping_cart))
        ],
        labelColor: Colors.black,
        unselectedLabelColor: Colors.red,
      ),
    );
  }
}
