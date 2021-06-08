import 'package:flutter/material.dart';
import 'package:page_view_sliding_indicator/page_view_sliding_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: controller,
              children: const <Widget>[
                Center(
                  child: Text('First Page'),
                ),
                Center(
                  child: Text('Second Page'),
                ),
                Center(
                  child: Text('Third Page'),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          PageViewSlidingIndicator(
            pageCount: 3,
            controller: controller,
          ),
        ],
      ),
    );
  }
}
