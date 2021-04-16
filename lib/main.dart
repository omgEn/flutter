// 导入 相关的控件
import 'package:flutter/material.dart';
import './movie/list.dart';

// 入口函数
void main() {
  runApp(MyApp());
}

// 无状态控件
// 有状态控件: 可通过setState设置数据
class MyApp extends StatelessWidget {
  // build 渲染
  @override
  Widget build(BuildContext context) {
    // 必须有MaterialApp
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // 主题色
        primarySwatch: Colors.blue,
      ),
      // 通过Home指定首页
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 在Flutter中，每个控件，都是一个类
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          // 主界面
          appBar: AppBar(
            title: Text('电影列表'),
            centerTitle: true,
            // 右侧行为按钮
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ],
          ),
          // 侧边栏
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text('张三'),
                  accountEmail: Text('111@.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://images.gitee.com/uploads/91/465191_vsdeveloper.png'),
                  ),
                  // 美化当前控件
                  decoration: BoxDecoration(
                      // 背景图片
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              'http://www.liulongbin.top:3005/images/bg1.jpg'))),
                ),
                ListTile(
                  title: Text('用户反馈'),
                  trailing: Icon(Icons.feedback),
                ),
                ListTile(
                  title: Text('系统设置'),
                  trailing: Icon(Icons.settings),
                ),
                ListTile(
                  title: Text('我要发布'),
                  trailing: Icon(Icons.send),
                ),
                // 分割线
                Divider(color: Colors.red),
                ListTile(
                  title: Text('注销'),
                  trailing: Icon(Icons.exit_to_app),
                ),
              ],
            ),
          ),
          // 底部tabBar
          bottomNavigationBar: Container(
            decoration: BoxDecoration(color: Colors.black),
            height: 50,
            child: TabBar(
              labelStyle: TextStyle(height: 0, fontSize: 10),
              tabs: <Widget>[
                Tab(icon: Icon(Icons.movie_filter), text: '正在热映'),
                Tab(icon: Icon(Icons.movie_creation), text: '即将上映'),
                Tab(icon: Icon(Icons.local_movies), text: 'Top250'),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              MovieList(mt: 'in_theaters'),
              MovieList(mt: 'coming_soon'),
              MovieList(mt: 'top250'),
            ],
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have clicked the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
