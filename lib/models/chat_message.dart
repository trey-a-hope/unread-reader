import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage(
      {this.id,
      this.name,
      this.image,
      this.isSent,
      this.text,
      this.timestamp,
      this.animationController,
      this.isRead});

  final String id;
  final String name;
  final dynamic image;
  final bool isSent;
  final String text;
  final String timestamp;
  final AnimationController animationController;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(
                  child: isSent ? Icon(Icons.person) : image,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${name} - ${timestamp}',
                        style: TextStyle(color: Colors.grey)),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        text,
                        style: TextStyle(
                            color: isRead ? Colors.black : Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
