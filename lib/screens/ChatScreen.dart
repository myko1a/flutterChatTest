import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/Message.dart';
import 'package:flutter_app/models/User.dart';

class ScreenArguments {
  final Message message;

  ScreenArguments(this.message);
}

class ChatScreen extends StatelessWidget {
  static const routeName = '/room';

  @override
  Widget build(BuildContext context) {
    ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.message.sender.name),
        backgroundColor: args.message.sender.color,
      ),
      body: ChatRoom(args.message.sender),
    );
  }
}

class ChatRoom extends StatefulWidget {
  final User user;
  ChatRoom(this.user);
  @override
  State<StatefulWidget> createState() => ChatRoomState(user);
}

class ChatRoomState extends State {
  final User user;
  String _newText = "";
  ChatRoomState(this.user);
  _createMessage(Message message, bool isCurrentUser) {
    return Row(
      children: <Widget>[
        isCurrentUser
            ?
        Icon(message.sender.icon, color: message.sender.color, size: 40)
            :
        Icon(message.sender.icon, color: message.sender.color, size: 0),
        Expanded(
            child: Container(
                margin: isCurrentUser
                    ?
                      EdgeInsets.only(top: 8, bottom: 8, left: 0)
                    :
                      EdgeInsets.only(top: 8, bottom: 8),
                width: MediaQuery.of(context).size.width * 0.5,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                decoration: BoxDecoration(
                borderRadius: isCurrentUser
                  ?
                    BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16))
                  :
                    BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                color: isCurrentUser
                  ?
                    Colors.lightGreenAccent
                  :
                    Colors.amberAccent,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          message.time,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16
                          )
                      ),
                      SizedBox(height: 4,),
                      Text(
                          message.text,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20
                          )
                      ),
                    ]
                )
            )
        ),
        isCurrentUser
            ?
              Icon(message.sender.icon, color: message.sender.color, size: 0)
            :
              Icon(message.sender.icon, color: message.sender.color, size: 40),
      ],
    );
  }

  void _sendNewMessage() {
    setState(() {
      DateTime now = DateTime.now();
      String convertedDateTime = "${now.hour.toString()}:${now.minute.toString()}";

      Message _m1 = Message();
      _m1.sender = currentUser;
      _m1.time = convertedDateTime;
      _m1.text = _newText;

      chats[user].add(_m1);

      rooms.firstWhere((element) => element.sender == user).text = _newText;

      _sendAnswerMessage(_newText);
      });
  }

  void _sendAnswerMessage(String text) async {
    Future.delayed(const Duration(milliseconds: 5000), () {
      DateTime now = DateTime.now();
      String convertedDateTime = "${now.hour.toString()}:${now.minute
          .toString()}";

      Message _m1 = Message();
      _m1.sender = user;
      _m1.time = convertedDateTime;
      _m1.text = '"' + _newText + '" ' + 'you wrote 5 sec ago.';

      chats[user].add(_m1);
      rooms
          .firstWhere((element) => element.sender == user)
          .text = _newText;
      setState(() {

      });
    });
  }

  _createMessageField(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              onChanged: (value) {
                _newText = value;
              },
              onSubmitted: (value) {
                _sendNewMessage();
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 30.0,
            color: currentUser.color,
            onPressed: _sendNewMessage,
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white70,
              child: ListView.builder(
                reverse: true,
                  padding: EdgeInsets.only(top: 16),
                  itemCount: chats[user].length,
                  itemBuilder: (BuildContext context, int index) {

                    final message = chats[user].reversed.toList()[index];
                    final  bool isCurrentUser = message.sender.id == currentUser.id;
                    return _createMessage(message, isCurrentUser);
                  })
            ),
          ),
          _createMessageField(),
        ]
      ),
    );
  }
}