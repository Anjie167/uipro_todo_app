import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uipro_todo_app/screens/hidden%20drawer/hidden_drawer.dart';
import 'data/shared preference/Task_saved.dart';
import 'data/theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await TaskerPreference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themProvider.themeMode,
          darkTheme: ThemeData.dark(),
          theme: MyTheme.lightTheme,
          home: const HiddenDrawer(),
        );
      });
}

