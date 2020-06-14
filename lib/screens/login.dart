import 'package:firestore_auth/auth/auth.dart';
import 'package:firestore_auth/const/textstyleConst.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { logIn, signUp }

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();

  bool _obscuredText = true;

  bool _obscuredText1 = true;

  String _email;

  String _password;

  String confirmPassword;

  FormType _formType = FormType.logIn;

  bool validateAndSave() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      print("Valid Form Email : $_email + Password :$_password");
      return true;
    } else {
      print("Invalid Form");
      return false;
    }
  }

  Future validateAndSubmit() async {
    final validated = validateAndSave();

    if (validated) {
      try {
        if (_formType == FormType.logIn) {
          String userId = await widget.auth.signInWithEmail(_email, _password);
          print("Signed user: $userId");
        } else {
          String userId = await widget.auth.createUser(_email, _password);
          print("Registered user: $userId");
        }
        widget.onSignedIn();
      } catch (e) {
        print("Error Login:$e");
      }
    }
  }

  void _moveToRegister() {
    formkey.currentState.reset();
    setState(() {
      _formType = FormType.signUp;
    });
  }

  void moveToLogin() {
    formkey.currentState.reset();
    setState(() {
      _formType = FormType.logIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: formkey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 80.0, horizontal: 20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: buildLoginForm() + buildLoginButtons(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildLoginForm() {
    if (_formType == FormType.logIn) {
      return [
        Text(
          "Login Page",
          style: TextStyles.headingStyle,
        ),
        SizedBox(
          height: 20.0,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Email",
            hintText: "Enter Your Email",
            border: OutlineInputBorder(),
          ),
          validator: (value) => value.isEmpty ? "Email can \'t be empty" : null,
          onSaved: (value) => _email = value,
        ),
        SizedBox(
          height: 20.0,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Password",
            hintText: "Password",
            border: OutlineInputBorder(),
            // filled: true,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscuredText = !_obscuredText;
                });
              },
              child:
                  Icon(_obscuredText ? Icons.visibility : Icons.visibility_off),
            ),
          ),
          obscureText: _obscuredText,
          validator: (value) =>
              value.isEmpty ? "Password can \'t be empty" : null,
          onSaved: (value) => _password = value,
        ),
        SizedBox(
          height: 20.0,
        ),
      ];
    } else {
      return [
        Text(
          "Register",
          style: TextStyles.headingStyle,
        ),
        SizedBox(
          height: 20.0,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Email",
            hintText: "Enter Your Email",
            border: OutlineInputBorder(),
          ),
          validator: (value) => value.isEmpty ? "Email can\'t be empty" : null,
          onSaved: (value) => _email = value,
        ),
        SizedBox(
          height: 20.0,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Password",
            hintText: "Password",
            border: OutlineInputBorder(),
            // filled: true,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscuredText = !_obscuredText;
                });
              },
              child:
                  Icon(_obscuredText ? Icons.visibility : Icons.visibility_off),
            ),
          ),
          obscureText: _obscuredText,
          validator: (value) =>
              value.isEmpty ? "Password can \'t be empty" : null,
          onSaved: (value) => _password = value,
        ),
        SizedBox(
          height: 20.0,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Confirm Password",
            hintText: "Confirm Password",
            border: OutlineInputBorder(),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscuredText1 = !_obscuredText1;
                });
              },
              child: Icon(
                  _obscuredText1 ? Icons.visibility : Icons.visibility_off),
            ),
          ),
          obscureText: _obscuredText1,
          validator: (value) =>
              value.isEmpty ? "Password does\'t  match" : null,
          onSaved: (value) => confirmPassword = value,
        ),
        SizedBox(
          height: 10.0,
        ),
      ];
    }
  }

  List<Widget> buildLoginButtons() {
    if (_formType == FormType.logIn) {
      return [
        RaisedButton(
          onPressed: validateAndSubmit,
          child: Text(
            "Login",
            style: TextStyles.buttonStyle,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        FlatButton(
          onPressed: _moveToRegister,
          child: Text(
            "Have no account ? Sign up",
            style: TextStyles.buttonStyle,
          ),
        )
      ];
    } else {
      return [
        RaisedButton(
          onPressed: validateAndSubmit,
          child: Text(
            "Register",
            style: TextStyles.buttonStyle,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        FlatButton(
          onPressed: moveToLogin,
          child: Text(
            "Have account ? Login",
            style: TextStyles.buttonStyle,
          ),
        )
      ];
    }
  }
}
