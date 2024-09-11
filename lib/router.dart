import 'package:flutter/material.dart';
import 'package:video_call/screens/home_page.dart';
import 'package:video_call/screens/video_call_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomePage(),
      );

    case VideoCallScreen.routeName:
      var callId = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => VideoCallScreen(
          callId: callId,
        ),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Text('Page not found.'),
        ),
      );
  }
}
