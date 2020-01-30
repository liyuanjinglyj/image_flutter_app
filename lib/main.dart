import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'lyj图片浏览器',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'lyj图片浏览器'),
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
  final int rowCount = 3;   // 每行显示的图片数
  final List<String> imagesList = [//用到的图片
    'assets/1.jpg',
    'assets/2.jpg',
    'assets/3.jpg',
    'assets/4.jpg',
    'assets/5.jpg',
    'assets/6.jpg',
    'assets/7.jpg',
    'assets/8.jpg',
    'assets/9.jpg',
  ];

  Widget _scrollView(BuildContext context){
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,//是否可以展开
            delegate: MySliverPersistentHeaderDelegate(minExtent: 100,maxExtent: 200),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width / rowCount,//屏幕宽度除每行个数，单个子Widget的水平最大宽度
              mainAxisSpacing: 0.0,//水平单个子Widget之间间距
              crossAxisSpacing: 0.0,//垂直单个子Widget之间间距
              childAspectRatio: 9.0/16,//宽高比
            ),
            delegate: SliverChildBuilderDelegate((BuildContext context,int index){
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 2,left: 2,bottom: 2,right: 2),//各填充2个空白像素
                child: Image.asset(imagesList[index%imagesList.length]),
              );
            },childCount: imagesList.length*3),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: new Text(widget.title),),
      body: _scrollView(context),
    );
  }
}

class MySliverPersistentHeaderDelegate implements SliverPersistentHeaderDelegate{
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(//类似于Java开发Android中FrameLayout控件
      fit: StackFit.expand,//大小与父组件一样大
      children: <Widget>[
        Image.asset(
          'assets/timg.jpg',
          fit: BoxFit.cover,//充满容器，可能会被截断。
        ),
        Container(
          decoration: BoxDecoration(//装饰器
            gradient: LinearGradient(//线性渐变
              colors: [
                Colors.transparent,
                Colors.black54
              ],
              stops: [0.5, 1.0],//渐变的取值
              //从上到下渐变
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        Positioned(
          //离左右下的边距
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Text(
            '我的相册',
            style: TextStyle(fontSize: 28.0, color: Colors.white),
          ),
        ),
      ],
    );
  }
  //构造函数传入：maxExtent表示header完全展开时的高度，minExtent表示header在收起时的最小高度
  MySliverPersistentHeaderDelegate({
    this.minExtent,
    this.maxExtent,
  });

  double maxExtent;
  double minExtent;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;//重绘
  }

  @override
  // TODO: implement snapConfiguration
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  // TODO: implement stretchConfiguration
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;

}