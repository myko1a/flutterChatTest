import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/ChatScreen.dart';
import 'package:flutter_app/models/Message.dart';

class HomeScreen extends StatelessWidget {

  static const routeName = '/';

  List<ListTile> _createChatRoomsButtons(BuildContext context) {
    return rooms.map((chatRoom) => ListTile(
      leading: Icon(
          chatRoom.sender.icon,
          size: 32,
          color: chatRoom.sender.color
      ),
      title: Text(chatRoom.sender.name),
      subtitle: Text(chatRoom.text),
      onTap: () {
        Navigator.pushNamed(
          context,
          ChatScreen.routeName,
          arguments: ScreenArguments(
            chatRoom,
          ),
        );
      },
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat App'),),
      body: Container(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListView(
              scrollDirection: Axis.vertical,
              children: _createChatRoomsButtons(context)
          )
      ),
    );
  }
}