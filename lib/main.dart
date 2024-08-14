import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:msbazaar/view/selection_screen.dart';
import 'package:msbazaar/view_model/data_provider.dart';
import 'package:msbazaar/view_model/favorite_provider.dart';
import 'package:msbazaar/view_model/shared_preference.dart';
import 'package:msbazaar/view_model/shop_provider.dart';
import 'package:msbazaar/view_model/upload_provider.dart';
import 'package:msbazaar/view_model/viewCart_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DataProvider>(
            create: (context) => DataProvider()),
        ChangeNotifierProvider<UploadProvider>(
            create: (context) => UploadProvider()),
        ChangeNotifierProvider<SharedPreferenceProvider>(
            create: (context) => SharedPreferenceProvider()),
        ChangeNotifierProvider<ShopProvider>(
            create: (context) => ShopProvider()),
        ChangeNotifierProvider<FavoriteProvider>(
            create: (context) => FavoriteProvider()),
        ChangeNotifierProvider<ViewCartProvider>(
            create: (context) => ViewCartProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ms Bazaar',
        home: SelectionScreen(),
      ),
    );
  }
}
