import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SliverAppBar',
      theme: ThemeData(
        primaryColor: Color(0xff4caf50),
        primaryColorDark: Color(0xff388E3C),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var _tabs = <String>[];
    _tabs = <String>[
      "Tab 1",
      "Tab 2",
      "Tab 3",
    ];

    return Scaffold(
      body:

          /// 加TabBar
          DefaultTabController(
        length: _tabs.length, // This is the number of tabs.
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverAppBar(
                  leading: new IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {},
                  ),
                  title: const Text('标题'),
                  centerTitle: false,
                  pinned: true,
                  floating: false,
                  snap: false,
                  primary: true,
                  expandedHeight: 230.0,

                  elevation: 10,
                  //是否显示阴影，直接取值innerBoxIsScrolled，展开不显示阴影，合并后会显示
                  forceElevated: innerBoxIsScrolled,

                  actions: <Widget>[
                    new IconButton(
                      icon: Icon(Icons.more_horiz),
                      onPressed: () {
                        print("更多");
                      },
                    ),
                  ],

                  flexibleSpace: new FlexibleSpaceBar(
                    background: Image.asset("images/a.jpg", fit: BoxFit.fill),
                  ),

                  bottom: TabBar(
                    tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            // These are the contents of the tab views, below the tabs.
            children: _tabs.map((String name) {
              //SafeArea 适配刘海屏的一个widget
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      key: PageStorageKey<String>(name),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(10.0),
                          sliver: SliverFixedExtentList(
                            itemExtent: 50.0, //item高度或宽度，取决于滑动方向
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return ListTile(
                                  title: Text('Item $index'),
                                );
                              },
                              childCount: 30,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),

      /// 不加TabBar

//      new CustomScrollView(
//        slivers: <Widget>[
//          new SliverAppBar(
//            leading: new IconButton(
//              icon: Icon(Icons.arrow_back),
//              onPressed: () {},
//            ),
//
//            title: Text("标题"),
//
//            actions: <Widget>[
//              new IconButton(
//                icon: Icon(Icons.add),
//                onPressed: () {
//                  print("添加");
//                },
//              ),
//              new IconButton(
//                icon: Icon(Icons.more_horiz),
//                onPressed: () {
//                  print("更多");
//                },
//              ),
//            ],
//
//            expandedHeight: 230.0,
//            floating: false,
//            pinned: true,
//            snap: false,
//            brightness: Brightness.dark,
//
//            flexibleSpace: new FlexibleSpaceBar(
//              background: Image.asset("images/a.jpg", fit: BoxFit.fill),
//            ),
//
//          ),
//          new SliverFixedExtentList(
//            itemExtent: 50.0,
//            delegate: new SliverChildBuilderDelegate(
//              (context, index) => new ListTile(
//                    title: new Text("Item $index"),
//                  ),
//              childCount: 30,
//            ),
//          ),
//        ],
//      ),
    );
  }
}
