import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:batteryassistant/main.dart';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';

///登陆导航界面（至不同用户登录界面）
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Images/mainbgpic.png'),
            fit: BoxFit.cover,
          )),
      child: Scaffold(
          backgroundColor:Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
                icon:Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                onPressed: (){Navigator.pop(context);}),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: ListView(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height*0.1),
                Center(child: Image.asset('Images/title.png', height: MediaQuery.of(context).size.height*0.1)),
                SizedBox(height: MediaQuery.of(context).size.height*0.3),
                Align(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: MaterialButton(
                          height: 50,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Text("客户登录",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w200)),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context,'/loginpage_customer');
                          }),
                    )),
                SizedBox(height: MediaQuery.of(context).size.height*0.02),
                Align(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: MaterialButton(
                          height: 50,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Text("企业登录",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w200)),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context,'/loginpage_producer');
                          }),
                    )),
                SizedBox(height: MediaQuery.of(context).size.height*0.02),
                Align(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: MaterialButton(
                          height: 50,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Text("政府登录",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w200)),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context,'/loginpage_government');
                          }),
                    )),
                SizedBox(height: MediaQuery.of(context).size.height*0.02),
                Align(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: MaterialButton(
                          height: 50,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Text("回收站登录",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w200)),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context,'/loginpage_bin');
                          }),
                    )),
              ])
      ));
  }
}

///账号安全界面（至修改密码）
class SafetyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 247, 255),
        appBar: AppBar(
            leading: IconButton(
                icon:Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                onPressed: (){Navigator.pop(context);}),
            title: Text('账号安全', style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.w500),),
            backgroundColor: Color.fromARGB(255, 150, 140, 240)),
        body: ListView(
          children: <Widget>[
            Container(
                height: 50,
                decoration: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 1, color: Colors.black45),
                )),
            Container(
                foregroundDecoration: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 1, color: Colors.black45),
                ),
                decoration: BoxDecoration(color: Colors.white),
                child:ListTile(
                  title: Text('修改密码'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: (){
                    Navigator.pushNamed(context, '/changepswdpage');
                  },
                )),
          ],
        )
    );
  }
}

///登录界面
class LoginPageDetail extends StatefulWidget {
  final int _type;
  LoginPageDetail(this._type);
  @override
  State<StatefulWidget> createState() {
    return LoginPageDetailState(_type);
  }
}

class LoginPageDetailState extends State<LoginPageDetail> {
  int _type;
  LoginPageDetailState(this._type);
  final _formkey = GlobalKey<FormState>();
  String _username, _password;
  bool _showpswd = true, _success = false;
  Color _eyecolor = Colors.grey;
  String _usertype = '';

  @override
  Widget build(BuildContext context) {
    if(_type==0) _usertype='客户';
    else if(_type==1) _usertype='企业';
    else if(_type==2) _usertype='政府';
    else _usertype='回收站';
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Images/mainbgpic.png'),
            fit: BoxFit.cover,
          )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              leading: IconButton(
                  icon:Icon(Icons.keyboard_arrow_left),
                  color: Colors.white,
                  onPressed: (){Navigator.pop(context);}),
              backgroundColor: Colors.transparent,
              elevation: 0),
          body: Form(
              key: _formkey,
              child: ListView(
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height*0.1),
                    Center(child: Image.asset('Images/title.png', height: MediaQuery.of(context).size.height*0.1)),
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
                              SizedBox(height: MediaQuery.of(context).size.height*0.03),
                              Align(alignment:Alignment.bottomLeft,child: Text(_usertype+'登录',style: TextStyle(fontSize: 20))),
                              SizedBox(height: MediaQuery.of(context).size.height*0.01),
                              textUsername(),
                              textPassword(),
                              SizedBox(height: MediaQuery.of(context).size.height*0.03),
                              buttonLogin(),
                              SizedBox(height: MediaQuery.of(context).size.height*0.01),
                              buttonRegister(),
                              SizedBox(height: MediaQuery.of(context).size.height*0.03),
                            ],),
                        ), )
                  ]))),
    );
  }

  Widget textUsername() {
    return TextFormField(
        onSaved: (v) => _username = v,
        decoration: InputDecoration(labelText:'用户名'),
        validator: (v) {
          if (v.trim().length == 0)
            return '请输入用户名';
          else
            return null;
        });
  }

  Widget textPassword() {
    return TextFormField(
        onSaved: (v) => _password = v,
        obscureText: _showpswd,
        decoration: InputDecoration(
            labelText: '密码',
            suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _eyecolor,
              ),
              onPressed: () {
                setState(() {
                  _showpswd = !_showpswd;
                  _eyecolor = _showpswd ? Colors.grey : Color.fromARGB(255, 150, 140, 240);
                });
              },
            )),
        validator: (v) {
          if (v.trim().length == 0)
            return '请输入密码';
          else if (v.trim().length < 8)
            return '密码不能少于8位';
          else if (v.trim().length > 24)
            return '密码不能超过24位';
          else
            return null;
        });
  }

  Widget buttonLogin() {
    return Builder(builder: (BuildContext context){
      return Align(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            child: MaterialButton(
                height: 50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Text("登录",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w200,color: Colors.white)),
                color: Color.fromARGB(255, 150, 140, 240),
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    _formkey.currentState.save();
                    if(_type==0) _username=_username+'_customer';
                    else if(_type==1) _username=_username+'_producer';
                    else if(_type==2) _username=_username+'_government';
                    else _username=_username+'_bin';
                    Map<String, dynamic> param = {
                      'username': _username,
                      'password': _password,
                    };
                    _userlogin(param);
                  }
                }),
          ));
    });
  }

  Widget buttonRegister() {
    return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('没有账号？'),
                  GestureDetector(
                      child: Text(
                        '点击注册',
                        style: TextStyle(color: Color.fromARGB(255, 150, 140, 240)),
                      ),
                      onTap: () {
                        if(_type==0) Navigator.pushNamed(context, '/registerpage_customer');
                        else if(_type==1) Navigator.pushNamed(context, '/registerpage_producer');
                        else if(_type==2) Navigator.pushNamed(context, '/registerpage_government');
                        else Navigator.pushNamed(context, '/registerpage_bin');
                      })
                ])));
  }

  _userlogin(Map<String, dynamic> param) async {
    showDialog<Null>(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new LoadingDialog(
        text: '登录中',
        );
      }
    );
    try {
      Response response;
      Dio dio = new Dio();
      dio.interceptors.add(CookieManager(CookieJar()));
      response = await dio.post('server/Everitoken/user/login', data: param);
      switch(response.data['code']){
        case 0:
          await _getuserinfo();
          break;
        case 20004:
          showToast('用户名或密码错误');
          break;
        case 20005:
          showToast('用户不存在');
          break;
      }
    } catch (e) {
      print(e.toString());
      showToast('网络错误，请稍后重试');
    }
    if(_success)
      Navigator.popUntil(context, ModalRoute.withName('/'));
    else
      Navigator.pop(context);
  }

  _getuserinfo() async{
    try {
      Response response;
      Dio dio = new Dio();
      dio.interceptors.add(CookieManager(CookieJar()));
      response = await dio.post('server/Everitoken/user/getUserInfo');
      print(response.data);
      if(response.data['code']==0){
        switch(response.data['data']['type']){
          case 0:
            User.resetuser(
                response.data['data']['uid'],
                response.data['data']['info_id'],
                _type,
                response.data['data']['username'].toString().substring(0,response.data['data']['username'].toString().length-9),
                response.data['data']['name'],
                response.data['data']['sex']==0?'男':'女',
                response.data['data']['email'],
                response.data['data']['id_number'],
                true,
                response.data['data']['phone']);
            break;
          case 1:
            User.resetuser(
                response.data['data']['uid'],
                response.data['data']['info_id'],
                _type,
                response.data['data']['username'].toString().substring(0,response.data['data']['username'].toString().length-9),
                response.data['data']['producer_name'],
                '',
                response.data['data']['email'],
                response.data['data']['producer_CHNCode'],
                true,
                '');
            break;
          case 2:
            User.resetuser(
                response.data['data']['uid'],
                response.data['data']['info_id'],
                _type,
                response.data['data']['username'].toString().substring(0,response.data['data']['username'].toString().length-11),
                response.data['data']['government_name'],
                '',
                response.data['data']['email'],
                response.data['data']['government_CHNCode'],
                true,
                '');
            break;
          case 3:
            User.resetuser(
                response.data['data']['uid'],
                response.data['data']['info_id'],
                _type,
                response.data['data']['username'].toString().substring(0,response.data['data']['username'].toString().length-4),
                response.data['data']['rs_name'],
                '',
                response.data['data']['email'],
                '',
                true,
                '');
            break;
        }
        _success = true;
      }
    } catch (e) {
      print(e);
      showToast('网络错误，请稍后重试');
    }
  }
}

