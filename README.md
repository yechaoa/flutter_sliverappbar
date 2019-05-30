# flutter_sliverappbar

Flutter SliverAppBar全解析，你要的效果都在这了！

> 转载请声明出处！！！

先来简单看下部分效果图：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190530152242202.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3llY2hhb2E=,size_16,color_FFFFFF,t_70)![在这里插入图片描述](https://img-blog.csdnimg.cn/20190530152225668.gif)![在这里插入图片描述](https://img-blog.csdnimg.cn/20190530152305446.gif)

本文内容可能有点多，但是都很简单，配上效果图味道更佳~

 <br>
  
## 什么是SliverAppBar 

SliverAppBar 类似于Android中的`CollapsingToolbarLayout`，可以轻松实现页面头部展开、合并的效果。
与AppBar大部分的属性重合，相当于AppBar的加强版。


 <br>
  
先从最基本的效果开始，一步一步做到全效果。

 <br>
  
## 常用属性

```
  const SliverAppBar({
    Key key,
    this.leading,//左侧的图标或文字，多为返回箭头
    this.automaticallyImplyLeading = true,//没有leading为true的时候，默认返回箭头，没有leading且为false，则显示title
    this.title,//标题
    this.actions,//标题右侧的操作
    this.flexibleSpace,//可以理解为SliverAppBar的背景内容区
    this.bottom,//SliverAppBar的底部区
    this.elevation,//阴影
    this.forceElevated = false,//是否显示阴影
    this.backgroundColor,//背景颜色
    this.brightness,//状态栏主题，默认Brightness.dark，可选参数light
    this.iconTheme,//SliverAppBar图标主题
    this.actionsIconTheme,//action图标主题
    this.textTheme,//文字主题
    this.primary = true,//是否显示在状态栏的下面,false就会占领状态栏的高度
    this.centerTitle,//标题是否居中显示
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,//标题横向间距
    this.expandedHeight,//合并的高度，默认是状态栏的高度加AppBar的高度
    this.floating = false,//滑动时是否悬浮
    this.pinned = false,//标题栏是否固定
    this.snap = false,//配合floating使用
  })
```

 <br>
  
## 基本效果

![在这里插入图片描述](https://img-blog.csdnimg.cn/2019053016163694.gif)

```
    return Scaffold(
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            title: Text("标题"),
            expandedHeight: 230.0,
            floating: false,
            pinned: true,
            snap: false,
          ),
          new SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: new SliverChildBuilderDelegate(
              (context, index) => new ListTile(
                    title: new Text("Item $index"),
                  ),
              childCount: 30,
            ),
          ),
        ],
      ),
    );
```

这是最最最基本的效果了，但是也简陋的不行，下面开始一步一步改造。


 <br>
  

## 添加leading

```
            leading: new IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {},
            ),
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190530162355457.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3llY2hhb2E=,size_16,color_FFFFFF,t_70)

 <br>
  
## 添加actions

```
            actions: <Widget>[
              new IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  print("添加");
                },
              ),
              new IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () {
                  print("更多");
                },
              ),
            ],
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190530162634774.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3llY2hhb2E=,size_16,color_FFFFFF,t_70)

 <br>
  
## 滑动标题上移效果
去掉title，添加flexibleSpace

```
            flexibleSpace: new FlexibleSpaceBar(
              title: new Text("标题标题标题"),
              centerTitle: true,
              collapseMode: CollapseMode.pin,
            ),
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20190530163139468.gif)

 <br>
  
## 背景图片沉浸式
项目根目录下新建images文件夹，存放图片，随便选一张即可。
要加载本地图片，还需要在`pubspec.yaml` 文件中配置一下

```
  assets:
    - images/a.jpg
```

修改flexibleSpace

```
            flexibleSpace: new FlexibleSpaceBar(
              background: Image.asset("images/a.jpg", fit: BoxFit.fill),
            ),
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190530163650344.gif)

 <br>
  
## 各种滑动效果演示
-  floating: false, pinned: true, snap: false:

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190530164855105.gif)

- floating: true, pinned: true, snap: true:

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190530165306621.gif)

- floating: false, pinned: false, snap: false:

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190530165750322.gif)

- floating: true, pinned: false, snap: false:

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190530165936841.gif)


总结：仔细观察，区别主要在于：

- 标题栏是否跟着一起滑动
- 上滑的时候，SliverAppBar是直接滑上去还是先合并然后再滑上去。
- 下拉的时候，SliverAppBar是直接拉下来还是先拉下来再展开。

 <br>
  
## 添加TabBar
在SliverAppBar的bottom属性中添加TabBar，直接改造源码中的例子

```
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

```
![在这里插入图片描述](https://img-blog.csdnimg.cn/2019053017100076.gif)

关于TabBar的使用可以看这篇：https://blog.csdn.net/yechaoa/article/details/90482127
 
 <br>
  

ok，以上的效果基本满足日常开发需求了，也可以自己改改属性测试效果。
 
 <br>
  
csdn:https://blog.csdn.net/yechaoa/article/details/90701321

 <br>
  
