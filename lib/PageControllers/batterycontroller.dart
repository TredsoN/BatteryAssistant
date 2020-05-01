import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_qr_reader/qrcode_reader_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:oktoast/oktoast.dart';
import 'dart:math';
import 'package:batteryassistant/main.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';

///电池溯源界面
class BatteryTrace extends StatelessWidget {
  final List _owners;
  BatteryTrace(this._owners);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 247, 255),
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(
              '电池溯源',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            backgroundColor: Color.fromARGB(255, 150, 140, 240)),
        body: ListView.builder(
            itemCount: _owners.length,
            itemBuilder: (context, index) {
              String _str = '';
              if (index == 0)
                _str = '生产商';
              else if (index == _owners.length - 1)
                _str = '当前拥有者';
              else
                _str = '拥有者' + index.toString();
              return myTile(_str, _owners[index]);
            }));
  }

  Widget myTile(String title, String content) {
    return Container(
        foregroundDecoration: UnderlineTabIndicator(
          borderSide: BorderSide(width: 0.5, color: Colors.black45),
        ),
        decoration: BoxDecoration(color: Colors.white),
        child: ListTile(
            title: Text(title,
                style: TextStyle(color: Colors.black54, fontSize: 12)),
            subtitle: Text(content,
                style: TextStyle(color: Colors.black, fontSize: 20))));
  }
}

///电池市场界面
class BatteryMarket extends StatelessWidget {
  final List _markets;
  BatteryMarket(this._markets);

  @override
  Widget build(BuildContext context) {
    if (_markets.length == 0)
      return Scaffold(
          floatingActionButton: new Builder(builder: (BuildContext context) {
            return new FloatingActionButton(
              child: Icon(Icons.add),
              foregroundColor: Colors.white,
              backgroundColor: Color.fromARGB(255, 150, 140, 240),
              onPressed: () {
                Navigator.pushNamed(context, '/advertise');
              },
            );
          }),
          backgroundColor: Color.fromARGB(255, 243, 247, 255),
          appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.keyboard_arrow_left),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: Text(
                '电池市场',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              backgroundColor: Color.fromARGB(255, 150, 140, 240)),
          body: Container(
              child: ListTile(
            title: Text('暂无交易信息', style: TextStyle(color: Colors.black54)),
          )));
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 247, 255),
        floatingActionButton: new Builder(builder: (BuildContext context) {
          return new FloatingActionButton(
            child: Icon(Icons.add),
            foregroundColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 150, 140, 240),
            onPressed: () {
              Navigator.pushNamed(context, '/advertise');
            },
          );
        }),
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(
              '电池市场',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            backgroundColor: Color.fromARGB(255, 150, 140, 240)),
        body: ListView.builder(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.05,
                0,
                MediaQuery.of(context).size.width * 0.05,
                0),
            itemCount: _markets.length,
            itemBuilder: (context, index) {
              return Column(children: <Widget>[
                SizedBox(height: 15),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 0.5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(5, 5),
                              blurRadius: 5)
                        ]),
                    child: Column(children: <Widget>[
                      Tooltip(
                          message:
                              '电池品牌:${_markets[index]['type']}\n电池最大电压:${_markets[index]['vol']}\n电池最大容量:${_markets[index]['cap']}\n电池平均温度:${_markets[index]['tem']}\n电池循环充放电次数:${_markets[index]['cycle']}',
                          child: ListTile(
                            title: Text('电池编号（长按查看电池信息）',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12)),
                            subtitle: Text(_markets[index]['name'],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18)),
                          )),
                      ListTile(
                        title: Text('卖家姓名',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 12)),
                        subtitle: Text(_markets[index]['owner'],
                            style:
                                TextStyle(color: Colors.black, fontSize: 18)),
                      ),
                      ListTile(
                        title: Text('卖家留言',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 12)),
                        subtitle: Text(_markets[index]['msg'],
                            style:
                                TextStyle(color: Colors.black, fontSize: 18)),
                      ),
                      ListTile(
                        title: Text('联系电话',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 12)),
                        subtitle: Text(_markets[index]['phone'],
                            style:
                                TextStyle(color: Colors.black, fontSize: 18)),
                      ),
                      ListTile(
                        title: Text('联系邮箱',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 12)),
                        subtitle: Text(_markets[index]['email'],
                            style:
                                TextStyle(color: Colors.black, fontSize: 18)),
                      )
                    ])),
                SizedBox(height: 15)
              ]);
            }));
  }

  Widget selectView(IconData icon, String text, String id) {
    return PopupMenuItem<String>(
        value: id,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(icon, color: Color.fromARGB(255, 150, 140, 240)),
            Text(text),
          ],
        ));
  }
}

