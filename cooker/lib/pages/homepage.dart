import 'package:cooker/auth/baseAuth.dart';
import 'package:cooker/widgets/posts.dart';
import 'package:flutter/material.dart';
import 'package:cooker/header/searchbar.dart';

// class HomePage extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: MyHomePage(title: 'cooker'),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   title: Text('cooker', style: TextStyle(color: Colors.red)),
      //   bottom: PreferredSize(
      //       child: SearchBar(),
      //       preferredSize: Size(double.infinity, 25),),
      // ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              child: SliverAppBar(
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                snap: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(widget.userId),
                  background: SearchBar(),
                ),
                expandedHeight: 200,
                floating: true,
                forceElevated: innerBoxIsScrolled,
              ),
            )
          ];
        },
        body: SafeArea(
          child: TabBarView(
            children: <Widget>[
              Posts(),
              Tab(icon: Icon(Icons.account_circle)),
              Tab(icon: Icon(Icons.shopping_cart))
            ],
          ),
        ),
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
