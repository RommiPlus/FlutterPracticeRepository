// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart';
// import 'dart:math';
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:charts_flutter/src/text_element.dart';
// import 'package:charts_flutter/src/text_style.dart' as style;

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 99;
//   List<charts.Series> seriesList;
//   bool animate = false;
// final _myState = new charts.UserManagedState<num>();

//   String selectedText = "2";

//   CustomCircleSymbolRenderer render;
//   // LineChart theChart;
//   void _incrementCounter() {
//     _counter++;
//     final random = new Random();
//     seriesList[0].data.add(LinearSales(_counter.toString(), random.nextInt(100)));

//     setState(() {});
//   }

//   @override
//   void initState() {
//     seriesList = _createRandomData();
//     render = CustomCircleSymbolRenderer(selectedText);

//     // theChart = charts.LineChart(seriesList);

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(selectedText),
//       ),
//       body: Container(
//         child: charts.LineChart(seriesList, animate: animate, behaviors: [
//           new charts.PanAndZoomBehavior(),
//           new LinePointHighlighter(
//             symbolRenderer: render,
//           ),
//           // new charts.InitialSelection(selectedDataConfig: [
//           //   new charts.SeriesDatumConfig<int>('Sales', int.parse(selectedText))
//           // ])
//         ],
//         selectionModels: [
//           new charts.SelectionModelConfig(
//             type: charts.SelectionModelType.info,
//             changedListener: _onSelectionChanged,
//           )
//         ],
//         // userManagedState: _myState,
//         // domainAxis: new charts.OrdinalAxisSpec(
//         //   viewport: new charts.OrdinalViewport("60", 5)
//         // ),
//               domainAxis: new charts.NumericAxisSpec(
//           // Set the initial viewport by providing a new AxisSpec with the
//           // desired viewport, in NumericExtents.
//           viewport: new charts.NumericExtents(2, 8)),
//         ),

//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }

//   // / Create random data.
//   static List<charts.Series<LinearSales, String>> _createRandomData() {
//     final random = new Random();

//     final data = <LinearSales>[];

//     for (var i = 0; i < 50; i++) {
//       // data.add(new LinearSales(i, random.nextInt(100)));
//       data.add(new LinearSales(i.toString(), random.nextInt(100)));
//     }

//     return [
//       new charts.Series<LinearSales, String>(
//         id: 'Sales',
//         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//         domainFn: (LinearSales sales, _) => sales.year,
//         measureFn: (LinearSales sales, _) => sales.sales,
//         data: data,
//       )
//     ];
//   }

//   _onSelectionChanged(charts.SelectionModel model) {
//     final selectedDatum = model.selectedDatum;
//     print(selectedDatum.first);
//     if (model.hasDatumSelection) {
//       setState(() {
//         selectedText =
//             (model.selectedSeries[0].measureFn(model.selectedDatum[0].index))
//                 .toString();
//         render.text = selectedText;
//         });
//       debugPrint(selectedText);
//     }
//   }
// }

// class LinearSales {
//   final String year;
//   final int sales;

//   LinearSales(this.year, this.sales);
// }

// /// Sample time series data type.
// class MyRow {
//   final DateTime timeStamp;
//   final int cost;
//   MyRow(this.timeStamp, this.cost);
// }

// class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
//   String text;
//   CustomCircleSymbolRenderer(this.text);
//   @override
//   void paint(ChartCanvas canvas, Rectangle<num> bounds,
//       {List<int> dashPattern,
//       Color fillColor,
//       Color strokeColor,
//       double strokeWidthPx}) {
//         print(this);
//     super.paint(canvas, bounds,
//         dashPattern: dashPattern,
//         fillColor: fillColor,
//         strokeColor: strokeColor,
//         strokeWidthPx: strokeWidthPx);
//     canvas.drawRect(
//         Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10,
//             bounds.height + 10),
//         fill: Color.white);
//     var textStyle = style.TextStyle();
//     print("omg  $text");
//     textStyle.color = Color.black;
//     textStyle.fontSize = 15;
//     canvas.drawText(TextElement(text, style: textStyle), (bounds.left).round(),
//         (bounds.top - 28).round());
//   }