///电池出售详情界面（交易码，电池名称）
class BatterySell extends StatelessWidget {
  final String _code;
  final String _name;
  BatterySell(this._code, this._name);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Images/mainbgpic.png'), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                title: Text(
                  '交易信息',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                backgroundColor: Colors.transparent),
            body: Column(children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              QrImage(
                data: _code,
                size: MediaQuery.of(context).size.height * 0.3,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: ListView(
                        children: <Widget>[
                          SizedBox(height: 30),
                          Center(
                              child: Container(
                                  child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Flex(
                                          direction: Axis.horizontal,
                                          children: <Widget>[
                                            Text('您正在出售电池 ',
                                                style: TextStyle(fontSize: 18)),
                                            SizedBox(width: 20),
                                            Expanded(
                                                child: Text(_name,
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w600)))
                                          ])),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9)),
                          SizedBox(height: 30),
                          Container(
                              decoration: UnderlineTabIndicator(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black45),
                                  insets: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.05,
                                      0,
                                      MediaQuery.of(context).size.width * 0.05,
                                      0))),
                          SizedBox(height: 20),
                          Center(
                              child: Container(
                                  child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text('扫描二维码进行交易',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black45))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9)),
                          SizedBox(height: 10),
                          Center(
                              child: Container(
                                  child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text('请在5分钟之内完成交易，超时交易自动取消',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black45))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9)),
                          SizedBox(height: 40),
                          Align(
                              child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: MaterialButton(
                                height: 50,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text("取消交易",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w200,
                                        color: Colors.white)),
                                color: Color.fromARGB(255, 150, 140, 240),
                                onPressed: () {
                                  _batteryordercancel(context);
                                }),
                          )),
                        ],
                      )))
            ])));
  }

  _batteryordercancel(context) async {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: '加载中',
          );
        });
    Map<String, dynamic> param = {
      'id': User.userid(),
    };
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post(
          'server/Everitoken/transfer/sell/cancel',
          data: param);
      print(response.data);
      if (response.data['code'] == 0) {
        showToast('交易取消成功');
        Navigator.pop(context);
      } else {
        showToast('网络错误，请稍后重试');
      }
    } catch (e) {
      print(e.toString() + '||' + param.toString());
      showToast('网络错误，请稍后重试');
    }
    Navigator.pop(context);
  }
}

///电池购买详情界面（出售方，交易码，电池名称）
class BatteryPurchase extends StatelessWidget {
  final String _name, _owner, _code, _id;
  BatteryPurchase(this._name, this._owner, this._code, this._id);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Images/mainbgpic.png'), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                title: Text(
                  '交易信息',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                backgroundColor: Colors.transparent),
            body: Column(children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.4),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Center(
                        child: Container(
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Flex(
                                    direction: Axis.horizontal,
                                    children: <Widget>[
                                      Text('您正在购买电池 ',
                                          style: TextStyle(fontSize: 18)),
                                      SizedBox(width: 20),
                                      Expanded(
                                          child: Text(_name,
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600)))
                                    ])),
                            width: MediaQuery.of(context).size.width * 0.9)),
                    SizedBox(height: 30),
                    Center(
                        child: Container(
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Flex(
                                    direction: Axis.horizontal,
                                    children: <Widget>[
                                      Text('出售方',
                                          style: TextStyle(fontSize: 18)),
                                      SizedBox(width: 20),
                                      Expanded(
                                          child: Text(_owner,
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600)))
                                    ])),
                            width: MediaQuery.of(context).size.width * 0.9)),
                    SizedBox(height: 20),
                    Container(
                        decoration: UnderlineTabIndicator(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black45),
                            insets: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.05,
                                0,
                                MediaQuery.of(context).size.width * 0.05,
                                0))),
                    SizedBox(height: 20),
                    Center(
                        child: Container(
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text('请与卖家商议好价格后再确认交易',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black45))),
                            width: MediaQuery.of(context).size.width * 0.9)),
                    SizedBox(height: 40),
                    Align(
                        child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MaterialButton(
                          height: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("确认交易",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white)),
                          color: Color.fromARGB(255, 150, 140, 240),
                          onPressed: () {
                            _batteryorderconfirm(context);
                          }),
                    ))
                  ],
                ),
              ))
            ])));
  }

  _batteryorderconfirm(context) async {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: '加载中',
          );
        });
    Map<String, dynamic> param = {
      'starter_id': _id,
      'checker_id': User.userid(),
      'Battery_name': _name,
      'ID_code': _code,
    };
    print(param);
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post(
          'server/Everitoken/transfer/sell/confirm',
          data: param);
      print(response.data);
      if (response.data['code'] == 0) {
        showToast('交易成功');
        Navigator.popUntil(context, ModalRoute.withName('/'));
      } else {
        showToast('网络错误，请稍后重试');
        Navigator.pop(context);
      }
    } catch (e) {
      print(e.toString() + '||' + param.toString());
      showToast('网络错误，请稍后重试');
          Navigator.pop(context);
    }
  }
}

///电池回收详情界面（出售方，交易码，电池名称）
class BatteryDestroy extends StatelessWidget {
  final String _name, _owner, _code, _id;
  BatteryDestroy(this._name, this._owner, this._code, this._id);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Images/mainbgpic.png'), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                title: Text(
                  '电池回收',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                backgroundColor: Colors.transparent),
            body: Column(children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.4),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(color: Colors.white),
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Center(
                        child: Container(
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Flex(
                                    direction: Axis.horizontal,
                                    children: <Widget>[
                                      Text('您正在回收电池 ',
                                          style: TextStyle(fontSize: 18)),
                                      SizedBox(width: 20),
                                      Expanded(
                                          child: Text(_name,
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600)))
                                    ])),
                            width: MediaQuery.of(context).size.width * 0.9)),
                    SizedBox(height: 30),
                    Center(
                        child: Container(
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Flex(
                                    direction: Axis.horizontal,
                                    children: <Widget>[
                                      Text('拥有者',
                                          style: TextStyle(fontSize: 18)),
                                      SizedBox(width: 20),
                                      Expanded(
                                          child: Text(_owner,
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600)))
                                    ])),
                            width: MediaQuery.of(context).size.width * 0.9)),
                    SizedBox(height: 20),
                    Container(
                        decoration: UnderlineTabIndicator(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black45),
                            insets: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.05,
                                0,
                                MediaQuery.of(context).size.width * 0.05,
                                0))),
                    SizedBox(height: 20),
                    Center(
                        child: Container(
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text('请与电池拥有者商议好后再确认',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black45))),
                            width: MediaQuery.of(context).size.width * 0.9)),
                    SizedBox(height: 40),
                    Align(
                        child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MaterialButton(
                          height: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("确认回收",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white)),
                          color: Color.fromARGB(255, 150, 140, 240),
                          onPressed: () {
                            _batteryorderconfirm(context);
                          }),
                    ))
                  ],
                ),
              ))
            ])));
  }

  _batteryorderconfirm(context) async {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: '加载中',
          );
        });
    Map<String, dynamic> param = {
      'starter_id': _id,
      'checker_id': User.userid(),
      'Battery_name': _name,
      'ID_code': _code,
    };
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post(
          'server/Everitoken/transfer/sell/confirm',
          data: param);
      print(response.data);
      if (response.data['code'] == 0)
        _batterydestroy(context);
      else {
        showToast('网络错误，请稍后重试');
      }
    } catch (e) {
      print(e.toString() + '||' + param.toString());
      showToast('网络错误，请稍后重试');
    }
    Navigator.pop(context);
  }

  _batterydestroy(context) async {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: '加载中',
          );
        });
    Map<String, dynamic> param = {
      'id': _name,
      'info_id': User.userid2(),
      'type': User.type(),
    };
    print(param);
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post(
          'server/Everitoken/Manage/DestroyBattery',
          data: param);
      print(response.data);
      if (response.data['code'] == 0) {
        showToast('回收成功');
        Navigator.popUntil(context, ModalRoute.withName('/'));
      } else {
        showToast('网络错误，请稍后重试');
        Navigator.pop(context);
      }
    } catch (e) {
      print(e.toString() + '||' + param.toString());
      showToast('网络错误，请稍后重试');
      Navigator.pop(context);
    }
  }
}

