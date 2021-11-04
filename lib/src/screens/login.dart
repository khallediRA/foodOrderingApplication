import 'package:FoodOrderingApp/src/helpers/commons.dart';
import 'package:FoodOrderingApp/src/helpers/screen_navigation.dart';
import 'package:FoodOrderingApp/src/providers/app.dart';
import 'package:FoodOrderingApp/src/providers/user_provider.dart';
import 'package:FoodOrderingApp/src/screens/home.dart';
import 'package:FoodOrderingApp/src/screens/register.dart';
import 'package:FoodOrderingApp/src/widgets/customtext.dart';
import 'package:FoodOrderingApp/src/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<ScaffoldState>();
  final myControllerEmail = TextEditingController();

  final myControllerPassword = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myControllerEmail.dispose();
    super.dispose();
  }

  @override
  final kHintTextStyle = TextStyle(
    color: Colors.grey,
    fontFamily: 'OpenSans',
  );

  final kLabelStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );

  final kBoxDecorationStyle = BoxDecoration(
    border: Border.all(color: grey, style: BorderStyle.solid),
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: myControllerEmail,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: white, fontFamily: "OpenSans"),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.email,
                  color: grey,
                ),
                hintText: "Enter your e-mail",
                hintStyle: kHintTextStyle),
          ),
        )
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: myControllerPassword,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: white, fontFamily: "OpenSans"),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.lock,
                  color: grey,
                ),
                hintText: "Enter your password",
                hintStyle: kHintTextStyle),
          ),
        )
      ],
    );
  }

  Widget _buildLoginButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () =>
            print(myControllerEmail.text + myControllerPassword.text),
        elevation: 5.0,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: grey, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.transparent,
        child: CustomText(
          designedtext: true,
          size: 30.0,
          fontweight: FontWeight.bold,
          text: "Login",
        ),
      ),
    );
  }

  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return loading
        ? Scaffold(body: Loading())
        : Scaffold(
            key: _key,
            body: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Color(0xFF5F3803),
                          Color(0xFFFEAC1E),
                          Color(0xFFFB9E46),
                        ],
                        stops: [
                          0.1,
                          0.4,
                          0.7,
                          0.9
                        ]),
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 120.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          designedtext: true,
                          size: 50.0,
                          color: white,
                          text: "Login",
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: _buildEmailTF()),
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: _buildPasswordTF(),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              width: double.infinity,
                              child: RaisedButton(
                                onPressed: () async {
                                  setState(() => loading = true);
                                  userProvider.email = myControllerEmail;
                                  userProvider.password = myControllerPassword;
                                  if (!await userProvider.signIn()) {
                                    setState(() => loading = false);
                                    _key.currentState.showSnackBar(SnackBar(
                                        content: Text("Login failed")));
                                    return;
                                  }
                                  setState(() => loading = false);
                                  userProvider.cleanControllers();
                                  changeScreenReplacement(context, Home());
                                },
                                elevation: 5.0,
                                padding: EdgeInsets.all(15.0),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: grey, style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                color: Colors.transparent,
                                child: CustomText(
                                  designedtext: true,
                                  size: 30.0,
                                  fontweight: FontWeight.bold,
                                  text: "Login",
                                ),
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.only(top: 15.0),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                designedtext: true,
                                text: "Not a member yet ? ",
                                size: 30,
                                fontweight: FontWeight.bold,
                              ),
                              GestureDetector(
                                  onTap: () =>
                                      changeScreen(context, Registation()),
                                  child: CustomText(
                                    designedtext: true,
                                    text: "Register Here !",
                                    color: black,
                                    underline: true,
                                    fontweight: FontWeight.bold,
                                    size: 25,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
