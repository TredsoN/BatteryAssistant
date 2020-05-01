import 'package:flutter/material.dart';
import 'package:batteryassistant/main.dart';
import 'package:dio/dio.dart';
import 'package:oktoast/oktoast.dart';

///企业授权情况界面
class CertificationState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 247, 255),
        appBar: AppBar(
            leading: IconButton(
                icon:Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                onPressed: (){Navigator.pop(context);}),
            title: Text('企业授权', style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.w500),),
            backgroundColor: Color.fromARGB(255, 150, 140, 240)),
        body: Column(
            children: <Widget>[
              Container(
                height: 50,
                decoration: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 1, color: Colors.black45),
                )),
              myTile('授权情况', User.iscertificated()?'已授权':'未授权'),
              Container(
                          decoration: UnderlineTabIndicator(
                            borderSide: BorderSide(width: 1, color: Colors.black45),
                          )),
              Container(
                          height: 30,
                          decoration: UnderlineTabIndicator(
                            borderSide: BorderSide(width: 1, color: Colors.black45),
                          )),
              Offstage(
                          offstage: !User.iscertificated(),
                          child: Container(
                              foregroundDecoration: UnderlineTabIndicator(
                                borderSide: BorderSide(width: 1, color: Colors.black45),
                              ),
                              decoration: BoxDecoration(color: Colors.white),
                              child:ListTile(
                                title: Text('授权信息'),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                onTap: (){_passrcdget(context);},
                              ))),
              Offstage(
                        offstage: User.iscertificated(),
                        child: Container(
                            foregroundDecoration: UnderlineTabIndicator(
                              borderSide: BorderSide(width: 1, color: Colors.black45),
                            ),
                            decoration: BoxDecoration(color: Colors.white),
                            child:ListTile(
                              title: Text('申请授权'),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: (){Navigator.pushNamed(context, '/certificationapply');},
                            ))),
              Offstage(
                          offstage: User.iscertificated(),
                          child: Container(
                              foregroundDecoration: UnderlineTabIndicator(
                                borderSide: BorderSide(width: 1, color: Colors.black45),
                              ),
                              decoration: BoxDecoration(color: Colors.white),
                              child:ListTile(
                                title: Text('申请记录'),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                onTap: (){
                                    _recordget(context);
                                },
                              ))),
            ]));
  }

  Widget myTile(String title, String content){
    return Container(
        foregroundDecoration: UnderlineTabIndicator(
            borderSide: BorderSide(width: 0.5, color: Colors.black45),
            insets: EdgeInsets.fromLTRB(10,0,10,0)
        ),
        decoration: BoxDecoration(color: Colors.white),
        child:ListTile(
            title: Text(title,style: TextStyle(color:Colors.black54,fontSize: 12)),
            subtitle: Text(content,style: TextStyle(color:Colors.black,fontSize: 20))
        ));
  }

  _recordget(context) async{
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
    };
    print(param);
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post('server/Everitoken/Info/ApplicationInfoInMass', data: param);
      int i =0;
      List rcds = new List();
      print(response.data);
      while(response.data[i.toString()]!=null) {
        String time = DateTime.fromMillisecondsSinceEpoch(response.data[i.toString()]['applicationTime']).toString();
        time = time.substring(0,time.length-4);
        Map<String, dynamic> record = {
          'time': time,
          'reason': response.data[i.toString()]['applicationDocuments'],
          'state':response.data[i.toString()]['Authorized'],
        };
        rcds.add(record);
        i++;
      }
      Navigator.pop(context);
      Navigator.push(context,MaterialPageRoute(builder:(context){return CertificationApplyRcd(rcds);}));
    } catch (e) {
      print(e.toString());
      showToast('网络错误，请稍后重试');
      Navigator.pop(context);
    }
  }

  _passrcdget(context) async{
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
    };
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post('server/Everitoken/Info/GetPassedAuthorize', data: param);
      print(response.data);
      String time = DateTime.fromMillisecondsSinceEpoch(response.data['Applications'][0]['applicationTime']).toString();
      time = time.substring(0,time.length-4);
      String time2 = DateTime.fromMillisecondsSinceEpoch(response.data['Processes'][0]['processTime']).toString();
      time2 = time2.substring(0,time2.length-4);
      Navigator.pop(context);
      Navigator.push(context,MaterialPageRoute(builder:(context){return CertificationPassRcd(time,response.data['Applications'][0]['applicationDocuments'],response.data['Producer'],time2,response.data['Processes'][0]['processReason']);}));
    } catch (e) {
      Navigator.pop(context);
      print(e.toString());
      showToast('网络错误，请稍后重试');
    }
  }
}