///客户注册界面
class RegisterPageCustomer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterPageCustomerState();
  }
}

class RegisterPageCustomerState extends State<RegisterPageCustomer> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _controller1 = new TextEditingController();
  TextEditingController _controller2 = new TextEditingController();
  TextEditingController _controller3 = new TextEditingController();
  TextEditingController _controller4 = new TextEditingController();
  TextEditingController _controller5 = new TextEditingController();
  TextEditingController _controller6 = new TextEditingController();
  TextEditingController _controller7 = new TextEditingController();
  String _password, _idnum, _name,_email, _username, _phone, _gender='男';
  bool _success = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon:Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                onPressed: (){Navigator.pop(context);}),
            title: Text('客户注册', style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.w500),),
            backgroundColor: Color.fromARGB(255, 150, 140, 240)),
        body: Form(
            key: _formkey,
            child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 22.0),
                children: <Widget>[
                  textUsername(),
                  SizedBox(height: 20),
                  textPassword(),
                  SizedBox(height: 20),
                  textPassword2(),
                  SizedBox(height: 20),
                  textName(),
                  SizedBox(height: 20),
                  radioGender(),
                  textIdnumber(),
                  SizedBox(height: 20),
                  textPhone(),
                  SizedBox(height: 20),
                  textEmail(),
                  SizedBox(height: 50),
                  buttonConfirm(),
                  SizedBox(height: 60),
                ])));
  }

  Widget textPassword() {
    return TextFormField(
        obscureText: true,
        controller: _controller1,
        onSaved: (v) => _password = v,
        decoration: InputDecoration(labelText: '设置密码'),
        validator: (v) {
          _formkey.currentState.save();
          RegExp _regExp=RegExp(r'^[ZA-ZZa-z0-9_]+$');
          if (v.trim().length == 0)
            return '请输入密码';
          else if(_regExp.firstMatch(v)==null)
            return '密码不能包含特殊字符';
          else if (v.trim().length < 8)
            return '密码不能少于8位';
          else if (v.trim().length > 24)
            return '密码不能超过24位';
          else
            return null;
        });
  }

  Widget textPassword2() {
    return TextFormField(
        obscureText: true,
        controller: _controller2,
        decoration: InputDecoration(
          labelText: '确认密码',
        ),
        validator: (v) {
          _formkey.currentState.save();
          if (v.trim().length == 0)
            return '请再次输入密码';
          else if (v != _password)
            return '两次输入密码不一致';
          else
            return null;
        });
  }

  Widget textUsername() {
    return TextFormField(
        controller: _controller3,
        onSaved: (v) => _username = v.trim(),
        decoration: InputDecoration(labelText: '设置用户名'),
        validator: (v) {
          if (v.trim().length == 0)
            return '请输入用户名';
          else if(v.trim().length >12)
            return '用户名不能超过12位';
          else
            return null;
        });
  }

  Widget textName() {
    return TextFormField(
        controller: _controller4,
        onSaved: (v) => _name = v.trim(),
        decoration: InputDecoration(labelText: '输入姓名'),
        validator: (v) {
          if (v.trim().length == 0)
            return '请输入姓名';
          else
            return null;
        });
  }

  Widget textIdnumber() {
    return TextFormField(
        controller: _controller5,
        onSaved: (v) => _idnum = v,
        decoration: InputDecoration(labelText: '输入身份证号'),
        validator: (v) {
          if (v.trim().length != 18)
            return '请输入正确的身份证号';
          else
            return null;
        });
  }

  Widget textPhone() {
    return TextFormField(
        controller: _controller6,
        onSaved: (v) => _phone = v,
        decoration: InputDecoration(labelText: '输入手机号'),
        validator: (v) {
          RegExp _regExp=RegExp(r'^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$');
          if (!_regExp.hasMatch(v))
            return '请输入正确的手机号';
          else
            return null;
        });
  }

  Widget textEmail() {
    return TextFormField(
        controller: _controller7,
        onSaved: (v) => _email = v,
        decoration: InputDecoration(labelText: '输入邮箱'),
        validator: (v) {
          RegExp _regExp=RegExp(r'^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$');
          if (!_regExp.hasMatch(v))
            return '请输入正确的邮箱';
          else
            return null;
        });
  }

  Widget radioGender(){
    return Column(children:<Widget>[
      Align(alignment:Alignment.bottomLeft,child:Text('选择性别',style: TextStyle(color:Colors.black54,fontSize: 12))),
      RadioListTile<String>(
          selected: true,
          value: '男',
          groupValue: _gender,
          activeColor: Color.fromARGB(255, 150, 140, 240),
          title: Text('男',style: TextStyle(color: Colors.black)),
          onChanged: (value){
            setState(() {
              _gender=value;});}),
      RadioListTile<String>(
          value: '女',
          groupValue: _gender,
          activeColor: Color.fromARGB(255, 150, 140, 240),
          title: Text('女',style: TextStyle(color: Colors.black)),
          onChanged: (value){
            setState(() {
              _gender=value;});})]);
  }

  Widget buttonConfirm() {
    return Builder(builder: (BuildContext context){
      return Align(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            child: MaterialButton(
                height: 50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Text("注册",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w200,color: Colors.white)),
                color: Color.fromARGB(255, 150, 140, 240),
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    _formkey.currentState.save();
                    Map<String, dynamic> param = {
                      'username': _username+'_customer',
                      'password': _password,
                      'name':_name,
                      'email':_email,
                      'phone':_phone,
                      'sex':_gender=='男'?0:1,
                      'idnumber':_idnum
                    };
                    _customerregister(param);
                  }
                }),
          ));
    });
  }
  
  _customerregister(Map<String, dynamic> param) async{
    showDialog<Null>(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new LoadingDialog(
        text: '注册中',
        );
      }
    );
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post('server/Everitoken/user/customer/register', data: param);
      print(response);
      if(response.data['code']==0){
          showToast('注册成功');
          Map<String, dynamic> param = {
            'username': _username+'_customer',
            'password': _password,
          };
          await _userlogin(param);
      }
      else if(response.data['code']==20006)
        showToast('用户名已存在');
      else
        showToast('网络错误，请稍后重试');
    }
    catch (e) {
      print(e);
      showToast('网络错误，请稍后重试');
    }
    if(_success)
      Navigator.popUntil(context, ModalRoute.withName('/'));
    else
      Navigator.pop(context);
  }

  _userlogin(Map<String, dynamic> param) async {
    try {
      Response response;
      Dio dio = new Dio();
      dio.interceptors.add(CookieManager(CookieJar()));
      response = await dio.post('server/Everitoken/user/login', data: param);
      print(response);
      switch(response.data['code']){
        case 0:
          await _getuserinfo();
          break;
        case 20004:showToast('用户名或密码错误');break;
        case 20005:showToast('用户不存在');break;
      }
    } catch (e) {
      print(e.toString());
      showToast('网络错误，请稍后重试');
    }
  }

  _getuserinfo() async{
    try {
      Response response;
      Dio dio = new Dio();
      dio.interceptors.add(CookieManager(CookieJar()));
      response = await dio.post('server/Everitoken/user/getUserInfo');
      print(response);
      if(response.data['code']==0){
        User.resetuser(
            response.data['data']['uid'],
            response.data['data']['info_id'],
            0,
            response.data['data']['username'].toString().substring(0,response.data['data']['username'].toString().length-9),
            response.data['data']['name'],
            response.data['data']['sex']==0?'男':'女',
            response.data['data']['email'],
            response.data['data']['id_number'],
            true,
            response.data['data']['phone']);
        _success = true;
      }
    } catch (e) {
      print(e);
      showToast('网络错误，请稍后重试');
    }
  }
}

