import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ChangeIcon(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: HomePage(),
    );
  }
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final colorBlue = Color.fromRGBO(123, 104, 238, 1);
bool checkSignIn = false;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('EzPy'),
        backgroundColor: colorBlue,
        actions: <Widget>[
          IconSignIn(),
        ],
      ),
    );
  }
}

class ChangeIcon with ChangeNotifier {
  bool value = false;

  void change() {
    value = !value;
    notifyListeners();
  }
}

class IconSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final key = context.watch<ChangeIcon>();
    return Container(
      child: IconButton(
        icon: Icon(key.value ? Icons.exit_to_app : Icons.person),
        tooltip: 'Sign in',
        onPressed: () {
          if (key.value) {
            key.change();
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignIn()),
          );
        },
      ),
    );
  }
}

class SignIn extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final key = context.watch<ChangeIcon>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in"),
        backgroundColor: colorBlue,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                width: 300,
              ),
              Container(
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your password',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                width: 300,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                            MaterialStateProperty.all<Color>(
                              Color.fromRGBO(60, 179, 113, 1))
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            key.change();
                          }
                        },
                        child: Text('Sign in'),
                      ),
                      padding: new EdgeInsets.all(10.0),
                    ),
                    Container(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                            MaterialStateProperty.all<Color>(
                              Color.fromRGBO(30, 144, 255, 1))
                        ),
                        onPressed: () {},
                        child: Text('Login'),
                      ),
                      padding: new EdgeInsets.all(10.0),
                    ),
                  ]
                )
              ),
            ],
          ),
        )
      )
    );
  }
}