///企业申请记录界面
class CertificationApplyRcd extends StatelessWidget {
  final List _records;
  CertificationApplyRcd(this._records);
  @override
  Widget build(BuildContext context) {
    if(_records.length==0)
      return Scaffold(
          backgroundColor: Color.fromARGB(255, 243, 247, 255),
          appBar: AppBar(
              leading: IconButton(
                  icon:Icon(Icons.keyboard_arrow_left),
                  color: Colors.white,
                  onPressed: (){Navigator.pop(context);}),
              title: Text('申请记录', style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.w500),),
              backgroundColor: Color.fromARGB(255, 150, 140, 240)),
          body: Column(
            children: <Widget>[
              Container(
                  foregroundDecoration: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 1, color: Colors.black45),
                  ),
                  child:ListTile(
                    title: Text('当前暂无申请记录',style: TextStyle(color: Colors.black54)),
                  )),
              Container(
                  foregroundDecoration: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 1, color: Colors.black45),
                  ),
                  decoration: BoxDecoration(color: Colors.white),
                  child:ListTile(
                    title: Text('点击前往申请'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/certificationapply');
                    },
                  )),
            ],
          )
      );
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 247, 255),
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text('申请记录', style: TextStyle(color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500),),
            backgroundColor: Color.fromARGB(255, 150, 140, 240)),
        body: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05, 0, MediaQuery.of(context).size.width*0.05, 0),
                    itemCount: _records.length,
                    itemBuilder: (context, index) {
                      String state = '';
                      if(_records[index]['state']==-1)
                        state='未通过';
                      else if(_records[index]['state']==0)
                        state='待审核';
                      return Column(
                        children: <Widget>[
                          SizedBox(height: 15),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(width: 0.5),
                                  boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(5, 5),  blurRadius:5)]
                              ),
                              child: Column(children: <Widget>[
                                ListTile(
                                  title: Text('申请时间',style: TextStyle(color:Colors.black54,fontSize: 12)),
                                  subtitle: Text(_records[index]['time'].toString(),style: TextStyle(color:Colors.black,fontSize: 18)),
                                ),
                                ListTile(
                                  title: Text('申请理由',style: TextStyle(color:Colors.black54,fontSize: 12)),
                                  subtitle: Text(_records[index]['reason'].toString(),style: TextStyle(color:Colors.black,fontSize: 18)),
                                ),
                                ListTile(
                                  title: Text('当前状态',style: TextStyle(color:Colors.black54,fontSize: 12)),
                                  subtitle: Text(state,style: TextStyle(color:Colors.black,fontSize: 18)),
                                ),
                                Offstage(
                                    offstage: _records[index]['state']!=0,
                                    child:ListTile(
                                      title: Text('未通过理由',style: TextStyle(color:Colors.black54,fontSize: 12)),
                                      subtitle: Text('企业不合格',style: TextStyle(color:Colors.black,fontSize: 18)),
                                    )
                                )
                              ])),
                          SizedBox(height: 15)
                      ]);
                    })
            )
          ],)
    );
  }
}

///企业授权信息界面
class CertificationPassRcd extends StatelessWidget {
  final String _time,_reason,_govern,_gtime,_greason;
  CertificationPassRcd(this._time,this._reason,this._govern,this._gtime,this._greason);
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
            title: Text('授权信息', style: TextStyle(color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500),),
            backgroundColor: Color.fromARGB(255, 150, 140, 240)),
        body: ListView(
          children: <Widget>[
            Container(
                height: 50,
                decoration: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 1, color: Colors.black45),
                )),
            _myTile('申请时间', _time),
            _myTile('申请原因', _reason),
            _myTile('审核机构', _govern),
            _myTile('审核时间', _gtime),
            _myTile('授权理由', _greason),
            Container(
                decoration: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 1, color: Colors.black45),
                )),
          ],)
    );
  }

  Widget _myTile(String title, String content){
    return Container(
        foregroundDecoration: UnderlineTabIndicator(
            borderSide: BorderSide(width: 0.5, color: Colors.black45),
            insets: EdgeInsets.fromLTRB(10,0,10,0)
        ),
        decoration: BoxDecoration(color: Colors.white),
        child:ListTile(
          title: Text(title,style: TextStyle(color:Colors.black54,fontSize: 12)),
          subtitle: Text(content,style: TextStyle(color:Colors.black,fontSize: 18)),
        ));
  }
}

///政府审核记录界面
class CertificationAuditRcd extends StatelessWidget {
  final List _records;
  CertificationAuditRcd(this._records);

