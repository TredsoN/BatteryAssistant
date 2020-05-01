import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:batteryassistant/PageControllers/newspage.dart';
import 'package:batteryassistant/main.dart';
import 'package:batteryassistant/PageControllers/batterycontroller.dart';
import 'package:dio/dio.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage>  {
  @override
  Widget build(BuildContext context) {
    String _usertypestr='';
    switch(User.type()){
      case 0:_usertypestr='客户';break;
      case 1:_usertypestr='企业';break;
      case 2:_usertypestr='政府';break;
      case 3:_usertypestr='回收站';break;
    }
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Images/mainbgpic.png'),
              fit: BoxFit.cover,
            )),
        child:Scaffold(
            backgroundColor:Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Column(
              children: <Widget>[
                Image.asset('Images/title.png', height: MediaQuery.of(context).size.height*0.1),
                SizedBox(height: MediaQuery.of(context).size.height*0.05),
                Expanded(
                    child:Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(MediaQuery.of(context).size.width*0.05),
                                topRight: Radius.circular(MediaQuery.of(context).size.width*0.05)),
                            color: Colors.white),
                        child: ListView(
                          children: <Widget>[
                            SizedBox(height: 30),
                            adsTile(
                                'Images/news1.png',
                                '抱团才能追赶：欧洲九国将组建一家汽车电池巨头',
                                '这些欧洲国家和企业共同抱团创办汽车电池集团的目的，是希望形成合力，和亚洲主要的动力电池供应商进行竞争。',
                                article1
                            ),
                            adsTile(
                                'Images/news2.png',
                                '德国Duesenfeld公司：电池中96%的材料都可以回收利用',
                                '随着电动出行趋势日渐明显，一系列高性能电动汽车相继投放市场。现在，是时候考虑一下，当这些汽车发生事故或者报废时，应该怎样处理电池。',
                                article2
                            ),
                            adsTile(
                                'Images/news3.png',
                                '英国下一代储能电池研究获得了6800万美元的资助',
                                '一项5500万英镑(约合6780万美元)的基金已被指定用于英国的五个项目，研究开发下一代电池储能技术。',
                                article3
                            ),
                            adsTile(
                                'Images/news4.png',
                                '京师一号卫星成功发射，搭载比克电池18650-2.75Ah高能芯',
                                '9月12日，深圳——今日，京师一号卫星在太原卫星发射中心由神舟四号乙火箭发射成功并进入预定轨道，该卫星为全球变化科学实验卫星系统首发星，是我国第一颗专用于极地气候与环境监测的卫星。',
                                article4),
                            adsTile(
                                'Images/news5.jpg',
                                '提升电动车产能 戴姆勒向孚能采购电池',
                                '日前，戴姆勒集团对外宣布，公司已与孚能科技（Farasis Energy）达成协议，将向后者采购电动车所需的锂离子电池。',
                                article5),
                          ]))),
              ]
            ),
            drawer: Drawer(
              child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: -10,
                      left: 0,
                      height: MediaQuery.of(context).size.height*0.2,
                      width: MediaQuery.of(context).size.width*0.9,
                      child: Image.asset(
                        'Images/drawerbgpic.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(height: MediaQuery.of(context).size.height*0.2-65),
                        Align(
                            child:CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.white,
                                child:CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(User.online()?'Images/head.jpg':'Images/default.jpg'),
                                ))),
                        Center(
                          child: Text(User.online()?User.username():'未登录',style: TextStyle(fontSize: 19),),
                        ),
                        Center(
                          child: Text(_usertypestr,style: TextStyle(fontSize: 11,color: Colors.black45),),
                        ),
                        SizedBox(height: 20),
                        Offstage(
                            offstage: User.online(),
                            child:ListTile(
                                leading: Icon(
                                    Icons.add_circle,
                                    color: Color.fromARGB(255, 150, 140, 240)),
                                title: Text("点击登录", textAlign: TextAlign.left),
                                trailing: Icon(Icons.keyboard_arrow_right,),
                                onTap: () {
                                  _userloginandwait(context);
                                })), //点击登录
                        Offstage(
                            offstage: !User.online(),
                            child:ListTile(
                                leading: Icon(
                                    Icons.lock,
                                    color: Color.fromARGB(255, 150, 140, 240)),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                title: Text("账号安全", textAlign: TextAlign.left),
                                onTap: () {
                                  Navigator.pushNamed(context, '/safetypage');
                                })), //账号安全
                        Offstage(
                            offstage: !User.online(),
                            child:ListTile(
                                leading: Icon(
                                    Icons.account_circle,
                                    color: Color.fromARGB(255, 150, 140, 240)),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                title: Text("个人信息", textAlign: TextAlign.left),
                                onTap: () {
                                  Navigator.pushNamed(context, '/personalinfo');
                                })), //个人信息
                        Offstage(
                            offstage: !(User.online()&&User.type()==1),
                            child:ListTile(
                                leading: Icon(
                                    Icons.business_center,
                                    color: Color.fromARGB(255, 150, 140, 240)),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                title: Text("企业授权", textAlign: TextAlign.left),
                                onTap: () {
                                  _getuserauthorize();
                                })), //企业授权
                        Offstage(
                            offstage: !(User.online()&&(User.type()==0||User.type()==1)),
                            child:ListTile(
                                leading: Icon(
                                    Icons.offline_bolt,
                                    color: Color.fromARGB(255, 150, 140, 240)),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                title: Text("我的电池", textAlign: TextAlign.left),
                                onTap: () {
                                  _batterylistget(context);
                                })), //我的电池
                        Offstage(
                            offstage: !(User.online()&&User.type()==0),
                            child:ListTile(
                                leading: Icon(
                                    Icons.swap_vertical_circle,
                                    color: Color.fromARGB(255, 150, 140, 240)),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                title: Text("电池交易", textAlign: TextAlign.left),
                                onTap: () {
                                  Navigator.pushNamed(context,'/trade');
                                })), //电池交易
                        Offstage(
                            offstage: !(User.online()&&User.type()==1),
                            child:ListTile(
                                leading: Icon(
                                    Icons.swap_vertical_circle,
                                    color: Color.fromARGB(255, 150, 140, 240)),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                title: Text("电池管理", textAlign: TextAlign.left),
                                onTap: () {
                                  Navigator.pushNamed(context,'/manage');
                                })), //电池管理
                        Offstage(
                            offstage: !(User.online()&&User.type()==2),
                            child:ListTile(
                                leading: Icon(
                                    Icons.assignment,
                                    color: Color.fromARGB(255, 150, 140, 240)),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                title: Text("授权审核", textAlign: TextAlign.left),
                                onTap: () {
                                  Navigator.pushNamed(context, '/auditpage');
                                })), //授权审核
                        Offstage(
                            offstage: !(User.online()&&User.type()==3),
                            child:ListTile(
                                leading: Icon(
                                    Icons.autorenew,
                                    color: Color.fromARGB(255, 150, 140, 240)),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                title: Text("电池回收", textAlign: TextAlign.left),
                                onTap: () {
                                  _requestcamera();
                                })), //电池回收
                        Offstage(
                            offstage: !User.online(),
                            child:ListTile(
                                leading: Icon(
                                    Icons.exit_to_app,
                                    color: Color.fromARGB(255, 150, 140, 240)),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                title: Text("退出登录", textAlign: TextAlign.left),
                                onTap: () {
                                  setState(() {
                                    User.resetuser(-1,-1,-1, '','', '', '','', false,'');
                                  });
                                })),
                      ]),
                ]
              ),
                )));
  }

  Widget adsTile(String image, String title, String subtitle, String content){
    return GestureDetector(
        child: Container(
            child: Column(children: <Widget>[
              Center(
                  child:Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image:DecorationImage(
                            image: AssetImage(image),
                            fit: BoxFit.fill)),
                    height: MediaQuery.of(context).size.width*0.55,
                    width: MediaQuery.of(context).size.width*0.9,
                  )),
              SizedBox(height: 20),
              Container(
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child:Text(title, style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600))),
                width: MediaQuery.of(context).size.width*0.9,),
              SizedBox(height: 10),
              Container(
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child:Text(subtitle, style: TextStyle(color: Colors.black38,fontSize: 12,fontWeight: FontWeight.w600))),
                width: MediaQuery.of(context).size.width*0.9,),
              SizedBox(height: 20),
              Container(
                  decoration: UnderlineTabIndicator(
                      borderSide: BorderSide(width: 0.5, color: Colors.black45),
                      insets: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05,0,MediaQuery.of(context).size.width*0.05,0)
                  )),
              SizedBox(height: 30)
            ],)
        ),
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder:(context){return NewsPage(title,content,image);}));
        });
  }

  _userloginandwait(context) async{
    await Navigator.pushNamed(context,'/loginpage');
    setState((){});
  }

  _batterylistget(context) async {
    showDialog<Null>(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new LoadingDialog(
        text: '加载中',
        );
      }
    );
    Map<String, dynamic> param = {
      'id': User.userid2(),
      'type': User.type(),
    };
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post('server/Everitoken/Info/possessBattery', data: param);
      print(response.data['msg']);
      Navigator.pop(context);
      Navigator.push(context,MaterialPageRoute(builder:(context){return BatteryInfoSelect(response.data['msg']);}));
    } catch (e) {
      print(e.toString());
      showToast('网络错误，请稍后重试');
      Navigator.pop(context);
    }  
  }

  _getuserauthorize() async{
    showDialog<Null>(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new LoadingDialog(
        text: '加载中',
        );
      }
    );
    try {
      Map<String,dynamic> param = {
        'id':User.userid2(),
        'type':User.type(),
      };
      Response response;
      Dio dio = new Dio();
      response = await dio.post('server/Everitoken/Info/BasicInfo',data:param);
      print(response);
      if(response.data['producer_authorized']==1)
        User.resetcertificate(true);
      else
        User.resetcertificate(false);
    } catch (e) {
      print(e);
    }
    Navigator.pop(context);
    Navigator.pushNamed(context, '/certification');
  }

  _requestcamera() async {
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler()
        .requestPermissions([PermissionGroup.camera]);
    if(permissions[PermissionGroup.camera] != PermissionStatus.granted)
      showToast("无相机权限");
    else
      Navigator.push(context, MaterialPageRoute(builder: (context) => QRScanView(1)));
  }
}