///选择电池界面（用于查看电池信息）
class BatteryInfoSelect extends StatelessWidget {
  final List _names;
  BatteryInfoSelect(this._names);

  @override
  Widget build(BuildContext context) {
    if (_names.length == 0)
      return Scaffold(
          backgroundColor: Color.fromARGB(255, 243, 247, 255),
          appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.keyboard_arrow_left),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: Text(
                '我的电池',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              backgroundColor: Color.fromARGB(255, 150, 140, 240)),
          body: Container(
              child: ListTile(
            title: Text('您未拥有电池', style: TextStyle(color: Colors.black54)),
          )));
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 247, 255),
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(
              '我的电池',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            backgroundColor: Color.fromARGB(255, 150, 140, 240)),
        body: ListView.builder(
            itemCount: _names.length,
            itemBuilder: (context, index) {
              return Container(
                  decoration: BoxDecoration(color: Colors.white),
                  foregroundDecoration: UnderlineTabIndicator(
                      borderSide: BorderSide(width: 1, color: Colors.black45),
                      insets: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                  child: Tooltip(
                    message: 'asdasd',
                    child: ListTile(
                      leading: Icon(Icons.battery_full,
                          color: Color.fromARGB(255, 150, 140, 240)),
                      title: Text(_names[index].toString()),
                      onTap: () {
                        _batteryinfoget(context, _names[index]);
                      },
                    ),
                  ));
            }));
  }

  _batteryinfoget(context, String id) async {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: '加载中',
          );
        });
    Map<String, dynamic> param = {
      'id': id,
    };
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post(
          'server/Everitoken/Info/BatteryInfo',
          data: param);
      if (response.data['Producer'] != null){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BatteryInfo(
              response.data['Producer'],
              id,
              response.data['Battery']['Type'],
              response.data['Battery']['batteryCapacity'].toString(),
              response.data['Battery']['batteryMaxVoltage'].toString(),
              response.data['Battery']['batteryAverageTemperature'].toString(),
              response.data['Battery']['batteryChgCycles'].toString());
        }));
      }
      else
        showToast('网络错误，请稍后重试');
    } catch (e) {
      print(e);
      showToast('网络错误，请稍后重试');
      Navigator.pop(context);
    }
    
  }
}

///电池信息界面
class BatteryInfo extends StatelessWidget {
  final String _producerid,
      _batteryname,
      _batterytype,
      _capacity,
      _voltage,
      _tempe,
      _cycles;
  BatteryInfo(this._producerid, this._batteryname, this._batterytype, this._capacity,
      this._voltage, this._tempe, this._cycles);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 247, 255),
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(
              '电池信息',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            backgroundColor: Color.fromARGB(255, 150, 140, 240)),
        body: ListView(children: <Widget>[
          Container(
              height: 50,
              decoration: UnderlineTabIndicator(
                borderSide: BorderSide(width: 1, color: Colors.black45),
              )),
          myTile('生产商', _producerid),
          myTile('品牌', _batterytype),
          myTile('电池编号', _batteryname),
          myTile('容量', _capacity + 'mA·h'),
          myTile('电压', _voltage + 'V'),
          myTile('温度', _tempe + '℃'),
          myTile('循环充放电次数', _cycles + '次'),
          Container(
              decoration: UnderlineTabIndicator(
            borderSide: BorderSide(width: 1, color: Colors.black45),
          )),
          SizedBox(height: 30),
          Container(
              decoration: UnderlineTabIndicator(
            borderSide: BorderSide(width: 1, color: Colors.black45),
          )),
          Container(
              foregroundDecoration: UnderlineTabIndicator(
                borderSide: BorderSide(width: 1, color: Colors.black45),
              ),
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                title: Text('电池溯源'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  _batterytrace(context);
                  //Navigator.push(context,MaterialPageRoute(builder:(context){return Battery_Trace(n);}));
                },
              )),
        ]));
  }

  Widget myTile(String title, String content) {
    return Container(
        foregroundDecoration: UnderlineTabIndicator(
            borderSide: BorderSide(width: 0.5, color: Colors.black45),
            insets: EdgeInsets.fromLTRB(10, 0, 10, 0)),
        decoration: BoxDecoration(color: Colors.white),
        child: ListTile(
            title: Text(title,
                style: TextStyle(color: Colors.black54, fontSize: 12)),
            subtitle: Text(content,
                style: TextStyle(color: Colors.black, fontSize: 20))));
  }

  _batterytrace(context) async {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: '加载中',
          );
        });
    Map<String, dynamic> param = {
      'BatteryName': _batteryname,
    };
    print(param);
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post(
          'server/Everitoken/Info/PastOwner',
          data: param);
      print(response.data);
      List msg = List();
      List data = response.data['msg'];
      msg.add(_producerid);
      msg.insertAll(1, data.reversed);
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return BatteryTrace(msg);
      }));
    } catch (e) {
      print(e);
      showToast('网络错误，请稍后重试');
      Navigator.pop(context);
    }
  }
}

