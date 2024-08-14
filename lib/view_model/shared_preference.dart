import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msbazaar/view/admin_view/screen/adHome_screen.dart';
import 'package:msbazaar/view/user_view/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceProvider with ChangeNotifier {
  String name = '';

  void adminORUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('name', '');
    name = sharedPreferences.getString('name')!;
    notifyListeners();
  }

  void get getAdminORUser {
    return adminORUser();
  }

//For User
  void setUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('name', 'User');
    name = sharedPreferences.getString('name')!;
    notifyListeners();
  }

  void get getUser {
    return setUser();
  }

  // for Admin
  void setAdmin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('name', 'Admin');
    name = sharedPreferences.getString('name')!;
    notifyListeners();
  }

  void get getAdmin {
    return setAdmin();
  }

//for Checking admin or User
  void checkAdminORUser(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    name = sharedPreferences.getString('name') ?? '';
    if (name == 'User') {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const CustomNavigationBar()), (route) => false);
    } else if (name == 'Admin') {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const AdHomeScreen()), (route) => false);
    } else {
      return;
    }
  }
}
