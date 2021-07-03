import 'package:example/view/main_page.dart';
import 'package:example/view_model/store_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // Single Provider
  // runApp(ChangeNotifierProvider.value(
    // value: StoreViewModel(),
    // child: MyApp(),
  // ));
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => StoreViewModel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Mask',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MainPage(),
    );
  }
}
