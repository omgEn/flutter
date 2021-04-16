import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';
import './detail.dart';

Dio dio = new Dio();

class MovieList extends StatefulWidget {
  // 固定写法
  // MovieList({Key? key}) : super(key: key);
  MovieList({Key? key, required this.mt}) : super(key: key);

  // 电影类型
  final String mt;

  @override
  _MovieListState createState() {
    return new _MovieListState();
  }
}

// 有状态控件，必须结合一个状态管理类，实现
// State<管理的类名>
class _MovieListState extends State<MovieList>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  int pagesize = 10;
  // 电影列表数据
  var mlist = [];
  var total = 0;

  @override
  bool get wantKeepAlive => true;

  // 控件被创建的时候，会执行 initState
  @override
  void initState() {
    super.initState();
    getMovieList();
  }

  // 渲染当前这个MoviList控件的UI结构
  @override
  Widget build(BuildContext context) {
    // return Text('这是电影列表页面' + widget.mt + '----${mlist.length}');
    return ListView.builder(
      itemCount: mlist.length,
      itemBuilder: (BuildContext ctx, int i) {
        var mitem = mlist[i];
        // return Text(mitem['title']);
        return GestureDetector(
            onTap: () {
              // print('aaa');
              // 跳转到详情页
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext ctx) {
                return new MovieDetail(id: mitem['id'], title: mitem['title']);
              }));
            },
            child: Container(
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.black12))),
                child: Row(
                  children: <Widget>[
                    Image.network(mitem['images']['small'],
                        width: 130, height: 180, fit: BoxFit.cover),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text('电影名称:${mitem['title']}'),
                          Text('上映年份:${mitem['year']}年'),
                          Text('电源类型:${mitem['genres'].join(',')}'),
                          Text('豆瓣评分:${mitem['rating']['average']}'),
                          Text('主要演员:${mitem['title']}'),
                        ],
                      ),
                    )
                  ],
                )));
      },
    );
  }

  getMovieList() async {
    // 偏移量的计算公式 (page-1)*pagesize
    int offset = (page - 1) * pagesize;
    var response = await dio.get(
        'http://www.liulongbin.top:3005/api/v2/movie/${widget.mt}?start=$offset&count=$pagesize');
    var result = response.data;
    // print(result);

    // 私有数据赋值，需要在setState函数中处理，否则不会更新
    setState(() {
      // 通过dio返回的数据需要用[]访问而不是.
      mlist = result['subjects'];
      total = result['total'];
    });
  }
}