  @override
  Widget build(BuildContext context) {
    if(_records.length==0)
      return Scaffold(
          backgroundColor: Color.fromARGB(255, 243, 247, 255),
          appBar: AppBar(
              leading: IconButton(
                  icon:Icon(Icons.keyboard_arrow_left),
                  color: Colors.white,
                  onPressed: (){Navigator.pop(context);}),
              title: Text('审核记录', style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.w500),),
              backgroundColor: Color.fromARGB(255, 150, 140, 240)),
          body: Column(
            children: <Widget>[
              Container(
                  foregroundDecoration: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 1, color: Colors.black45),
                  ),
                  child:ListTile(
                    title: Text('当前暂无审核记录',style: TextStyle(color: Colors.black54)),
                  )),
              Container(
                  foregroundDecoration: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 1, color: Colors.black45),
                  ),
                  decoration: BoxDecoration(color: Colors.white),
                  child:ListTile(
                    title: Text('点击前往审核'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      _applicationget(context);
                    },
                  )),
            ],
          )
      );
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 247, 255),
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text('审核记录', style: TextStyle(color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500),),
            backgroundColor: Color.fromARGB(255, 150, 140, 240)),
        body: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05, 0, MediaQuery.of(context).size.width*0.05, 0),
                    itemCount: _records.length,
                    itemBuilder: (context, index) {
                      return Column(
                          children: <Widget>[
                            SizedBox(height: 15),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(width: 0.5),
                                    boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(5, 5),  blurRadius:5)]
                                ),
                                child: Column(children: <Widget>[
                                  ListTile(
                                    title: Text('申请公司',style: TextStyle(color:Colors.black54,fontSize: 12)),
                                    subtitle: Text(_records[index]['name'],style: TextStyle(color:Colors.black,fontSize: 18)),
                                  ),
                                  ListTile(
                                    title: Text('申请时间',style: TextStyle(color:Colors.black54,fontSize: 12)),
                                    subtitle: Text(_records[index]['time'],style: TextStyle(color:Colors.black,fontSize: 18)),
                                  ),
                                  ListTile(
                                    title: Text('申请理由',style: TextStyle(color:Colors.black54,fontSize: 12)),
                                    subtitle: Text(_records[index]['reason'],style: TextStyle(color:Colors.black,fontSize: 18)),
                                  ),
                                  ListTile(
                                    title: Text('审核时间',style: TextStyle(color:Colors.black54,fontSize: 12)),
                                    subtitle: Text(_records[index]['time2'],style: TextStyle(color:Colors.black,fontSize: 18)),
                                  ),
                                  ListTile(
                                    title: Text('审核结果',style: TextStyle(color:Colors.black54,fontSize: 12)),
                                    subtitle: Text(_records[index]['state'],style: TextStyle(color:Colors.black,fontSize: 18)),
                                  ),
                                  ListTile(
                                    title: Text('审核理由',style: TextStyle(color:Colors.black54,fontSize: 12)),
                                    subtitle: Text(_records[index]['reason2'],style: TextStyle(color:Colors.black,fontSize: 18)),
                                  ),
                                ])),
                            SizedBox(height: 15)
                          ]);
                    })
            )
          ],)
    );
  }

  _applicationget(context)async{
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
      Response response;
      Dio dio = new Dio();
      response = await dio.post('server/Everitoken/Info/NotAuthorizedApplication');
      List rcd = new List();
      List info = response.data['producer'];
      List info2 = response.data['info'];
      for(int i =0;i<info.length;i++){
        String time = DateTime.fromMillisecondsSinceEpoch(info2[i]['applicationTime']).toString();
        time = time.substring(0,time.length-4);
        Map<String, dynamic> a = {
          'has': false,
          'name': info[i]['producerName'],
          'time': time,
          'reason': info2[i]['applicationDocuments'],
          'applicantid': info2[i]['applicantUid'],
          'applicationid': info2[i]['uid'],
        };
        rcd.add(a);
      }
      Navigator.push(context,MaterialPageRoute(builder:(context){return CertificationApplyLst(rcd);}));
    } catch (e) {
      print(e.toString());
      showToast('网络错误，请稍后重试');
    }
    Navigator.pop(context);
  }
}

