import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:ticketapp/screens/login_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
       debugShowCheckedModeBanner: false,
      home:WebSocketTest(),
    );
  }
}

class WebSocketTest extends StatefulWidget {
  const WebSocketTest({Key? key}) : super(key: key);

  @override
  State<WebSocketTest> createState() => _WebSocketTestState();
}

class _WebSocketTestState extends State<WebSocketTest> {
  String connectStatus = "Not Connected";

  final stompClient = StompClient(
    config: StompConfig(
      url: 'ws://localhost:8080/socket',
      onConnect: (StompFrame frame) async {
        print('connected');
      },
      beforeConnect: () async {
        print('waiting to connect...');
        await Future.delayed(Duration(milliseconds: 200));
        print('connecting...');
      },
      onWebSocketError: (dynamic error) => print(error.toString()),
      //stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
      //webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
    ),
  );

  void sendMessage() {
    stompClient.send(
        destination: '/app/topic', body: 'Your message body', headers: {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 30),
          child: Text("Stomp Websocket Test", style: TextStyle(fontSize: 20)),
        ),
        Container(
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  stompClient.activate();
                  stompClient.subscribe(
                      destination: '/notification',
                      headers: {},
                      callback: (frame) {
                        // Received a frame for this subscription
                        print(frame.body);
                        print(frame.headers);
                      });
                },
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Connect",
                      style: TextStyle(fontSize: 20),
                    )))),
            Container(
            padding: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  //    stompClient.send(destination: '/app/topic', body: 'Your message body', headers: {});
                  // stompClient.send(destination: '/topic/app', body: 'Your message body', headers: {});
                  //  stompClient.send(destination: '/topic/app/chat', body: 'Your message body', headers: {});
                  // stompClient.send(destination: '/app/example', body: 'Your message body', headers: {});
                  stompClient.send(
                      destination: '/app/chat',
                      body: 'Your message body',
                      headers: {});
                  // stompClient.send(destination: '/example/app', body: 'Your message body', headers: {});
                },
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Test",
                      style: TextStyle(fontSize: 20),
                    )))),

        // Container(padding: EdgeInsets.only(bottom: 30),child: Text("Connection Status: " + connectStatus, style: TextStyle(fontSize: 15)),),

         Container(
            padding: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                         var message = {};

                        message["messageType"] ="CHAT";
                        message["content"] = "test";
                        message["sender"] = "jonathan";
                        message["time"] = "now";

                  String messageJson = jsonEncode(message);
                  print(messageJson);
            
                  
                  stompClient.send(
                      destination: '/app/chat.sendMessage',
                      body: messageJson,
                      headers: {});

                      
                },
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Test Message",
                      style: TextStyle(fontSize: 20),
                    )))),

              Container(
            padding: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                         var message = {};

                        message["user1"] = "jonathan";
                        message["user2"] = "awesome";

                  String messageJson = jsonEncode(message);
            
                  
                  stompClient.send(
                      destination: '/app/chat.createConversation',
                      body: messageJson,
                      headers: {});

                      
                },
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Test Conversation",
                      style: TextStyle(fontSize: 20),
                    )))),
      ],
    ));
  }

}

class Message {

  Message(this.content, this.messsageType, this.sender, this.time);
  
  String? messsageType;
  String? content;
  String? sender;
  String? time;


}


