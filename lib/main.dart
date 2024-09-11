import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call/providers/user_provider.dart';
import 'package:video_call/router.dart';
import 'package:video_call/screens/login_page.dart';

void main() {
  runApp(MultiProvider(
    
    providers: [ChangeNotifierProvider(create: (context)=>UserProvider())],
    child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const LoginPage(),
    );
  }
}