///企业注册界面
class RegisterPageProducer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterPageProducerState();
  }
}

class RegisterPageProducerState extends State<RegisterPageProducer> {
  final _formkey = GlobalKey<FormState>();
  String _password, _name, _email,_code,_username;
  TextEditingController _controller1 = new TextEditingController();
  TextEditingController _controller2 = new TextEditingController();
  TextEditingController _controller3 = new TextEditingController();
  TextEditingController _controller4 = new TextEditingController();
  TextEditingController _controller5 = new TextEditingController();
  TextEditingController _controller6 = new TextEditingController();
  bool _success = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon:Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                onPressed: (){Navigator.pop(context);}),
            title: Text('企业注册', style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.w500),),
            backgroundColor: Color.fromARGB(255, 150, 140, 240)),
        body: Form(
            key: _formkey,
            child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 22.0),
                children: <Widget>[
                  textUsername(),
                  SizedBox(height: 20),
                  textPassword(),
                  SizedBox(height: 20),
                  textPassword2(),
                  SizedBox(height: 20),
                  textName(),
                  SizedBox(height: 20),
                  textCode(),
                  SizedBox(height: 20),
                  textEmail(),
                  SizedBox(height: 50),
                  buttonConfirm(),
                  SizedBox(height: 60),
                ])));
  }

  Widget textUsername() {
    return TextFormField(
        controller: _controller1,
        onSaved: (v) => _username = v.trim(),
        decoration: InputDecoration(labelText: '设置用户名'),
        validator: (v) {
          if (v.trim().length == 0)
            return '请输入用户名';
          else if(v.trim().length >12)
            return '用户名不能超过12位';
          else
            return null;
        });
  }

  Widget textPassword() {
    return TextFormField(
        controller: _controller2,
        obscureText: true,
        onSaved: (v) => _password = v,
        decoration: InputDecoration(labelText: '设置密码'),
        validator: (v) {
          _formkey.currentState.save();
          RegExp _regExp=RegExp(r'^[ZA-ZZa-z0-9_]+$');
          if (v.trim().length == 0)
            return '请输入密码';
          else if(_regExp.firstMatch(v)==null)
            return '密码不能包含特殊字符';
          else if (v.trim().length < 8)
            return '密码不能少于8位';
          else if (v.trim().length > 24)
            return '密码不能超过24位';
          else
            return null;
        });
  }

  Widget textPassword2() {
    return TextFormField(
        controller: _controller3,
        obscureText: true,
        decoration: InputDecoration(
          labelText: '确认密码',
        ),
        validator: (v) {
          if (v.trim().length == 0)
            return '请再次输入密码';
          else if (v != _password)
            return '两次输入密码不一致';
          else
            return null;
        });
  }

  Widget textCode() {
    return TextFormField(
        controller: _controller4,
        onSaved: (v) => _code = v.trim(),
        decoration: InputDecoration(labelText: '输入企业代码'),
        validator: (v) {
          if (v.trim().length == 0)
            return '请输入企业代码';
          else
            return null;
        });
  }

  Widget textName() {
    return TextFormField(
        controller: _controller5,
        onSaved: (v) => _name = v.trim(),
        decoration: InputDecoration(labelText: '输入企业名'),
        validator: (v) {
          if (v.trim().length == 0)
            return '请输入企业名';
          else
            return null;
        });
  }

  Widget textEmail() {
    return TextFormField(
        controller: _controller6,
        onSaved: (v) => _email = v,
        decoration: InputDecoration(labelText: '输入企业邮箱'),
        validator: (v) {
          RegExp _regExp=RegExp(r'^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$');
          if (!_regExp.hasMatch(v))
            return '请输入正确的邮箱';
          else
            return null;
        });
  }

  Widget buttonConfirm() {
    return Builder(builder: (BuildContext context){
      return Align(
        child: SizedBox(
          width: MediaQuery.of(context).size.width*0.9,
          child: MaterialButton(
              height: 50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Text("注册",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w200,color: Colors.white)),
              color: Color.fromARGB(255, 150, 140, 240),
              onPressed: () {
                if (_formkey.currentState.validate()) {
                  _formkey.currentState.save();
                  Map<String, dynamic> param = {
                    'username': _username+'_producer',
                    'password': _password,
                    'producer_name':_name,
                    'email':_email,
                    'producer_CHNCode':_code
                  };
                  _producerregister(param);
                }
              }),
        ));
    });
  }

  _producerregister(Map<String, dynamic> param) async{
    showDialog<Null>(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new LoadingDialog(
        text: '注册中',
        );
      }
    );
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post('server/Everitoken/user/producer/register', data: param);
      if(response.data['code']==0){
        showToast('注册成功');
        Map<String, dynamic> param = {
          'username': _username+'_producer',
          'password': _password,
        };
        await _userlogin(param);
      }
      else if(response.data['code']==20006)
        showToast('用户名已存在');
      else
        showToast('网络错误，请稍后重试');
    } catch (e) {
      print(e);
      showToast('网络错误，请稍后重试');
    }
    if(_success)
      Navigator.popUntil(context, ModalRoute.withName('/'));
    else
      Navigator.pop(context);
  }

  _userlogin(Map<String, dynamic> param) async {
    try {
      Response response;
      Dio dio = new Dio();
      dio.interceptors.add(CookieManager(CookieJar()));
      response = await dio.post('server/Everitoken/user/login', data: param);
      switch(response.data['code']){
        case 0:
          await _getuserinfo();
          break;
        case 20004:showToast('用户名或密码错误');break;
        case 20005:showToast('用户不存在');break;
      }
    } catch (e) {
      print(e.toString());
      showToast('网络错误，请稍后重试');
    }
  }

  _getuserinfo() async{
    try {
      Response response;
      Dio dio = new Dio();
      dio.interceptors.add(CookieManager(CookieJar()));
      response = await dio.post('server/Everitoken/user/getUserInfo');
      if(response.data['code']==0){
        User.resetuser(
            response.data['data']['uid'],
            response.data['data']['info_id'],
            1,
            response.data['data']['username'].toString().substring(0,response.data['data']['username'].toString().length-9),
            response.data['data']['producer_name'],
            '',
            response.data['data']['email'],
            response.data['data']['producer_CHNCode'],
            true,
            '');
        _success = true;
      }
      
    } catch (e) {
      print(e);
      showToast('网络错误，请稍后重试');
    }
  }
}

