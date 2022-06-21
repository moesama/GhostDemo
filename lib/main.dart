import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class AndroidBackTop {
  ///通讯名称,回到手机桌面
  static const String chanel = "android/back/desktop";

  //返回手机桌面事件
  static const String eventBackDesktop = "backDesktop";

  ///设置回退到手机桌面
  static Future<bool> backDesktop() async {
    const platform = MethodChannel(chanel);
    try {
      await platform.invokeMethod(eventBackDesktop);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
    return Future.value(false);
  }
}

class Car {
  final String name;
  final String imageUrl;

  const Car({
    required this.name,
    required this.imageUrl,
  });
}

//模型数组
final List<Car> datas = [
  const Car(
    name: '保时捷918 Spyder',
    imageUrl:
        'https://upload-images.jianshu.io/upload_images/2990730-7d8be6ebc4c7c95b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
  ),
  const Car(
    name: '兰博基尼Aventador',
    imageUrl:
        'https://upload-images.jianshu.io/upload_images/2990730-e3bfd824f30afaac?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
  ),
  const Car(
    name: '法拉利Enzo',
    imageUrl:
        'https://upload-images.jianshu.io/upload_images/2990730-a1d64cf5da2d9d99?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
  ),
  const Car(
    name: 'Zenvo ST1',
    imageUrl:
        'https://upload-images.jianshu.io/upload_images/2990730-bf883b46690f93ce?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
  ),
  const Car(
    name: '迈凯伦F1',
    imageUrl:
        'https://upload-images.jianshu.io/upload_images/2990730-5a7b5550a19b8342?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
  ),
  const Car(
    name: '萨林S7',
    imageUrl:
        'https://upload-images.jianshu.io/upload_images/2990730-2e128d18144ad5b8?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
  ),
  const Car(
    name: '科尼赛克CCR',
    imageUrl:
        'https://upload-images.jianshu.io/upload_images/2990730-01ced8f6f95219ec?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
  ),
  const Car(
    name: '布加迪Chiron',
    imageUrl:
        'https://upload-images.jianshu.io/upload_images/2990730-7fc8359eb61adac0?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
  ),
  const Car(
    name: '轩尼诗Venom GT',
    imageUrl:
        'https://upload-images.jianshu.io/upload_images/2990730-d332bf510d61bbc2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
  ),
  const Car(
    name: '西贝尔Tuatara',
    imageUrl:
        'https://upload-images.jianshu.io/upload_images/2990730-3dd9a70b25ae6bc9?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
  )
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  Widget _cellForRow(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Image.network(datas[index].imageUrl),
          const SizedBox(
            height: 10,
          ),
          Text(
            datas[index].name,
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18.0,
                fontStyle: FontStyle.values[1]),
          ),
          Container(
            height: 20,
          ),
        ],
      ), //每人一辆跑车
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return WillPopScope(
      onWillPop: AndroidBackTop.backDesktop,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body:
        ListView.builder(itemCount: datas.length, itemBuilder: _cellForRow),
      ),
    );
  }
}
