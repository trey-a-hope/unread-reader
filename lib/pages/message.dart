import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sms/sms.dart';
import 'package:intl/intl.dart';
import 'package:unread_reader_flutter/models/chat_message.dart';
import 'package:unread_reader_flutter/services/modal.dart';
import 'package:unread_reader_flutter/services/sms_helper.dart';
import '../constants.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final String timeFormat = 'MMM d, yyyy hh:mm a';

class MessagePage extends StatelessWidget {
  MessagePage(this.thread);

  final SmsThread thread;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(thread.contact.fullName ?? 'NO NAME'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              Modal.showAlert(context, 'Help',
                  'Messages that have been unread will be in color.\n\nEach thread pulls back at most ${MESSAGES_LIMIT} messages to save loading time.');
            },
          )
        ],
      ),
      body: ChatScreen(this.thread),
    );
  }
}

class ChatScreen extends StatefulWidget {
  ChatScreen(this.thread);

  final SmsThread thread;

  @override
  State createState() => ChatScreenState(this.thread);
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  ChatScreenState(this.thread);

  final SmsThread thread;
  List<ChatMessage> _messages = List<ChatMessage>();

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < SMSHelper.messageLimit(thread); i++) {
      SmsMessage messageData = thread.messages[i];
      ChatMessage message = ChatMessage(
        id: messageData.id.toString(),
        name: messageData.kind == SmsMessageKind.Sent
            ? 'Me'
            : SMSHelper.getThreadContactName(thread),
        isSent: messageData.kind == SmsMessageKind.Sent,
        image: SMSHelper.getThreadContactImage(thread) ?? Icon(Icons.person),
        text: messageData.body,
        timestamp: DateFormat(timeFormat).format(messageData.date),
        animationController: AnimationController(
          duration: Duration(milliseconds: 700),
          vsync: this,
        ),
        isRead: messageData.isRead,
      );

      setState(() {
        //Add message if it is new.
        if (_isNewMessage(message)) {
          _messages.insert(0, message);
        }
      });

      message.animationController.forward();
    }

    _messages = _messages.reversed.toList();
  }

  bool _isNewMessage(ChatMessage cm) {
    for (ChatMessage chatMessage in _messages) {
      if (chatMessage.id == cm.id) {
        return false;
      }
    }
    return true;
  }

  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
          ],
        ),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[200],
                  ),
                ),
              )
            : null);
  }
}
