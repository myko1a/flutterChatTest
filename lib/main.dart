import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/ChatScreen.dart';
import 'package:flutter_app/Screens/HomeScreen.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        ChatScreen.routeName: (context) => ChatScreen(),
      },
    );
  }
}
