import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_paper/provider/provider_news.dart';
import 'package:news_paper/ui/screen/section_detail.dart';
import 'package:news_paper/ui/widget/notice_grid_item.dart';
import 'package:news_paper/ui/widget/placeholder.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';

class NewspaperDetail extends StatefulWidget {
  @override
  _NewspaperDetailState createState() => _NewspaperDetailState();
}

class _NewspaperDetailState extends State<NewspaperDetail> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100),
        () => Provider.of<ProviderNotices>(context, listen: false).synchronize());
  }

  @override
  Widget build(BuildContext context) {
    final notices = Provider.of<ProviderNotices>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          notices.newspaperBase.title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: notices.newspaperBase.actionColor),
        ),
        iconTheme: IconThemeData(color: notices.newspaperBase.actionColor),
        backgroundColor: notices.newspaperBase.bannerColor,
        actionsIconTheme: IconThemeData(color: notices.newspaperBase.actionColor),
        actions: <Widget>[
          Tooltip(
            message: 'Abrir en navegador',
            child: IconButton(
                icon: Icon(Icons.web), onPressed: () => launch(notices.newspaperBase.baseUrl)),
          ),
          Tooltip(
            message: 'Refrescar',
            child: IconButton(
                icon: Icon(Icons.refresh), onPressed: () => notices.synchronize(force: true)),
          )
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: notices.newspaperBase.actionColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Builder(
        builder: (context) => notices.notices == null
            ? ShimmerPlaceholder(itemCount: 5)
            : notices.notices.length > 0
                ? ListView.separated(
                    itemBuilder: (context, index) => ChangeNotifierProvider.value(
                          value: notices.notices[index],
                          child: NoticeListItem(),
                        ),
                    separatorBuilder: (context, index) => Divider(
                          thickness: 0.8,
                          color: EasyDynamicTheme.of(context).themeMode == ThemeMode.dark
                              ? Colors.white54
                              : Colors.black54,
                          indent: 10,
                          endIndent: 10,
                        ),
                    itemCount: notices.notices.length)
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('Sin noticias que mostrar'),
//                        FloatingActionButton(
//                          onPressed: () => notices.synchronize(force: true),
//                          child: Icon(FontAwesomeIcons.newspaper),
//                        )
                      ],
                    ),
                  ),
      ),
    );
  }
}