///电池管理导航界面（至发行电池，出售电池）
class BatteryManage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Images/mainbgpic.png'), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                backgroundColor: Colors.transparent),
            body: ListView(children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Center(
                  child: Image.asset('Images/title.png',
                      height: MediaQuery.of(context).size.height * 0.1)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Center(
                  child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 0.5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(5, 5),
                          blurRadius: 5)
                    ]),
                child: ListView(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text('电池管理', style: TextStyle(fontSize: 20))),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Align(
                        child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MaterialButton(
                          height: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("发行电池",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white)),
                          color: Color.fromARGB(255, 150, 140, 240),
                          onPressed: () {
                            _getuserauthorize(context);
                          }),
                    )),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Align(
                        child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MaterialButton(
                          height: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("出售电池",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white)),
                          color: Color.fromARGB(255, 150, 140, 240),
                          onPressed: () {
                            _batterylistget(context);
                          }),
                    ))
                  ],
                ),
              ))
            ])));
  }

  _batterylistget(context) async {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: '加载中',
          );
        });
    Map<String, dynamic> param = {
      'id': User.userid2(),
      'type': User.type(),
    };
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post(
          'server/Everitoken/Info/possessBattery',
          data: param);
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return BatterySelect(response.data['msg']);
      }));
    } catch (e) {
      print(e.toString());
      showToast('网络错误，请稍后重试');
      Navigator.pop(context);
    }
  }

  _getuserauthorize(context) async {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: '加载中',
          );
        });
    try {
      Map<String, dynamic> param = {
        'id': User.userid2(),
        'type': User.type(),
      };
      Response response;
      Dio dio = new Dio();
      response = await dio.post(
          'server/Everitoken/Info/BasicInfo',
          data: param);
      if (response.data['producer_authorized'] == 1)
        User.resetcertificate(true);
      else
        User.resetcertificate(false);
      Navigator.pop(context);
      Navigator.pushNamed(context, '/batteryproduce');
    } catch (e) {
      print(e);
    }

  }
}

///电池交易导航界面（至出售电池，购买电池，电池市场）
class BatteryTrade extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BatteryTradeState();
  }
}