///政府注册界面
class RegisterPageGovernment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterPageGovernmentState();
  }
}

class RegisterPageGovernmentState extends State<RegisterPageGovernment> {
  final _formkey = GlobalKey<FormState>();
  String _password, _name, _email,_code,_username;
  TextEditingController _controller1 = new TextEditingController();
  TextEditingController _controller2 = new TextEditingController();
  TextEditingController _controller3 = new TextEditingController();
  TextEditingController _controller4 = new TextEditingController();
  TextEditingController _controller5 = new TextEditingController();
  TextEditingController _controller6 = new TextEditingController();
  bool _success = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon:Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                onPressed: (){Navigator.pop(context);}),
            title: Text('政府注册', style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.w500),),
            backgroundColor: Color.fromARGB(255, 150, 140, 240)),
        body: Form(
            key: _formkey,
            child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 22.0),
                children: <Widget>[
                  textUsername(),
                  SizedBox(height: 20),
                  textPassword(),
                  SizedBox(height: 20),
                  textPassword2(),
                  SizedBox(height: 20),
                  textName(),
                  SizedBox(height: 20),
                  textCode(),
                  SizedBox(height: 20),
                  textEmail(),
                  SizedBox(height: 50),
                  buttonConfirm(),
                  SizedBox(height: 60),
                ])));
  }

  Widget textUsername() {
    return TextFormField(
        controller: _controller1,
        onSaved: (v) => _username = v.trim(),
        decoration: InputDecoration(labelText: '设置用户名'),
        validator: (v) {
          if (v.trim().length == 0)
            return '请输入用户名';
          else if(v.trim().length >12)
            return '用户名不能超过12位';
          else
            return null;
        });
  }

  Widget textPassword() {
    return TextFormField(
        controller: _controller2,
        obscureText: true,
        onSaved: (v) => _password = v,
        decoration: InputDecoration(labelText: '设置密码'),
        validator: (v) {
          _formkey.currentState.save();
          RegExp _regExp=RegExp(r'^[ZA-ZZa-z0-9_]+$');
          if (v.trim().length == 0)
            return '请输入密码';
          else if(_regExp.firstMatch(v)==null)
            return '密码不能包含特殊字符';
          else if (v.trim().length < 8)
            return '密码不能少于8位';
          else if (v.trim().length > 24)
            return '密码不能超过24位';
          else
            return null;
        });
  }

  Widget textPassword2() {
    return TextFormField(
        controller: _controller3,
        obscureText: true,
        decoration: InputDecoration(
          labelText: '确认密码',
        ),
        validator: (v) {
          if (v.trim().length == 0)
            return '请再次输入密码';
          else if (v != _password)
            return '两次输入密码不一致';
          else
            return null;
        });
  }

  Widget textName() {
    return TextFormField(
        controller: _controller4,
        onSaved: (v) => _name = v.trim(),
        decoration: InputDecoration(labelText: '输入政府名称'),
        validator: (v) {
          if (v.trim().length == 0)
            return '请输入政府名称';
          else
            return null;
        });
  }

  Widget textCode() {
    return TextFormField(
        controller: _controller5,
        onSaved: (v) => _code = v.trim(),
        decoration: InputDecoration(labelText: '输入机构代码'),
        validator: (v) {
          if (v.trim().length == 0)
            return '请输入机构代码';
          else
            return null;
        });
  }

  Widget textEmail() {
    return TextFormField(
        controller: _controller6,
        onSaved: (v) => _email = v,
        decoration: InputDecoration(labelText: '输入政府邮箱'),
        validator: (v) {
          RegExp _regExp=RegExp(r'^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$');
          if (!_regExp.hasMatch(v))
            return '请输入正确的邮箱';
          else
            return null;
        });
  }

  Widget buttonConfirm() {
    return Builder(builder: (BuildContext context){
      return Align(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            child: MaterialButton(
                height: 50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Text("注册",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w200,color: Colors.white)),
                color: Color.fromARGB(255, 150, 140, 240),
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    _formkey.currentState.save();
                    Map<String, dynamic> param = {
                      'username': _username+'_government',
                      'password': _password,
                      'government_name':_name,
                      'email':_email,
                      'government_CHNCode':_code
                    };
                    _governmentregister(param);
                  }
                }),
          ));
    });
  }

  _governmentregister(Map<String, dynamic> param) async{
    showDialog<Null>(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new LoadingDialog(
        text: '注册中',
        );
      }
    );
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post('server/Everitoken/user/government/register', data: param);
      if(response.data['code']==0){
        showToast('注册成功');
        Map<String, dynamic> param = {
          'username': _username+'_government',
          'password': _password,
        };
        await _userlogin(param);
      }
      else if(response.data['code']==20006)
        showToast('用户名已存在');
      else
        showToast('网络错误，请稍后重试');
    } catch (e) {
      print(e);
      showToast('网络错误，请稍后重试');
    }
    if(_success)
      Navigator.popUntil(context, ModalRoute.withName('/'));
    else
      Navigator.pop(context);
  }

  _userlogin(Map<String, dynamic> param) async {
    try {
      Response response;
      Dio dio = new Dio();
      dio.interceptors.add(CookieManager(CookieJar()));
      response = await dio.post('server/Everitoken/user/login', data: param);
      switch(response.data['code']){
        case 0:
          await _getuserinfo();
          break;
        case 20004:showToast('用户名或密码错误');break;
        case 20005:showToast('用户不存在');break;
      }
    } catch (e) {
      print(e.toString());
      showToast('网络错误，请稍后重试');
    }
  }

  _getuserinfo() async{
    try {
      Response response;
      Dio dio = new Dio();
      dio.interceptors.add(CookieManager(CookieJar()));
      response = await dio.post('server/Everitoken/user/getUserInfo');
      if(response.data['code']==0){
        User.resetuser(
            response.data['data']['uid'],
            response.data['data']['info_id'],
            2,
            response.data['data']['username'].toString().substring(0,response.data['data']['username'].toString().length-11),
            response.data['data']['government_name'],
            '',
            response.data['data']['email'],
            response.data['data']['government_CHNCode'],
            true,
            '');
        _success = true;
      }
    } catch (e) {
      print(e);
      showToast('网络错误，请稍后重试');
    }
  }
}

