import 'package:cooker/classes/user.dart';
import 'package:uuid/uuid.dart';
import 'package:cooker/auth/baseAuth.dart';
import 'package:flutter/material.dart';

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => new LoginSignupPageState();
}

class LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();

  String userKey;

  String _firstname;
  String _lastname;
  String _username;
  String _phone;
  String _address;
  String _email;
  String _password;
  String _errorMessage;
  bool _isLoginForm;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      User currentUser;
      String authkey;
      try {
        if (_isLoginForm) {
          authkey = await widget.auth.signIn(_email, _password);
          currentUser = await widget.auth.logInDatabase(_email, _password);
          print('Signed in: $currentUser');
        } else {
          authkey = await widget.auth.signUp(_email, _password);
          currentUser = await widget.auth.registerToDatabase(_firstname,
              _lastname, _username, _password, _address, _phone, _email);
          print('Signed up user: $currentUser');
        }
        setState(() {
          _isLoading = false;
        });

        if (authkey.length > 0 && authkey != null && _isLoginForm) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Stack(
      children: <Widget>[
        _showForm(),
        _showCircularProgress(),
      ],
    ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

//  void _showVerifyEmailSentDialog() {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return AlertDialog(
//          title: new Text("Verify your account"),
//          content:
//              new Text("Link to verify account has been sent to your email"),
//          actions: <Widget>[
//            new FlatButton(
//              child: new Text("Dismiss"),
//              onPressed: () {
//                toggleFormMode();
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }

  Widget _showForm() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              showLogo(),
              if (!_isLoginForm) showRegistrationForm(),
              showEmailInput(),
              showPasswordInput(),
              showPrimaryButton(),
              showSecondaryButton(),
              showErrorMessage(),
            ],
          ),
        ));
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }

  Widget showRegistrationForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.text,
            autofocus: false,
            decoration: new InputDecoration(
                hintText: 'First name',
                icon: new Icon(
                  Icons.mail,
                  color: Colors.grey,
                )),
            validator: (value) =>
                value.isEmpty ? 'first name can\'t be empty' : null,
            onSaved: (value) => _firstname = value.trim(),
          ),
          TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.text,
            autofocus: false,
            decoration: new InputDecoration(
                hintText: 'last name',
                icon: new Icon(
                  Icons.mail,
                  color: Colors.grey,
                )),
            validator: (value) =>
                value.isEmpty ? 'last name can\'t be empty' : null,
            onSaved: (value) => _lastname = value.trim(),
          ),
          TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.text,
            autofocus: false,
            decoration: new InputDecoration(
                hintText: 'username',
                icon: new Icon(
                  Icons.mail,
                  color: Colors.grey,
                )),
            validator: (value) =>
                value.isEmpty ? 'Username can\'t be empty' : null,
            onSaved: (value) => _username = value.trim(),
          ),
          TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.phone,
            autofocus: false,
            decoration: new InputDecoration(
                hintText: 'phone number',
                icon: new Icon(
                  Icons.mail,
                  color: Colors.grey,
                )),
            validator: (value) =>
                value.isEmpty ? 'phone can\'t be empty' : null,
            onSaved: (value) => _phone = value.trim(),
          ),
          TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.text,
            autofocus: false,
            decoration: new InputDecoration(
                hintText: 'Address',
                icon: new Icon(
                  Icons.mail,
                  color: Colors.grey,
                )),
            validator: (value) =>
                value.isEmpty ? 'address can\'t be empty' : null,
            onSaved: (value) => _address = value.trim(),
          ),
        ],
      ),
    );
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget showSecondaryButton() {
    return new FlatButton(
        child: new Text(
            _isLoginForm ? 'Create an account' : 'Have an account? Sign in',
            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
        onPressed: toggleFormMode);
  }

  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: new Text(_isLoginForm ? 'Login' : 'Create account',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        ));
  }
}