class BatteryTradeState extends State<BatteryTrade> {
  String barcode;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Images/mainbgpic.png'), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                backgroundColor: Colors.transparent),
            body: ListView(children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Center(
                  child: Image.asset('Images/title.png',
                      height: MediaQuery.of(context).size.height * 0.1)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Center(
                  child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 0.5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(5, 5),
                          blurRadius: 5)
                    ]),
                child: ListView(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text('电池交易', style: TextStyle(fontSize: 20))),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Align(
                        child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MaterialButton(
                          height: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("出售电池",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white)),
                          color: Color.fromARGB(255, 150, 140, 240),
                          onPressed: () {
                            _batterylistget();
                          }),
                    )),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Align(
                        child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MaterialButton(
                          height: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("购买电池",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white)),
                          color: Color.fromARGB(255, 150, 140, 240),
                          onPressed: () async {
                            _requestcamera();
                          }),
                    )),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Align(
                        child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: MaterialButton(
                          height: 50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("电池市场",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white)),
                          color: Color.fromARGB(255, 150, 140, 240),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return BatteryMarket([
                                {
                                  'name': '170181dcbf-ba51-4ef',
                                  'owner': 'David',
                                  'phone': '17526584125',
                                  'email': '95125@qq.com',
                                  'type': '银河星',
                                  'vol': '25V',
                                  'tem': '36℃',
                                  'cycle': '120次',
                                  'cap': '20V',
                                  'msg': '低价转售二手电池'
                                },
                                {
                                  'name': '170b9ae9e5-d543-4f2',
                                  'owner': '测试用户1',
                                  'phone': '1755442511',
                                  'email': 'test@qq.com',
                                  'type': '银河星',
                                  'vol': '36V',
                                  'tem': '36℃',
                                  'cycle': '225次',
                                  'cap': '22V',
                                  'msg': '出售银河星系列动力电池'
                                },
                                {
                                  'name': '17f8460f02-fd52-46b',
                                  'owner': 'Alice',
                                  'phone': '16852485214',
                                  'email': 'alice@qq.com',
                                  'type': '炫动科技',
                                  'vol': '35V',
                                  'tem': '37℃',
                                  'cycle': '155次',
                                  'cap': '22V',
                                  'msg': '低价转售二手电池，详情电话谈'
                                },
                                {
                                  'name': '170181dcbf-ba51-4ef',
                                  'owner': 'David',
                                  'phone': '17526584125',
                                  'email': '95125@qq.com',
                                  'type': '银河星',
                                  'vol': '25V',
                                  'tem': '36℃',
                                  'cycle': '120次',
                                  'cap': '20V',
                                  'msg': '低价转售二手电池'
                                },
                                {
                                  'name': '170b9ae9e5-d543-4f2',
                                  'owner': '测试用户1',
                                  'phone': '1755442511',
                                  'email': 'test@qq.com',
                                  'type': '银河星',
                                  'vol': '36V',
                                  'tem': '36℃',
                                  'cycle': '225次',
                                  'cap': '22V',
                                  'msg': '出售银河星系列动力电池'
                                },
                                {
                                  'name': '17f8460f02-fd52-46b',
                                  'owner': 'Alice',
                                  'phone': '16852485214',
                                  'email': 'alice@qq.com',
                                  'type': '炫动科技',
                                  'vol': '35V',
                                  'tem': '37℃',
                                  'cycle': '155次',
                                  'cap': '22V',
                                  'msg': '低价转售二手电池，详情电话谈'
                                },
                                {
                                  'name': '170181dcbf-ba51-4ef',
                                  'owner': 'David',
                                  'phone': '17526584125',
                                  'email': '95125@qq.com',
                                  'type': '银河星',
                                  'vol': '25V',
                                  'tem': '36℃',
                                  'cycle': '120次',
                                  'cap': '20V',
                                  'msg': '低价转售二手电池'
                                },
                                {
                                  'name': '170b9ae9e5-d543-4f2',
                                  'owner': '测试用户1',
                                  'phone': '1755442511',
                                  'email': 'test@qq.com',
                                  'type': '银河星',
                                  'vol': '36V',
                                  'tem': '36℃',
                                  'cycle': '225次',
                                  'cap': '22V',
                                  'msg': '出售银河星系列动力电池'
                                },
                                {
                                  'name': '17f8460f02-fd52-46b',
                                  'owner': 'Alice',
                                  'phone': '16852485214',
                                  'email': 'alice@qq.com',
                                  'type': '炫动科技',
                                  'vol': '35V',
                                  'tem': '37℃',
                                  'cycle': '155次',
                                  'cap': '22V',
                                  'msg': '低价转售二手电池，详情电话谈'
                                },
                                {
                                  'name': '170181dcbf-ba51-4ef',
                                  'owner': 'David',
                                  'phone': '17526584125',
                                  'email': '95125@qq.com',
                                  'type': '银河星',
                                  'vol': '25V',
                                  'tem': '36℃',
                                  'cycle': '120次',
                                  'cap': '20V',
                                  'msg': '低价转售二手电池'
                                },
                                {
                                  'name': '170b9ae9e5-d543-4f2',
                                  'owner': '测试用户1',
                                  'phone': '1755442511',
                                  'email': 'test@qq.com',
                                  'type': '银河星',
                                  'vol': '36V',
                                  'tem': '36℃',
                                  'cycle': '225次',
                                  'cap': '22V',
                                  'msg': '出售银河星系列动力电池'
                                },
                                {
                                  'name': '17f8460f02-fd52-46b',
                                  'owner': 'Alice',
                                  'phone': '16852485214',
                                  'email': 'alice@qq.com',
                                  'type': '炫动科技',
                                  'vol': '35V',
                                  'tem': '37℃',
                                  'cycle': '155次',
                                  'cap': '22V',
                                  'msg': '低价转售二手电池，详情电话谈'
                                },
                                {
                                  'name': '170181dcbf-ba51-4ef',
                                  'owner': 'David',
                                  'phone': '17526584125',
                                  'email': '95125@qq.com',
                                  'type': '银河星',
                                  'vol': '25V',
                                  'tem': '36℃',
                                  'cycle': '120次',
                                  'cap': '20V',
                                  'msg': '低价转售二手电池'
                                },
                                {
                                  'name': '170b9ae9e5-d543-4f2',
                                  'owner': '测试用户1',
                                  'phone': '1755442511',
                                  'email': 'test@qq.com',
                                  'type': '银河星',
                                  'vol': '36V',
                                  'tem': '36℃',
                                  'cycle': '225次',
                                  'cap': '22V',
                                  'msg': '出售银河星系列动力电池'
                                },
                                {
                                  'name': '17f8460f02-fd52-46b',
                                  'owner': 'Alice',
                                  'phone': '16852485214',
                                  'email': 'alice@qq.com',
                                  'type': '炫动科技',
                                  'vol': '35V',
                                  'tem': '37℃',
                                  'cycle': '155次',
                                  'cap': '22V',
                                  'msg': '低价转售二手电池，详情电话谈'
                                },
                              ]);
                            }));
                          }),
                    )),
                  ],
                ),
              ))
            ])));
  }

  _batterylistget() async {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: '加载中',
          );
        });
    Map<String, dynamic> param = {
      'id': User.userid2(),
      'type': User.type(),
    };
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post(
          'server/Everitoken/Info/possessBattery',
          data: param);
      if (response.data['code'] == 0){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BatterySelect(response.data['msg']);
        }));
      }
    } catch (e) {
      print(e.toString());
      showToast('网络错误，请稍后重试');
      Navigator.pop(context);
    }   
  }

  _requestcamera() async {
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler()
        .requestPermissions([PermissionGroup.camera]);
    if(permissions[PermissionGroup.camera] != PermissionStatus.granted)
      showToast("无相机权限");
    else
      Navigator.push(context, MaterialPageRoute(builder: (context) => QRScanView(0)));
  }
}

///选择电池界面（用于出售电池）
class BatterySelect extends StatefulWidget {
  final List _names;
  BatterySelect(this._names);
  @override
  State<StatefulWidget> createState() {
    return BatterySelectState(_names);
  }
}

class BatterySelectState extends State<BatterySelect> {
  final List _names;
  BatterySelectState(this._names);
  bool _start = false;