///回收点注册界面
class RegisterPageBin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterPageBinState();
  }
}

class RegisterPageBinState extends State<RegisterPageBin> {
  final _formkey = GlobalKey<FormState>();
  String _password, _name, _email,_username;
  TextEditingController _controller1 = new TextEditingController();
  TextEditingController _controller2 = new TextEditingController();
  TextEditingController _controller3 = new TextEditingController();
  TextEditingController _controller4 = new TextEditingController();
  TextEditingController _controller5 = new TextEditingController();
  bool _success = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon:Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                onPressed: (){Navigator.pop(context);}),
            title: Text('回收站注册', style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.w500),),
            backgroundColor: Color.fromARGB(255, 150, 140, 240)),
        body: Form(
            key: _formkey,
            child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 22.0),
                children: <Widget>[
                  textUsername(),
                  SizedBox(height: 20),
                  textPassword(),
                  SizedBox(height: 20),
                  textPassword2(),
                  SizedBox(height: 20),
                  textName(),
                  SizedBox(height: 20),
                  textEmail(),
                  SizedBox(height: 50),
                  buttonConfirm(),
                  SizedBox(height: 60),
                ])));
  }

  Widget textUsername() {
    return TextFormField(
        controller: _controller1,
        onSaved: (v) => _username = v.trim(),
        decoration: InputDecoration(labelText: '设置用户名'),
        validator: (v) {
          if (v.trim().length == 0)
            return '请输入用户名';
          else if(v.trim().length >12)
            return '用户名不能超过12位';
          else
            return null;
        });
  }

  Widget textPassword() {
    return TextFormField(
        controller: _controller2,
        obscureText: true,
        onSaved: (v) => _password = v,
        decoration: InputDecoration(labelText: '设置密码'),
        validator: (v) {
          _formkey.currentState.save();
          if (v.trim().length == 0)
            return '请输入密码';
          else if (v.trim().length < 8)
            return '密码不能少于8位';
          else if (v.trim().length > 24)
            return '密码不能超过24位';
          else
            return null;
        });
  }

  Widget textPassword2() {
    return TextFormField(
        controller: _controller3,
        obscureText: true,
        decoration: InputDecoration(
          labelText: '确认密码',
        ),
        validator: (v) {
          if (v.trim().length == 0)
            return '请再次输入密码';
          else if (v != _password)
            return '两次输入密码不一致';
          else
            return null;
        });
  }

  Widget textName() {
    return TextFormField(
        controller: _controller4,
        onSaved: (v) => _name = v,
        decoration: InputDecoration(labelText: '输入回收站名称'),
        validator: (v) {
          if (v.trim().length == 0)
            return '请输入回收站名称';
          else
            return null;
        });
  }

  Widget textEmail() {
    return TextFormField(
        controller: _controller5,
        onSaved: (v) => _email = v,
        decoration: InputDecoration(labelText: '输入回收站邮箱'),
        validator: (v) {
          RegExp _regExp=RegExp(r'^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$');
          if (!_regExp.hasMatch(v))
            return '请输入正确的邮箱';
          else
            return null;
        });
  }

  Widget buttonConfirm() {
    return Builder(builder: (BuildContext context){
      return Align(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            child: MaterialButton(
                height: 50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Text("注册",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w200,color: Colors.white)),
                color: Color.fromARGB(255, 150, 140, 240),
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    _formkey.currentState.save();
                    Map<String, dynamic> param = {
                      'username': _username+'_bin',
                      'password': _password,
                      'rs_name':_name,
                      'email':_email,
                    };
                    _binmentregister(param);
                  }
                }),
          ));
    });
  }

  _binmentregister(Map<String, dynamic> param) async{
    showDialog<Null>(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new LoadingDialog(
        text: '注册中',
        );
      }
    );
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post('server/Everitoken/user/recycling_station/register', data: param);
      if(response.data['code']==0){
        showToast('注册成功');
        Map<String, dynamic> param = {
          'username': _username+'_bin',
          'password': _password,
        };
        await _userlogin(param);
      }
      else if(response.data['code']==20006)
        showToast('用户名已存在');
      else
        showToast('网络错误，请稍后重试');
    } catch (e) {
      print(e);
      showToast('网络错误，请稍后重试');
    }
    if(_success)
      Navigator.popUntil(context, ModalRoute.withName('/'));
    else
      Navigator.pop(context);
  }

  _userlogin(Map<String, dynamic> param) async {
    try {
      Response response;
      Dio dio = new Dio();
      dio.interceptors.add(CookieManager(CookieJar()));
      response = await dio.post('server/Everitoken/user/login', data: param);
      switch(response.data['code']){
        case 0:
          await _getuserinfo();
          break;
        case 20004:showToast('用户名或密码错误');break;
        case 20005:showToast('用户不存在');break;
      }
    } catch (e) {
      print(e.toString());
      showToast('网络错误，请稍后重试');
    }
  }

  _getuserinfo() async{
    try {
      Response response;
      Dio dio = new Dio();
      dio.interceptors.add(CookieManager(CookieJar()));
      response = await dio.post('server/Everitoken/user/getUserInfo');
      if(response.data['code']==0){
        User.resetuser(
            response.data['data']['uid'],
            response.data['data']['info_id'],
            3,
            response.data['data']['username'].toString().substring(0,response.data['data']['username'].toString().length-4),
            response.data['data']['rs_name'],
            '',
            response.data['data']['email'],
            '',
            true,
            '');
        _success = true;
      }
    } catch (e) {
      print(e);
      showToast('网络错误，请稍后重试');
    }
  }
}

