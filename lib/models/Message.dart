import 'package:flutter_app/models/User.dart';
import 'package:flutter/material.dart';

class Message {
   User sender;
   String time;
   String text;

  Message({
    this.sender,
    this.time,
    this.text
  });
}

final User currentUser = User(
    id: 0,
    name: 'Current User',
    color: Colors.deepPurple,
    icon: Icons.account_circle,
);

final User redRoom = User(
    id: 1,
    name: 'Red Room',
    color: Colors.red,
    icon: Icons.adb
);

final User greenRoom = User(
    id: 2,
    name: 'Green Room',
    color: Colors.green,
    icon: Icons.adb
);

final User blueRoom = User(
    id: 3,
    name: 'Blue Room',
    color: Colors.blue,
    icon: Icons.adb
);

//example rooms on home screen
List<Message> rooms = [
  Message(
    sender: redRoom,
    time: '10:12',
    text: 'test'
  ),
  Message(
      sender: greenRoom,
      time: '04:00',
      text: 'Good bye'
  ),
  Message(
      sender: blueRoom,
      time: '',
      text: ''
  )
];

Map<User, List<Message>> chats = {
  redRoom: [
    Message(
      sender: currentUser,
      time: '09:50',
      text: '''hello 
      Lorem Ipsum is simply dummy text of the printing and typesetting industry. '''
    ),
    Message(
        sender: redRoom,
        time: '10:00',
        text: 'Hi!'
    ),
    Message(
        sender: redRoom,
        time: '10:05',
        text: ';)'
    ),
    Message(
        sender: redRoom,
        time: '10:12',
        text: 'test'
    ),
  ],
  greenRoom: [Message(
      sender: greenRoom,
      time: '04:00',
      text: 'Good bye'
  )],
  blueRoom: []
};

