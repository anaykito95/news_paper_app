import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_paper/provider/provider_news.dart';
import 'package:news_paper/ui/widget/notice_grid_item.dart';
import 'package:provider/provider.dart';

class NewspaperDetail extends StatefulWidget {
  @override
  _NewspaperDetailState createState() => _NewspaperDetailState();
}

class _NewspaperDetailState extends State<NewspaperDetail> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100),
        () => Provider.of<ProviderNotices>(context, listen: false).synchronize(context));
  }

  @override
  Widget build(BuildContext context) {
    final notices = Provider.of<ProviderNotices>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            pinned: true,
            iconTheme: IconThemeData(color: notices.newspaperBase.actionColor),
            backgroundColor: notices.newspaperBase.bannerColor,
            actionsIconTheme: IconThemeData(color: notices.newspaperBase.actionColor),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.loop), onPressed: () => notices.synchronize(context))
            ],
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: notices.newspaperBase.actionColor),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Image.asset(
                  'assets/images/${notices.newspaperBase.assetBannerName}',
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
            expandedHeight: (MediaQuery.of(context).size.height * 0.15) + 60,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Container(
                height: 60,
                color: Colors.black45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: notices.newspaperBase.sections.length,
                  itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Chip(
                      elevation: 5,
                      label: Text(
                        notices.newspaperBase.sections[i].name,
                        style: TextStyle(color: notices.newspaperBase.actionColor),
                      ),
                      backgroundColor: notices.newspaperBase.color,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverLayoutBuilder(
            builder: (context, constraints) => notices.notices == null
                ? SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : notices.notices.length > 0
                    ? SliverPadding(
                        padding: const EdgeInsets.all(10.0),
                        sliver: SliverGrid(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                          delegate: SliverChildBuilderDelegate(
                            (ctx, i) => NoticeGridItem(
                              notice: notices.notices[i],
                            ),
                            childCount: notices.notices.length,
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
                              onPressed: () => notices.synchronize(context),
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
