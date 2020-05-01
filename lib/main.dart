import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:batteryassistant/PageControllers/certificationcontroller.dart';
import 'package:batteryassistant/PageControllers/usercontroller.dart';
import 'package:batteryassistant/PageControllers/mainpage.dart';
import 'package:batteryassistant/PageControllers/batterycontroller.dart';

void main() => runApp(MyApp());

String head1 = 'http://b-ssl.duitang.com/uploads/item/201810/18/20181018162951_kgwzm.thumb.700_0.jpeg';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MaterialApp(
            initialRoute: '/',
            routes: {
              '/':(context) => MainPage(),
              '/loginpage':(context)=>LoginPage(),
              '/loginpage_customer':(context)=>LoginPageDetail(0),
              '/loginpage_producer':(context)=>LoginPageDetail(1),
              '/loginpage_government':(context)=>LoginPageDetail(2),
              '/loginpage_bin':(context)=>LoginPageDetail(3),
              '/registerpage_customer':(context)=>RegisterPageCustomer(),
              '/registerpage_producer':(context)=>RegisterPageProducer(),
              '/registerpage_government':(context)=>RegisterPageGovernment(),
              '/registerpage_bin':(context)=>RegisterPageBin(),
              '/personalinfo':(context)=>PersonalInfo(),
              '/trade':(context)=>BatteryTrade(),
              '/manage':(context)=>BatteryManage(),
              '/safetypage':(context)=>SafetyPage(),
              '/changepswdpage':(context)=>ChangePswdPage(),
              '/batteryproduce':(context)=>BatteryProduce(),
              '/certification':(context)=>CertificationState(),
              '/certificationapply':(context)=>CertificationApply(),
              '/auditpage':(context)=>AuditPage(),
              '/advertise':(context)=>BatteryAd(),
            },
            title: '电池助手',
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
            )));
  }
}

class User {
  static int _type =-1;
  static String _username = '';
  static String _name = '';
  static String _gender = '';
  static String _email = '';
  static String _idnum = '';
  static String _phone='';
  static int _userid = -1;
  static int _userid2 = -1;
  static bool _iscertificated = false;
  static bool _online = false;

  static void resetuser(int uid, int uid2, int t, String un, String n, String g, String e, String i, bool o,String p) {
    _userid = uid;
    _userid2 = uid2;
    _type = t;
    _username = un;
    _name = n;
    _gender = g;
    _email = e;
    _idnum = i;
    _online = o;
    _phone=p;
  }

  static void resetphone(String p){
    _phone=p;
  }

  static void resetemail(String e){
    _email=e;
  }

  static void resetcertificate(bool certificate){
    _iscertificated = certificate;
  }

  static int type(){
    return _type;
  }

  static String username() {
    return _username;
  }

  static String name() {
    return _name;
  }

  static String gender() {
    return _gender;
  }

  static String email() {
    return _email;
  }

  static String phone() {
    return _phone;
  }

  static String idnum(){
    return _idnum;
  }

  static int userid(){
    return _userid;
  }

  static int userid2(){
    return _userid2;
  }

  static bool online() {
    return _online;
  }

  static bool iscertificated() {
    return _iscertificated;
  }
}

class LoadingDialog extends Dialog {
  final String text;

  LoadingDialog({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Material(
      type: MaterialType.transparency, 
      child: new Center(
        child: new SizedBox(
          width: 120.0,
          height: 120.0,
          child: new Container(
            decoration: ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new CircularProgressIndicator(),
                new Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: new Text(
                    text,
                    style: new TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}