///个人信息界面
class PersonalInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PersonalInfoState();
  }
}

class PersonalInfoState extends State<PersonalInfo> {
  String _usertype='';
  String _nametype='';
  String _idtype='';
  @override
  Widget build(BuildContext context) {
    final controller1= TextEditingController();
    final controller2 = TextEditingController();
    if(User.type()==0){ _usertype='客户';_nametype='姓名';_idtype='身份证号';}
    else if(User.type()==1) {_usertype='企业';_nametype='企业名';_idtype='企业代码';}
    else if(User.type()==2) {_usertype='政府';_nametype='政府名';_idtype='机构代码';}
    else {_usertype='回收站';_nametype='回收站名';}
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 247, 255),
        appBar: AppBar(
            leading: IconButton(
                icon:Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                onPressed: (){Navigator.pop(context);}),
            title: Text('个人信息', style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.w500),),
            backgroundColor: Color.fromARGB(255, 150, 140, 240)),
        body: ListView(
            children: <Widget>[
              Container(
                  height: 50,
                  decoration: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 1, color: Colors.black45),
                  )),
              Offstage(
                  offstage: false,
                  child:Container(
                      foregroundDecoration: UnderlineTabIndicator(
                          borderSide: BorderSide(width: 0.5, color: Colors.black45),
                          insets: EdgeInsets.fromLTRB(10,0,10,0)
                      ),
                      decoration: BoxDecoration(color: Colors.white),
                      child:ListTile(
                          title: Text('用户名',style: TextStyle(color:Colors.black54,fontSize: 12)),
                          subtitle: Text(User.username(),style: TextStyle(color:Colors.black,fontSize: 18))
                      ))),
              Offstage(
                  offstage: false,
                  child:Container(
                      foregroundDecoration: UnderlineTabIndicator(
                          borderSide: BorderSide(width: 0.5, color: Colors.black45),
                          insets: EdgeInsets.fromLTRB(10,0,10,0)
                      ),
                      decoration: BoxDecoration(color: Colors.white),
                      child:ListTile(
                        title: Text('用户类型',style: TextStyle(color:Colors.black54,fontSize: 12)),
                        subtitle: Text(_usertype,style: TextStyle(color:Colors.black,fontSize: 18)),
                      ))),
              Offstage(
                  offstage: false,
                  child:Container(
                      foregroundDecoration: UnderlineTabIndicator(
                          borderSide: BorderSide(width: 0.5, color: Colors.black45),
                          insets: EdgeInsets.fromLTRB(10,0,10,0)
                      ),
                      decoration: BoxDecoration(color: Colors.white),
                      child:ListTile(
                          title: Text(_nametype,style: TextStyle(color:Colors.black54,fontSize: 12)),
                          subtitle: Text(User.name(),style: TextStyle(color:Colors.black,fontSize: 18))
                      ))),
              Offstage(
                  offstage: User.type()!=0,
                  child:Container(
                      foregroundDecoration: UnderlineTabIndicator(
                          borderSide: BorderSide(width: 0.5, color: Colors.black45),
                          insets: EdgeInsets.fromLTRB(10,0,10,0)
                      ),
                      decoration: BoxDecoration(color: Colors.white),
                      child:ListTile(
                          title: Text('性别',style: TextStyle(color:Colors.black54,fontSize: 12)),
                          subtitle: Text(User.gender(),style: TextStyle(color:Colors.black,fontSize: 18))
                      ))),
              Offstage(
                  offstage: User.type()==3,
                  child:Container(
                      foregroundDecoration: UnderlineTabIndicator(
                          borderSide: BorderSide(width: 0.5, color: Colors.black45),
                          insets: EdgeInsets.fromLTRB(10,0,10,0)
                      ),
                      decoration: BoxDecoration(color: Colors.white),
                      child:ListTile(
                          title: Text(_idtype,style: TextStyle(color:Colors.black54,fontSize: 12)),
                          subtitle: Text(User.idnum(),style: TextStyle(color:Colors.black,fontSize: 18))
                      ))),
              Offstage(
                  offstage: User.type()!=0,
                  child:Container(
                      foregroundDecoration: UnderlineTabIndicator(
                          borderSide: BorderSide(width: 0.5, color: Colors.black45),
                          insets: EdgeInsets.fromLTRB(10,0,10,0)
                      ),
                      decoration: BoxDecoration(color: Colors.white),
                      child:ListTile(
                        title: Text('联系电话',style: TextStyle(color:Colors.black54,fontSize: 12)),
                        subtitle: Text(User.phone(),style: TextStyle(color:Colors.black,fontSize: 18)),
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                  title: Text("修改联系电话"),
                                  content: TextField(controller: controller1),
                                  actions: <Widget>[
                                    GestureDetector(child: Text('确认'), onTap: (){
                                      RegExp _regExp=RegExp(r'^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$');
                                      if (!_regExp.hasMatch(controller1.text))
                                        showToast('请输入正确手机号');
                                      else {
                                        _userchangephone(controller1.text);
                                        Navigator.pop(context);
                                      }
                                    }),
                                    Padding(padding: EdgeInsets.all(10.0), child: GestureDetector(child: Text('取消'), onTap: (){Navigator.pop(context);})),
                                  ]));
                        },
                      ))),
              Offstage(
                  offstage: false,
                  child:Container(
                      foregroundDecoration: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 1, color: Colors.black45),
                      ),
                      decoration: BoxDecoration(color: Colors.white),
                      child:ListTile(
                        title: Text('邮箱',style: TextStyle(color:Colors.black54,fontSize: 12)),
                        subtitle: Text(User.email(),style: TextStyle(color:Colors.black,fontSize: 18)),
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                  title: Text("修改邮箱"),
                                  content: TextField(controller: controller2,),
                                  actions: <Widget>[
                                    GestureDetector(child: Text('确认'), onTap: (){
                                      RegExp _regExp=RegExp(r'^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$');
                                      if (!_regExp.hasMatch(controller2.text))
                                        showToast('请输入正确的邮箱');
                                      else {
                                        Navigator.pop(context);
                                        _userchangemail(controller2.text);
                                      }
                                    }),
                                    Padding(padding: EdgeInsets.all(10.0), child: GestureDetector(child: Text('取消'), onTap: (){Navigator.pop(context);})),
                                  ]));
                        },
                      )))
            ]
        )
    );
  }

  _userchangephone(String ph) async{
    showDialog<Null>(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new LoadingDialog(
        text: '提交中',
        );
      }
    );
    Map<String, dynamic> param = {
      'new_phone': ph,
    };
    try {
      Response response;
      Dio dio = new Dio();
      dio.interceptors.add(CookieManager(CookieJar()));
      response = await dio.post('server/Everitoken/user/customer/updatePhone', data: param);
      if(response.data['code']==0){
        User.resetphone(ph);
        setState(() {});
        showToast('修改成功');
      }else{
        showToast('网络错误，请稍后重试');
      }
    } catch (e) {
      print(e.toString());
      showToast('网络错误，请稍后重试');
    }
    Navigator.pop(context);
  }

  _userchangemail(String ma) async{
    showDialog<Null>(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new LoadingDialog(
        text: '提交中',
        );
      }
    );
    Map<String, dynamic> param = {
      'new_email': ma,
    };
    try {
      Response response;
      Dio dio = new Dio();
      dio.interceptors.add(CookieManager(CookieJar()));
      response = await dio.post('server/Everitoken/user/updateEmail', data: param);
      if(response.data['code']==0){
        User.resetemail(ma);
        setState(() {});
        showToast('修改成功');
      }else{
        showToast('网络错误，请稍后重试');
      }
    } catch (e) {
      print(e.toString());
      showToast('网络错误，请稍后重试');
    }
    Navigator.pop(context);
  }
}

