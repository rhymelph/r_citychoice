import 'package:flutter/material.dart';
import 'package:r_citychoice/r_citychoice.dart';
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
  SelectStreetResult streetResult;
  SelectAreaResult areaResult;
  SelectCityResult cityResult;

  void onChoiceStreet() async {
    SelectStreetResult selectBack = await Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context) => RStreetChoicePage()));
    if (selectBack != null) {
      setState(() {
        streetResult = selectBack;
      });
    }
  }

  void onChoiceArea() async {
    SelectAreaResult selectBack = await Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context) => RAreaChoicePage()));
    if (selectBack != null) {
      setState(() {
        areaResult = selectBack;
      });
    }
  }

  void onChoiceCity() async {
    SelectCityResult selectBack = await Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context) => RCityChoicePage()));
    if (selectBack != null) {
      setState(() {
        cityResult = selectBack;
      });
    }
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
            SelectableText(
              streetResult == null ? '请选择街道' : streetResult.toString(),
            ),
            RaisedButton(
              onPressed: onChoiceStreet,
              child: Text('选择街道'),
            ),
            SizedBox(
              height: 16,
            ),
            SelectableText(
              areaResult == null ? '请选择区域' : areaResult.toString(),
            ),
            RaisedButton(
              onPressed: onChoiceArea,
              child: Text('选择区域'),
            ),
            SizedBox(
              height: 16,
            ),
            SelectableText(
              cityResult == null ? '请选择城市' : cityResult.toString(),
            ),
            RaisedButton(
              onPressed: onChoiceCity,
              child: Text('选择城市'),
            ),
          ],
        ),
      ),
    );
  }
}
