import 'package:flash_chat/component/side_menu.dart';
import 'package:flash_chat/utility/alert_error.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeScreen extends StatefulWidget {
  static String id = "Home_Screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) =>
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text('Login Successful',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold)))));
  }

  Future<bool> onBackPress() {
    return AlertAndError.alertButtonCloseCurrentScreen(
        AlertType.warning, context, "ARE YOU SURE ", "Do you want to Exit");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Color(0xFF4CAF50),
        ),
        body: Center(
          child: Text('NEWS FEED WILL APPEAR HERE, COMING SOON'),
        ),
      ),
    );
  }
}