///政府授权导航界面（至开始审核，审核记录）
class AuditPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 247, 255),
        appBar: AppBar(
            leading: IconButton(
                icon:Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                onPressed: (){Navigator.pop(context);}),
            title: Text('授权审核', style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.w500),),
            backgroundColor: Color.fromARGB(255, 150, 140, 240)),
        body: Column(
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
                    title: Text('开始审核'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: (){
                      _applicationget(context);
                    },
                  )),
              Container(
                      foregroundDecoration: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 1, color: Colors.black45),
                      ),
                      decoration: BoxDecoration(color: Colors.white),
                      child:ListTile(
                        title: Text('审核记录'),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: (){
                          _recordget(context);
                        },
                      )),
            ]));
  }

  _applicationget(context)async{
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
      Response response;
      Dio dio = new Dio();
      response = await dio.post('server/Everitoken/Info/NotAuthorizedApplication');
      print(response);
      List rcd = new List();
      List info = response.data['producer'];
      List info2 = response.data['info'];
      for(int i =0;i<info.length;i++){
        String time = DateTime.fromMillisecondsSinceEpoch(info2[i]['applicationTime']).toString();
        time = time.substring(0,time.length-4);
        Map<String, dynamic> a = {
          'has': false,
          'name': info[i]['producerName'],
          'time': time,
          'reason': info2[i]['applicationDocuments'],
          'applicantid': info2[i]['applicantuid'],
          'applicationid': info2[i]['uid'],
        };
        rcd.add(a);
      }
      Navigator.pop(context);
      Navigator.push(context,MaterialPageRoute(builder:(context){return CertificationApplyLst(rcd);}));
    } catch (e) {
      print(e.toString());
      showToast('网络错误，请稍后重试');
      Navigator.pop(context);
    }
  }

  _recordget(context)async{
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
    };
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post('server/Everitoken/Info/AuthorizeRecordList', data: param);
      print(response.data);
      List l = response.data['Processes'];
      List l2 = response.data['Producer'];
      List l3 = response.data['Applications'];
      if(response.data['code']==10005){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CertificationAuditRcd(List());
        }));
      }
      else{
        List rcd = new List();
        for(int i=0;i<l.length;i++) {
          String time = DateTime.fromMillisecondsSinceEpoch(l3[i]['applicationTime']).toString();
          time = time.substring(0,time.length-4);
          String time2 = DateTime.fromMillisecondsSinceEpoch(l[i]['processTime']).toString();
          time2 = time2.substring(0,time2.length-4);
          Map<String, dynamic> record = {
            'name': l2[i]['producerName'],
            'time': time,
            'time2': time2,
            'state':l[i]['value']==1?'已通过':'未通过',
            'reason':l3[i]['applicationDocuments'],
            'reason2':l[i]['processReason'],
          };
          rcd.add(record);
        }
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CertificationAuditRcd(rcd);
        }));
      }
    } catch (e) {
      print(e.toString());
      showToast('网络错误，请稍后重试');
      Navigator.pop(context);
    }
  }
}

///企业申请授权界面
class CertificationApply extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CertificationApplyState();
  }
}

class CertificationApplyState extends State<CertificationApply> {
  TextEditingController _controller1 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon:Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                onPressed: (){Navigator.pop(context);}
            ),
            title: Text('申请授权', style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.w500),),
            backgroundColor: Color.fromARGB(255, 150, 140, 240)
        ),
        body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 22.0),
                children: <Widget>[
                  TextField(
                    controller: _controller1,
                    maxLines: 5,
                    decoration: InputDecoration(hintText: '填写申请理由'),
                  ),
                  SizedBox(height: 50),
                  buttonConfirm(),
                  SizedBox(height: 60),
                ]
        )
    );
  }

  Widget buttonConfirm() {
    return Builder(builder: (BuildContext context){
      return Align(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            child: MaterialButton(
                height: 50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Text("提交申请",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w200,color: Colors.white)),
                color: Color.fromARGB(255, 150, 140, 240),
                onPressed: () {
                  if(_controller1.text.trim().length==0)
                    showToast('请填写申请理由');
                  else {
                    String time = DateTime.now().toString();
                    Map<String, dynamic> param = {
                      'ApplicantID': User.userid2(),
                      'ApplicationDocument': _controller1.text,
                      'ApplicationTime': time.substring(0,time.length-4),
                    };
                    _certificationapply(param);
                  }
                }),
          ));
    });
  }

  _certificationapply(Map<String, dynamic> param) async{
    print(param);
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
      Response response;
      Dio dio = new Dio();
      response = await dio.post('server/Everitoken/Authorize/Apply', data: param);
      if(response.data['code']==0){
        showToast('申请成功提交,等待审核');
        Navigator.pop(context);
      }
      else
        showToast('网络错误，请稍后重试');
    } catch (e) {
      print(e.toString());
      showToast('网络错误，请稍后重试');
    }
    Navigator.pop(context);
  }
}

///政府审核列表界面
class CertificationApplyLst extends StatefulWidget {
  final List _apply;
  CertificationApplyLst(this._apply);