// }

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/src/text_element.dart';
import 'package:charts_flutter/src/text_style.dart' as style;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 99;

  // 存放二维图的数据
  List<charts.Series> seriesList;
  bool animate = false;

// 点击选中的数据
  String selectedText = "2";

  // 自定义选中效果，点击显示数据
  CustomCircleSymbolRenderer render;

// x轴数字和label的映射
  List<charts.TickSpec<num>> staticTicks = [];

  void _incrementCounter() {
    _counter++;
    final random = new Random();
    seriesList[0].data.add(LinearSales(_counter, random.nextDouble()));

    setState(() {});
  }

  @override
  void initState() {
    // 初始化一些数据
    seriesList = _createRandomData();
    render = CustomCircleSymbolRenderer(selectedText);
    for (var i = 0; i < 144; i++) {
      staticTicks.add(charts.TickSpec(i, label: 'ha$i'));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedText),
      ),
      body: Container(
        height: 200,
        // 线性表
        child: charts.LineChart(
          seriesList,
          animate: animate,
          behaviors: [
            // 支持缩放手势
            new charts.PanAndZoomBehavior(),
            // 点击效果
            new LinePointHighlighter(
              symbolRenderer: render,
            ),
          ],
          selectionModels: [
            // 设置点击事件
            new charts.SelectionModelConfig(
              type: charts.SelectionModelType.info,
              changedListener: _onSelectionChanged,
            )
          ],
          primaryMeasureAxis: new charts.NumericAxisSpec(
              // tickProviderSpec:charts.StaticNumericTickProviderSpec(staticTicks),
              // renderSpec: new charts.SmallTickRendererSpec(
              // desiredTickCount:5,
              renderSpec: new charts.SmallTickRendererSpec(
                  // Tick and Label styling here.
                  ),
              tickProviderSpec: new charts.BasicNumericTickProviderSpec(
                  desiredMinTickCount: 5,
                  desiredMaxTickCount: 5,
                  zeroBound: false,
                  dataIsInWholeNumbers: false)),
          domainAxis: new charts.NumericAxisSpec(
              // 初始显示的范围
              viewport: new charts.NumericExtents(2, 8),
              // 修改x轴的标签
              tickProviderSpec:
                  charts.StaticNumericTickProviderSpec(staticTicks)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // / Create random data.
  static List<charts.Series<LinearSales, num>> _createRandomData() {
    final random = new Random();
    final data = <LinearSales>[];
    var initNum = 20;
    for (var i = 0; i < 12; i++) {
      for (var j = 0; j < 12; j++) {
        data.add(new LinearSales(i * 12 + j, initNum + random.nextDouble()));
      }

      if (i < 6) {
        initNum++;
      } else {
        initNum--;
      }
    }

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;
    print(selectedDatum.first);
    if (model.hasDatumSelection) {
      setState(() {
        selectedText =
            (model.selectedSeries[0].measureFn(model.selectedDatum[0].index))
                .toString();
        // 修改显示的数据
        render.text = selectedText;
      });
      debugPrint(selectedText);
    }
  }
}

class LinearSales {
  final int year;
  final double sales;

  LinearSales(this.year, this.sales);
}

// 自定义点击显示数据
class CustomCircleSymbolRenderer extends CircleSymbolRenderer {
  String text;

  CustomCircleSymbolRenderer(this.text);

  @override
  void paint(ChartCanvas canvas, Rectangle<num> bounds,
      {List<int> dashPattern,
      Color fillColor,
      Color strokeColor,
      double strokeWidthPx}) {
    print(this);
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
        Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10,
            bounds.height + 10),
        fill: Color.white);
    var textStyle = style.TextStyle();
    textStyle.color = Color.black;
    textStyle.fontSize = 15;
    canvas.drawText(TextElement(text, style: textStyle), (bounds.left).round(),
        (bounds.top - 28).round());
  }
}
