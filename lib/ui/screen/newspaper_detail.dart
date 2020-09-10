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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: notices.newspaperBase.sections.isNotEmpty,
            pinned: true,
            elevation: 5,
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
                    icon: Icon(Icons.refresh),
                    onPressed: () => notices.synchronize(force: true)),
              )
            ],
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: notices.newspaperBase.actionColor),
              onPressed: () => Navigator.of(context).pop(),
            ),
//            flexibleSpace: FlexibleSpaceBar(
//              collapseMode: CollapseMode.parallax,
//              background: Padding(
//                padding: const EdgeInsets.only(bottom: 60),
//              ),
//            ),
//            expandedHeight: (MediaQuery.of(context).size.height * 0.15) + 60,
            bottom: notices.newspaperBase.sections.isEmpty ? null : PreferredSize(
              preferredSize: Size.fromHeight(notices.newspaperBase.sections.isEmpty ? 0 : 60),
              child: Visibility(
                visible: notices.newspaperBase.sections.isNotEmpty,
                child: Container(
                  height: 60,
                  color: Colors.black45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: notices.newspaperBase.sections.length,
                    itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChangeNotifierProvider.value(
                        value: notices.newspaperBase.sections[i],
                        child: Consumer<Section>(
                          builder: (context, section, child) => GestureDetector(
                            onTap: section.url == null
                                ? null
                                : () => Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SectionDetail(
                                          section: section,
                                          base: notices.newspaperBase,
                                        ))),
                            child: Chip(
                              elevation: 5,
                              label: Text(
                                section.name,
                                style: TextStyle(color: notices.newspaperBase.actionColor),
                              ),
                              backgroundColor:
                                  section.enable ? notices.newspaperBase.color : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverLayoutBuilder(
            builder: (context, constraints) => notices.notices == null
                ? SliverFillRemaining(
                    child: ShimmerPlaceholder(
                      itemCount: 5,
                    ),
                  )
                : notices.notices.length > 0
                    ? SliverPadding(
                        padding: EdgeInsets.zero,
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (ctx, index) {
                              final int i = index ~/ 2;
                              return index.isEven
                                  ? ChangeNotifierProvider.value(
                                      value: notices.notices[i],
                                      child: NoticeListItem(),
                                    )
                                  : Divider(
                                      height: 0,
                                      thickness: 0.7,
                                      color: Colors.black87,
                                    );
                            },
                            semanticIndexCallback: (Widget widget, int localIndex) {
                              if (localIndex.isEven) {
                                return localIndex ~/ 2;
                              }
                              return null;
                            },
                            childCount: math.max(0, notices.notices.length * 2 - 1),
                          ),
                        ),
                      )
                    : SliverFillRemaining(
                        child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('Sin noticias que mostrar'),
                            FloatingActionButton(
                              onPressed: () => notices.synchronize(force: true),
                              child: Icon(FontAwesomeIcons.newspaper),
                            )
                          ],
                        ),
                      )),
          ),
        ],
      ),
    );
  }
}
