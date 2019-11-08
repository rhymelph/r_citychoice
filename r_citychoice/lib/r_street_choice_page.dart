import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model.dart';

class RStreetChoicePage extends StatefulWidget {
  @override
  _RStreetChoicePageState createState() => _RStreetChoicePageState();
}

class _RStreetChoicePageState extends State<RStreetChoicePage> {
  Province selectProvince;
  City selectCity;
  Area selectArea;
  Street selectStreet;

  //选中的list
  static List<Province> selectProvinces;
  List<City> selectCities;
  List<Area> selectAreas;
  List<Street> selectStreets;
  Key leftKey;
  Key rightKey;


  void loadData() async {
    List<dynamic> mapList = await compute(_loadData, data,
        debugLabel: 'json decode for "area choice"');
    setState(() {
      selectProvinces = mapList.map((item) => Province.formMap(item)).toList();
    });
  }

  static List<dynamic> _loadData(String data) {
    return json.decode(data);
  }

  void onSelectedToBack() {
    Navigator.of(context)
        .pop(SelectStreetResult(selectProvince, selectCity, selectArea, selectStreet));
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('选择街道'),
          centerTitle: true,
          actions: <Widget>[
            selectStreet != null
                ? FlatButton(
                    onPressed: onSelectedToBack,
                    child: Text(
                      '确认',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
        body: selectProvinces == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  buildTitleRow(),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(flex: 1, child: buildLeftColumn()),
                        Expanded(flex: 3, child: buildRightColumn()),
                      ],
                    ),
                  ),
                ],
              ));
  }

  Widget buildTitleRow() => AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: Container(
          color: const Color(0xFFE5E5E5),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(16),
          child: RichText(
            text: TextSpan(
              text: '',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).primaryColor,
              ),
              children: [
                ...selectProvince != null
                    ? [
                        TextSpan(
                          text: '${selectProvince.name}',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(
                                () {
                                  selectCity = null;
                                  selectArea = null;
                                  selectAreas = null;
                                  selectStreet = null;
                                  selectStreets = null;
                                  leftKey = null;
                                  rightKey = null;
                                },
                              );
                            },
                        )
                      ]
                    : [],
                ...selectCity != null
                    ? [
                        TextSpan(
                          text: ' > ${selectCity.name}',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(
                                () {
                                  selectArea = null;
                                  selectStreet = null;
                                  selectStreets = null;
                                  leftKey = null;
                                  rightKey = null;
                                },
                              );
                            },
                        )
                      ]
                    : [],
                ...selectArea != null
                    ? [
                        TextSpan(
                          text: ' > ${selectArea.name}',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(
                                () {
                                  selectStreet = null;
                                  leftKey = null;
                                  rightKey = null;
                                },
                              );
                            },
                        )
                      ]
                    : [],
                ...selectStreet != null
                    ? [
                        TextSpan(
                          text: ' > ${selectStreet.name}',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              setState(
                                () {
                                  leftKey = null;
                                  rightKey = null;
                                },
                              );
                            },
                        )
                      ]
                    : [],
              ],
            ),
          ),
        ),
      );

  Widget buildLeftColumn() => DecoratedBox(
        decoration: BoxDecoration(
            border: Border(
                right: BorderSide(
          color: Color(0xFFE5E5E5),
          width: 1,
        ))),
        child: ListView(
          key: leftKey,
          children: selectProvince == null || selectCity == null
              ? selectProvinces
                  .map(
                    (item) => ListTile(
                      title: Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 16,
                          color: item == selectProvince
                              ? Colors.red
                              : Color(0xFF333333),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          rightKey = ValueKey(item);
                          selectProvince = item;
                          selectCities = item.childs;
                          selectCity = null;
                        });
                      },
                    ),
                  )
                  .toList()
              : selectCity == null || selectArea == null
                  ? selectCities
                      .map(
                        (item) => ListTile(
                          title: Text(
                            item.name,
                            style: TextStyle(
                              fontSize: 16,
                              color: item == selectCity
                                  ? Colors.red
                                  : Color(0xFF333333),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              rightKey = ValueKey(item);
                              selectCity = item;
                              selectAreas = item.childs;
                              selectArea = null;
                            });
                          },
                        ),
                      )
                      .toList()
                  : selectArea == null || selectStreet == null
                      ? selectAreas
                          .map(
                            (item) => ListTile(
                              title: Text(
                                item.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: item == selectArea
                                      ? Colors.red
                                      : Color(0xFF333333),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  rightKey = ValueKey(item);
                                  selectArea = item;
                                  selectStreets = item.childs;
                                  selectStreet = null;
                                });
                              },
                            ),
                          )
                          .toList()
                      : selectAreas
                          .map(
                            (item) => ListTile(
                              title: Text(
                                item.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: item == selectArea
                                      ? Colors.red
                                      : Color(0xFF333333),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  rightKey = ValueKey(item);
                                  selectArea = item;
                                  selectStreets = item.childs;
                                  selectStreet = null;
                                });
                              },
                            ),
                          )
                          .toList(),
        ),
      );

  Widget buildRightColumn() => ListView(
        key: rightKey,
        children: selectStreets != null
            ? selectStreets
                .map(
                  (item) => ListTile(
                    title: Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 16,
                        color: item == selectStreet
                            ? Colors.red
                            : Color(0xFF333333),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        leftKey = ValueKey(item);
                        selectStreet = item;
                      });
                    },
                  ),
                )
                .toList()
            : selectAreas != null
                ? selectAreas
                    .map(
                      (item) => ListTile(
                        title: Text(
                          item.name,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF333333),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            leftKey = ValueKey(item);
                            selectArea = item;
                            selectStreets = item.childs;
                          });
                        },
                      ),
                    )
                    .toList()
                : selectCities != null
                    ? selectCities
                        .map(
                          (item) => ListTile(
                            title: Text(
                              item.name,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF333333),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                leftKey = ValueKey(item);
                                selectCity = item;
                                selectAreas = item.childs;
                              });
                            },
                          ),
                        )
                        .toList()
                    : [],
      );
}