///修改密码界面
class ChangePswdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
  return ChangePswdPageState();
  }
}

class ChangePswdPageState extends State<ChangePswdPage> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _controller1 = new TextEditingController();
  TextEditingController _controller2 = new TextEditingController();
  TextEditingController _controller3 = new TextEditingController();
  String _oldpswd, _npsword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon:Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                onPressed: (){Navigator.pop(context);}),
            title: Text('修改密码', style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.w500),),
            backgroundColor: Color.fromARGB(255, 150, 140, 240)),
        body: Form(
            key: _formkey,
            child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 22.0),
                children: <Widget>[
                  textOldpswd(),
                  SizedBox(height: 20),
                  textPassword(),
                  SizedBox(height: 20),
                  textPassword2(),
                  SizedBox(height: 20),
                  SizedBox(height: 50),
                  buttonBonfirm(),
                  SizedBox(height: 60),
                ])));
  }

  Widget textOldpswd() {
    return TextFormField(
        controller: _controller1,
        onSaved: (v) => _oldpswd = v.trim(),
        decoration: InputDecoration(labelText: '输入旧密码'),
        validator: (v) {
          if (v.trim().length == 0)
            return '请输入旧密码';
          else
            return null;
        });
  }

  Widget textPassword() {
    return TextFormField(
        obscureText: true,
        controller: _controller2,
        onSaved: (v) => _npsword = v,
        decoration: InputDecoration(labelText: '设置新密码'),
        validator: (v) {
          _formkey.currentState.save();
          RegExp _regExp=RegExp(r'^[ZA-ZZa-z0-9_]+$');
          if (v.trim().length == 0)
            return '请输入密码';
          else if(_regExp.firstMatch(v)==null)
            return '密码不能包含特殊字符';
          else if (v.trim().length < 8)
            return '密码不能少于8位';
          else if (v.trim().length > 24)
            return '密码不能超过24位';
          else
            return null;
        });
  }

  Widget textPassword2() {
    return TextFormField(
        obscureText: true,
        controller: _controller3,
        decoration: InputDecoration(
          labelText: '确认新密码',
        ),
        validator: (v) {
          _formkey.currentState.save();
          if (v.trim().length == 0)
            return '请再次输入密码';
          else if (v != _npsword)
            return '两次输入密码不一致';
          else
            return null;
        });
  }

  Widget buttonBonfirm() {
    return Builder(builder: (BuildContext context){
      return Align(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            child: MaterialButton(
                height: 50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Text("修改",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w200,color: Colors.white)),
                color: Color.fromARGB(255, 150, 140, 240),
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    _formkey.currentState.save();
                    String _username = User.username();
                    if(User.type()==0) _username=_username+'_customer';
                    else if(User.type()==1) _username=_username+'_producer';
                    else if(User.type()==2) _username=_username+'_government';
                    else _username=_username+'_bin';
                    Map<String, dynamic> param = {
                      'username': _username,
                      'password': _oldpswd,
                      'new_password': _npsword,
                      'confirmation_password': _npsword,
                    };
                    _userchangepswd(param);
                  }
                }),
          ));
    });
  }

  _userchangepswd(Map<String, dynamic> param) async{
    showDialog<Null>(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new LoadingDialog(
        text: '提交中',
        );
      }
    );
    try {
      Response response;
      Dio dio = new Dio();
      dio.interceptors.add(CookieManager(CookieJar()));
      response = await dio.post('server/Everitoken/user/updatePassword', data: param);
      if(response.data['code']==0){
        showToast('修改成功');
        Navigator.pop(context);
      }
      else if(response.data['code']==20004)
        showToast('原密码错误');
      else
        showToast('网络错误，请稍后重试');
    } catch (e) {
      print(e.toString());
      showToast('网络错误，请稍后重试');
    }
    Navigator.pop(context);
  }
}