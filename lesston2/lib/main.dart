import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyLoginScreen(),
      theme: ThemeData(primarySwatch: Colors.blue, canvasColor: Colors.yellow),
    );
  }
}

class MyLoginScreen extends StatefulWidget {
  @override
  _MyLoginScreenState createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  String _email;
  String _password;
  bool _obscurePassword = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('login'),
        ),
        body: Builder(
          builder: (context) => Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        suffixText: '@lohika.com',
                        hintText: 'email@example.com',
                        labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (!email.contains('@')) {
                        return 'Please enter correct email';
                      }
                    },
                    onSaved: (value) {
                      _email = value;
                    },
                  ),
                  TextFormField(
                    autovalidate: true,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.local_airport),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword
                              ? Icons.lock_outline
                              : Icons.lock_open),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        )),
                    validator: (password) {
                      if (password.length < 3) {
                        return 'Your password too short';
                      }
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                  RaisedButton(
                    onPressed: () {
                      var currentState = _formKey.currentState;
                      if (currentState.validate()) {
                        currentState.save();
                      } else {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Ne ne nenenenene')));
                      }
                    },
                    child: Text('Submit'),
                  )
                ],
              )),
        ));
  }
}