  @override
  Widget build(BuildContext context) {
    if (_names.length == 0)
      return Scaffold(
          backgroundColor: Color.fromARGB(255, 243, 247, 255),
          appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.keyboard_arrow_left),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: Text(
                '选择电池',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              backgroundColor: Color.fromARGB(255, 150, 140, 240)),
          body: Container(
              child: ListTile(
            title: Text('您还没有电池', style: TextStyle(color: Colors.black54)),
          )));
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 247, 255),
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(
              '选择电池',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            backgroundColor: Color.fromARGB(255, 150, 140, 240)),
        body: ListView.builder(
            itemCount: _names.length,
            itemBuilder: (context, index) {
              return Container(
                  decoration: BoxDecoration(color: Colors.white),
                  foregroundDecoration: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 1, color: Colors.black45),
                  ),
                  child: ListTile(
                      leading: Icon(Icons.battery_full,
                          color: Color.fromARGB(255, 150, 140, 240)),
                      title: Text(_names[index].toString()),
                      onTap: () {
                        _showDialog1(context, _names[index]);
                      }));
            }));
  }

  _showDialog1(context, String name) async {
    await dialog1(context, name);
    if (_start) {
      _batteryorderfindbyname2(name);
      _start = false;
    }
  }

  _showDialog2(context) async {
    await dialog2(context);
    if (_start) {
      _batteryorderfindbyname(context);
      _start = false;
    }
  }

  _batteryorderfindbyname(context) async {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: '加载中',
          );
        });
    Map<String, dynamic> param = {
      'id': User.userid(),
      'ID_code': 'aaa',
    };
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post(
          'server/Everitoken/transfer/sell/GetTransactionInfo',
          data: param);
      print(response.data);
      if (response.data['BatteryName'] != null) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BatterySell(
              response.data['ID_code'], response.data['BatteryName']);
        }));
      } 
      else{
        Navigator.pop(context);
        showToast('网络错误，请稍后重试');
      }
    } catch (e) {
      Navigator.pop(context);
      print(e);
      showToast('网络错误，请稍后重试');
    }
  }

  _batteryorderfindbyname2(String name) async {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: '加载中',
          );
        });
    Map<String, dynamic> param = {
      'id': User.userid(),
      'ID_code': 'aaa',
    };
    print(param);
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post(
          'server/Everitoken/transfer/sell/GetTransactionInfo',
          data: param);
      print(response.data);
      if (response.data['BatteryName'] != null){
        Navigator.pop(context);
        _showDialog2(context);
      }
      else{
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return NfcScan(name);
        }));
      }
    } catch (e) {
      print(e);
      Navigator.pop(context);
      showToast('网络错误，请稍后重试');
    }
  }

  Future<AlertDialog> dialog1(BuildContext context, String name) {
    return showDialog<AlertDialog>(
        context: context,
        builder: (context) => AlertDialog(
                title: Text("请求确认"),
                content: Text("即将出售电池" + name),
                actions: <Widget>[
                  GestureDetector(
                      child: Text('确认'),
                      onTap: () {
                        _start = true;
                        Navigator.pop(context);
                      }),
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: GestureDetector(
                          child: Text('取消'),
                          onTap: () {
                            Navigator.pop(context);
                          })),
                ]));
  }

  Future<AlertDialog> dialog2(BuildContext context) {
    return showDialog<AlertDialog>(
        context: context,
        builder: (context) => AlertDialog(
                title: Text("提示"),
                content: Text("您还有一笔交易未完成"),
                actions: <Widget>[
                  GestureDetector(
                      child: Text('前往查看'),
                      onTap: () {
                        _start = true;
                        Navigator.pop(context);
                      }),
                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: GestureDetector(
                          child: Text('确定'),
                          onTap: () {
                            Navigator.pop(context);
                          })),
                ]));
  }
}

///电池发行界面
class BatteryProduce extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BatteryProduceState();
  }
}

class BatteryProduceState extends State<BatteryProduce> {
  String _brand="--", _temperature = "--", _capacity = "--", _voltage = "--", _cycles = "--", _name = "--";
  bool _identied = false;

  @override
  initState() {
    super.initState();
    if (User.iscertificated())
      FlutterNfcReader.onTagDiscovered().listen((onData) {
        showToast("扫描成功");
        setState(() {
          _temperature = (Random().nextInt(20)+45).toString();
          _capacity = (Random().nextInt(40)+180).toString();
          _voltage = (Random().nextInt(2)*12+24).toString();
          _cycles = (Random().nextInt(200)).toString();
          _brand = "银河科技";
          _name = "银河一号电池";
          _identied = true;
        });
      });
  }

  @override
  dispose(){
    super.dispose();
    FlutterNfcReader.onTagDiscovered().listen((onData)=>{});
  }

