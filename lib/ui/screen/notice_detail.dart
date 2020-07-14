import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:news_paper/provider/provider_news.dart';
import 'package:provider/provider.dart';

class NoticeDetail extends StatefulWidget {
  @override
  _NoticeDetailState createState() => _NoticeDetailState();
}

class _NoticeDetailState extends State<NoticeDetail> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100),
        () => Provider.of<Notice>(context, listen: false).synchronize(context));
  }

  @override
  Widget build(BuildContext context) {
    final notice = Provider.of<Notice>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: notice.newspaperBase.actionColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: notice.newspaperBase.color,
        elevation: 5,
        iconTheme: IconThemeData(color: notice.newspaperBase.actionColor),
      ),
      body: Container(
        color: Colors.black12.withOpacity(0.04),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Html(data: notice.html ?? ''),
        ),
      ),
    );
  }
}