  @override
  State<StatefulWidget> createState() {
    return CertificationApplyLstState(_apply);
  }
}

class CertificationApplyLstState extends State<CertificationApplyLst> {
  List _apply;
  CertificationApplyLstState(this._apply);

  @override
  Widget build(BuildContext context) {
    if(_apply.length==0)
      return Scaffold(
          backgroundColor: Color.fromARGB(255, 243, 247, 255),
          appBar: AppBar(
              leading: IconButton(
                  icon:Icon(Icons.keyboard_arrow_left),
                  color: Colors.white,
                  onPressed: (){Navigator.pop(context);}),
              title: Text('申请记录', style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.w500),),
              backgroundColor: Color.fromARGB(255, 150, 140, 240)),
          body: Container(
                  child:ListTile(
                    title: Text('当前暂无申请记录',style: TextStyle(color: Colors.black54)),
                  )),
      );
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 247, 255),
        appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.keyboard_arrow_left),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text('授权申请', style: TextStyle(color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500),),
            backgroundColor: Color.fromARGB(255, 150, 140, 240)),
        body: ListView.builder(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05, 0, MediaQuery.of(context).size.width*0.05, 0),
            itemCount: _apply.length,
            itemBuilder: (context, index) {
              return Offstage(
                offstage: _apply[index]['has'],
                child: Column(
                    children: <Widget>[
                      SizedBox(height: 15),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 0.5),
                              boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(5, 5),  blurRadius:5)]
                          ),
                          child: Column(children: <Widget>[
                            ListTile(
                              title: Text('申请公司',style: TextStyle(color:Colors.black54,fontSize: 12)),
                              subtitle: Text(_apply[index]['name'],style: TextStyle(color:Colors.black,fontSize: 18)),
                            ),
                            ListTile(
                              title: Text('申请时间',style: TextStyle(color:Colors.black54,fontSize: 12)),
                              subtitle: Text(_apply[index]['time'],style: TextStyle(color:Colors.black,fontSize: 18)),
                            ),
                            ListTile(
                              title: Text('申请理由',style: TextStyle(color:Colors.black54,fontSize: 12)),
                              subtitle: Text(_apply[index]['reason'],style: TextStyle(color:Colors.black,fontSize: 18)),
                            ),
                            Row(children: <Widget>[
                              SizedBox(width: MediaQuery.of(context).size.width*0.4),
                              Align(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width*0.2,
                                    child: MaterialButton(
                                        height: 40,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        child: Text("同意",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w200,color: Colors.white)),
                                        color: Color.fromARGB(255, 150, 140, 240),
                                        onPressed: () {
                                          Map<String, dynamic> param ={
                                            "ApplicantID":_apply[index]['applicantid'],
                                            "GovernmentID":User.userid2(),
                                            "AuthorizeTime":DateTime.now().toString(),
                                            "AuthorizeValue":1,
                                            "AuthorizeReason":"合格",
                                            "ApplicationUid": _apply[index]['applicationid'],
                                          };
                                          _applypass(context, param, index);
                                        }),
                                  )),
                              SizedBox(width: MediaQuery.of(context).size.width*0.05),
                              Align(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width*0.2,
                                    child: MaterialButton(
                                        height: 40,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        child: Text("拒绝",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w200,color: Colors.white)),
                                        color: Colors.red,
                                        onPressed: () {
                                          Map<String, dynamic> param ={
                                            "ApplicantID":_apply[index]['applicantid'],
                                            "GovernmentID":User.userid2(),
                                            "AuthorizeTime":DateTime.now().toString(),
                                            "AuthorizeValue":-1,
                                            "AuthorizeReason":"企业指标不合格",
                                            "ApplicationUid": _apply[index]['applicationid'],
                                          };
                                          _applypass(context, param, index);
                                        }),
                                  )),
                            ]),
                            SizedBox(height: 15)
                          ])),
                      SizedBox(height: 15)
                    ]),
              );
            })
    );
  }

  _applypass(context,param,index)async{
    showDialog<Null>(
      context: context, 
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new LoadingDialog(
        text: '加载中',
        );
      }
    );
    print(param);
    try {
      Response response;
      Dio dio = new Dio();
      response = await dio.post('server/Everitoken/Authorize/SetAuthorize', data:param);
      print(response.data);
      if(response.data['code']==0){
        showToast('审核成功');
        _apply[index]['has']=true;
        setState(() { });
      }
      else
        showToast('网络错误，请稍后重试');
    } catch (e) {
      print(e.toString());
      showToast('网络错误，请稍后重试');
    }
    Navigator.pop(context);
  }
}