  @override
  Widget build(BuildContext context) {
    if (!User.iscertificated())
      return Scaffold(
          backgroundColor: Color.fromARGB(255, 243, 247, 255),
          appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.keyboard_arrow_left),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: Text(
                '电池发行',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              backgroundColor: Color.fromARGB(255, 150, 140, 240)),
          body: Column(
            children: <Widget>[
              Container(
                  foregroundDecoration: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 1, color: Colors.black45),
                  ),
                  child: ListTile(
                    title: Text('当前企业未授权，暂时无法发行电池',
                        style: TextStyle(color: Colors.black54)),
                  )),
              Container(
                  foregroundDecoration: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 1, color: Colors.black45),
                  ),
                  decoration: BoxDecoration(color: Colors.white),
                  child: ListTile(
                    title: Text('点击前往授权'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.pushNamed(context, '/certification');
                    },
                  )),
            ],
          ));
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('Images/mainbgpic.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            icon:Icon(Icons.keyboard_arrow_left),
            color: Colors.white,
            onPressed: (){Navigator.pop(context);}
          ),
          backgroundColor: Colors.transparent,
          elevation: 0
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height*0.1),
            SizedBox(
              child: Center(
                child:Text(
                  "请开启手机NFC\n扫描电池感应区",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
              ),
              height: MediaQuery.of(context).size.height*0.1
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.2),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width*0.9,
                height: MediaQuery.of(context).size.height*0.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 0.5),
                  boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(5, 5),  blurRadius:5)]
                ),
                child: ListView(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  children: <Widget>[
                    _infotile("名称", _name),
                    _infotile("品牌", _brand),
                    _infotile("温度（℃）", _temperature),
                    _infotile("容量（mA·h）", _capacity),
                    _infotile("电压（V）", _voltage),
                    _infotile("循环充电次数（次）", _cycles),
                    SizedBox(height: 15),
                    _buttonlogin,
                    SizedBox(height: 15),
                  ],
                ),
              ), 
            ),
          ],
        ),
      ),
    );
  }

  Widget _infotile(String title, String content){
    return Container(
      foregroundDecoration: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 0.5, 
          color: Colors.black45
        ),
        insets: EdgeInsets.fromLTRB(10,0,10,0)
      ),
      decoration: BoxDecoration(color: Colors.white),
      child:ListTile(
        title: Text(
          title, 
          style: TextStyle(
            color:Colors.black54,
            fontSize: 12
          ),
        ),
        subtitle: Text(
          content, 
          style: TextStyle(
            color:Colors.black,
            fontSize: 18
          ),
        ),
      ),
    );
  }

  get _buttonlogin => Builder(
    builder: (BuildContext context){
      return Visibility(
        visible: _identied,
        child: Align(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            child: MaterialButton(
              height: 50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Text("确认",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w200,color: Colors.white)),
              color: Color.fromARGB(255, 150, 140, 240),
              onPressed: () {
                _batteryproduce();
              }
              ),
          ),
        )
      );
    }
  );

  _batteryproduce() async {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: '加载中',
          );
        });
    Map<String, dynamic> param = {
      'id': User.userid2(),
      'type': _brand,
      'batteryName': _name,
      'batteryMaxVoltage': _voltage,
      'batteryAverageTemperature': _temperature,
      'batteryChgCycles': _cycles,
      'batteryCapacity': _cycles,
    };
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post(
          'server/Everitoken/Manage/issueBattery',
          data: param);
      print(response.data);
      if (response.data['code'] == 0) {
        showToast('发行成功');
        Navigator.pop(context);
      } else
        showToast('网络错误，请稍后重试');
    } catch (e) {
      print(e.toString());
      showToast('网络错误，请稍后重试');
    }
    Navigator.pop(context);
  }
}

///发布广告界面
class BatteryAd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BatteryAdState();
  }
}

class BatteryAdState extends State<BatteryAd> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _controller1 = new TextEditingController();
  TextEditingController _controller2 = new TextEditingController();
  TextEditingController _controller3 = new TextEditingController();
  TextEditingController _controller4 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(
              '动态发表',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            backgroundColor: Color.fromARGB(255, 150, 140, 240)),
        body: Form(
            key: _formkey,
            child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 22.0),
                children: <Widget>[
                  textId(),
                  SizedBox(height: 20),
                  textMsg(),
                  SizedBox(height: 20),
                  textPhone(),
                  SizedBox(height: 20),
                  textEmail(),
                  SizedBox(height: 50),
                  buttonConfirm(),
                  SizedBox(height: 60),
                ])));
  }

  Widget textPhone() {
    return TextFormField(
        controller: _controller1,
        decoration: InputDecoration(labelText: '联系电话'),
        validator: (v) {
          RegExp _regExp = RegExp(
              r'^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$');
          if (!_regExp.hasMatch(v))
            return '请输入正确的手机号';
          else
            return null;
        });
  }

  Widget textMsg() {
    return TextFormField(
      controller: _controller4,
      decoration: InputDecoration(labelText: '卖家留言'),
    );
  }

  Widget textEmail() {
    return TextFormField(
        controller: _controller2,
        decoration: InputDecoration(labelText: '联系邮箱'),
        validator: (v) {
          RegExp _regExp =
              RegExp(r'^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$');
          if (!_regExp.hasMatch(v))
            return '请输入正确的邮箱';
          else
            return null;
        });
  }

  Widget textId() {
    return TextFormField(
        controller: _controller3,
        decoration: InputDecoration(labelText: '电池id'),
        validator: (v) {
          if (v.trim().length == 0)
            return '请输入电池id';
          else
            return null;
        });
  }

  Widget buttonConfirm() {
    return Builder(builder: (BuildContext context) {
      return Align(
          child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: MaterialButton(
            height: 50,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text("发表",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                    color: Colors.white)),
            color: Color.fromARGB(255, 150, 140, 240),
            onPressed: () {
              if (_formkey.currentState.validate()) {
                showToast('发布成功');
                Navigator.pop(context);
              }
            }),
      ));
    });
  }
}

///NFC扫描界面
class NfcScan extends StatefulWidget {
  final String _bid;
  NfcScan(this._bid);
  @override
  State<StatefulWidget> createState() {
    return NfcScanState(_bid);
  }
}

class NfcScanState extends State<NfcScan> {
  String _bid;
  NfcScanState(this._bid);
  String _brand="--", _temperature = "--", _capacity = "--", _voltage = "--", _cycles = "--";
  bool _identied = false;

