import 'package:flutter/material.dart';
import 'package:sms/sms.dart';
import 'package:unread_reader_flutter/common/drawer_widget.dart';
import 'package:unread_reader_flutter/constants.dart';
import 'package:unread_reader_flutter/pages/message.dart';
import 'package:unread_reader_flutter/services/modal.dart';
import 'package:unread_reader_flutter/services/sms_helper.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  bool _isLoading = true;
  final SmsQuery query = new SmsQuery();
  List<SmsThread> threads = List<SmsThread>();

  @override
  void initState() {
    super.initState();

    loadPage();
  }

  void loadPage() async {
    try {
      threads = await query.getAllThreads;

      setState(
        () {
          _isLoading = false;
        },
      );
    } catch (e) {
      print(e.toString());
      Modal.showInSnackBar(
        _scaffoldKey,
        e.toString(),
      );
      setState(
        () {
          _isLoading = false;
        },
      );
    }
  }

  Future<void> _refresh() async {
    loadPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(),
        drawer: DrawerWidget(),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: _refresh,
                key: _refreshIndicatorKey,
                child: ListView.builder(
                  itemCount: threads.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return _buildThreadWidget(threads[index]);
                  },
                ),
              ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Unread Reader',
        style: TextStyle(letterSpacing: 2.0),
      ),
      actions: [],
    );
  }

  Widget _buildThreadWidget(SmsThread thread) {
    int unreadMessagesCount = thread.messages
        .where((message) => message.isRead == false)
        .toList()
        .length;

    return InkWell(
      child: ListTile(
        leading: CircleAvatar(
          child: SMSHelper.getThreadContactImage(thread) ?? Icon(Icons.person),
        ),
        title: Text(
          SMSHelper.getThreadContactName(thread),
        ),
        subtitle: Text(thread.messages.length > MESSAGES_LIMIT
            ? '${MESSAGES_LIMIT}+ messages / ${unreadMessagesCount} unread'
            : '${thread.messages.length} messages / ${unreadMessagesCount} unread'),
        trailing: Icon(Icons.chevron_right),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessagePage(thread),
          ),
        );
      },
    );
  }
}
