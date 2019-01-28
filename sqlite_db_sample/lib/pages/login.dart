import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_db_sample/data/database_helper.dart';
import 'package:sqlite_db_sample/data/userinfo.dart';
import 'package:sqlite_db_sample/model/user.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: 'Flutter Demo Home Page');
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var todoContent;
  String userName;
  String password;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  onSubmit(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      userName = usernameController.text;
      password = passwordController.text;
      Database database = await DatabaseHelper().db;
      UserInfo userInfo = UserInfo(database);
      User user = await userInfo.get(userName);
      if (user == null) {
        user = User(userName, password);
        int id = await userInfo.insert(user);
      } else {
        user = User(userName, password, id: user.id);
        int id = await userInfo.update(user);
      }
      Navigator.pushNamed(context, '/second');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 应用当前widget的数据方式
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Sqflite App Login',
              style: TextStyle(fontSize: 30),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 8),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'please input name', labelText: 'Username'),
                      controller: usernameController,
                      validator: (data) {
                        if (data.isEmpty) return '不能输入为空';
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'please input password',
                          labelText: 'password'),
                      controller: passwordController,
                      validator: (data) {
                        if (data.isEmpty) return '不能输入为空';
                        return null;
                      },
                    )
                  ],
                )),
            RaisedButton(
                onPressed: () {
                  onSubmit(context);
                },
                child: Text('Login'),
                color: Colors.green)
          ],
        ),
      ),
    );
  }
}