  @override
  initState() {
    super.initState();
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      showToast("验证成功");
      setState(() {
        _temperature = (Random().nextInt(20)+45).toString();
        _capacity = (Random().nextInt(40)+180).toString();
        _voltage = (Random().nextInt(2)*12+24).toString();
        _cycles = (Random().nextInt(200)).toString();
        _brand = "银河科技";
        _identied = true;
      });
    });
  }
  
  @override
  dispose(){
    super.dispose();
    FlutterNfcReader.onTagDiscovered().listen((onData)=>{});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('Images/mainbgpic.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            icon:Icon(Icons.keyboard_arrow_left),
            color: Colors.white,
            onPressed: (){Navigator.pop(context);}
          ),
          backgroundColor: Colors.transparent,
          elevation: 0
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height*0.1),
            SizedBox(
              child: Center(
                child:Text(
                  "请开启手机NFC\n扫描电池感应区",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
              ),
              height: MediaQuery.of(context).size.height*0.1
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.2),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width*0.9,
                height: MediaQuery.of(context).size.height*0.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 0.5),
                  boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(5, 5),  blurRadius:5)]
                ),
                child: ListView(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  children: <Widget>[
                    _infotile("电池编号", _bid),
                    _infotile("品牌", _brand),
                    _infotile("温度（℃）", _temperature),
                    _infotile("容量（mA·h）", _capacity),
                    _infotile("电压（V）", _voltage),
                    _infotile("循环充电次数（次）", _cycles),
                    SizedBox(height: 15),
                    _buttonlogin,
                    SizedBox(height: 15),
                  ],
                ),
              ), 
            ),
          ],
        ),
      ),
    );
  }

  Widget _infotile(String title, String content){
    return Container(
      foregroundDecoration: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 0.5, 
          color: Colors.black45
        ),
        insets: EdgeInsets.fromLTRB(10,0,10,0)
      ),
      decoration: BoxDecoration(color: Colors.white),
      child:ListTile(
        title: Text(
          title, 
          style: TextStyle(
            color:Colors.black54,
            fontSize: 12
          ),
        ),
        subtitle: Text(
          content, 
          style: TextStyle(
            color:Colors.black,
            fontSize: 18
          ),
        ),
      ),
    );
  }

  get _buttonlogin => Builder(
    builder: (BuildContext context){
      return Visibility(
        visible: _identied,
        child: Align(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            child: MaterialButton(
              height: 50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Text("确认",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w200,color: Colors.white)),
              color: Color.fromARGB(255, 150, 140, 240),
              onPressed: () {
                _batteryorderstart(context);
              }
              ),
          ),
        )
      );
    }
  );

  _batteryorderstart(context) async {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: '加载中',
          );
        });
    String alphabet = 'qwertyuiopxcvbnm1234567890';
    Map<String, String> m = {
      '0': 'a',
      '1': 's',
      '2': 'd',
      '3': 'f',
      '4': 'g',
      '5': 'h',
      '6': 'j',
      '7': 'k',
      '8': 'l',
      '9': 'z',
    };
    int len = 8;
    String code = '';
    String id = User.userid().toString();
    for (int i = 0; i < id.length; i++) code += m[id[i]];
    for (var i = code.length; i < len; i++)
      code = code + alphabet[Random().nextInt(alphabet.length)];
    Map<String, dynamic> param = {
      'id': User.userid(),
      'ID_code': code,
      'BatteryName': _bid,
      'BatteryInfos': _temperature.toString() + "," + _capacity.toString() + "," + _voltage.toString() + "," + _brand + "," + _cycles.toString(),
    };
    try {
      print(param);
      Response response;
      Dio dio = new Dio();
      response = await dio.post(
          'server/Everitoken/transfer/sell/begin',
          data: param);
      print(response.data);
      if (response.data['code'] == 0) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BatterySell(code, _bid);
        }));
      } else{
        showToast('网络错误，请稍后重试');
        Navigator.pop(context);
      }
    } catch (e) {
      print(e.toString());
      showToast('网络错误，请稍后重试');
      Navigator.pop(context);
    }
  }
}

///二维码扫描界面
class QRScanView extends StatefulWidget {
  final int _type;
  QRScanView(this._type);
  
  @override
  State<StatefulWidget> createState() {
    return QRScanViewState(_type);
  }
}

class QRScanViewState extends State<QRScanView>{
  final int _type;
  QRScanViewState(this._type);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: QrcodeReaderView(key: qrViewKey, onScan: onScan),
    );

}

  GlobalKey<QrcodeReaderViewState> qrViewKey = GlobalKey();

  Future onScan(String data) async {
    if(_type == 0)
      await _batteryorderfind(data);
    else 
      await _batteryorderfind2(data);
  }

  _batteryorderfind(String code) async {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: '加载中',
          );
        });
    Map<String, String> x = {
      'a': '0',
      's': '1',
      'd': '2',
      'f': '3',
      'g': '4',
      'h': '5',
      'j': '6',
      'k': '7',
      'l': '8',
      'z': '9',
    };
    int i = 0;
    String idstring = '';
    if (x[code[0]] == null) idstring = '-1';
    while (x[code[i]] != null) {
      idstring += x[code[i]];
      i++;
    }
    Map<String, dynamic> param = {
      'id': int.parse(idstring),
      'ID_code': code,
    };
    print(param);
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post(
          'server/Everitoken/transfer/sell/GetTransactionInfo',
          data: param);
      print(response.data);
      if (response.data['BatteryName'] != null && response.data['confirm'] == 0) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BatteryPurchase(response.data['BatteryName'],
              response.data['Name'], code, idstring);
        }));
      }
      else{
        Navigator.pop(context);
        Navigator.pop(context);
        showToast('没有订单信息');
      }
    } catch (e) {
      print(e);
      showToast('网络错误，请稍后重试');
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  _batteryorderfind2(String code) async {
    showDialog<Null>(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new LoadingDialog(
        text: '加载中',
        );
      }
    );
    Map<String, String> x = {
      'a':'0',
      's':'1',
      'd':'2',
      'f':'3',
      'g':'4',
      'h':'5',
      'j':'6',
      'k':'7',
      'l':'8',
      'z':'9',
    };
    int i =0;
    String idstring='';
    if(x[code[0]]==null)
      idstring='-1';
    while(x[code[i]]!=null){
      idstring+=x[code[i]];
      i++;
    }
    Map<String, dynamic> param = {
      'id': int.parse(idstring),
      'ID_code': code,
    };
    print(param);
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post('server/Everitoken/transfer/sell/GetTransactionInfo', data: param);
      print(response.data);
      if(response.data['BatteryName']!=null) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BatteryDestroy(
              response.data['BatteryName'], response.data['Name'], code,idstring);
        }));
      }
      else{
        Navigator.pop(context);
        Navigator.pop(context);
        showToast('没有订单信息');
      }
    } catch (e) {
      print(e);
      showToast('网络错误，请稍后重试');
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }
}