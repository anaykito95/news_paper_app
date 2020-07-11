import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_paper/provider/provider_news.dart';
import 'package:provider/provider.dart';

class NewspaperDetail extends StatefulWidget {
  @override
  _NewspaperDetailState createState() => _NewspaperDetailState();
}

class _NewspaperDetailState extends State<NewspaperDetail> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(milliseconds: 100),
        () => Provider.of<ProviderNotices>(
              context,
              listen: false,
            ).synchronize(context));
  }

  @override
  Widget build(BuildContext context) {
    final notices = Provider.of<ProviderNotices>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(notices.newspaperBase.title),
            floating: true,
            flexibleSpace: Container(
              color: Theme.of(context).cardColor,
            ),
//            expandedHeight: 200,
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

class NoticeGridItem extends StatelessWidget {
  final Notice notice;

  const NoticeGridItem({Key key, this.notice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      clipBehavior: Clip.hardEdge,
      child: GridTile(
        child: InkWell(
//          onTap: () {
//            Navigator.of(context).push(
//              PageRouteBuilder(
//                transitionDuration: Duration(milliseconds: 400),
//                pageBuilder: (_, __, ___) => ChangeNotifierProvider.value(
//                    value: audiovisual,
//                    child: AudiovisualDetail(
//                      trending: true,
//                    )),
//              ),
//            );
//          },
          splashColor: Colors.white,
          child: Hero(
            tag: notice.id ?? notice.url.substring(notice.url.lastIndexOf('/')),
            child: Material(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: notice.imageUrl == null
                        ? Container(
                            color: Colors.black12,
                            child: Center(child: Icon(FontAwesomeIcons.solidNewspaper)))
                        : CachedNetworkImage(
                            imageUrl: notice.imageUrl,
                            placeholder: (_, __) => Container(
                                color: Colors.black12,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                )),
                            errorWidget: (ctx, _, __) => Container(
                                color: Colors.black12,
                                child: Center(
                                  child: Icon(FontAwesomeIcons.solidNewspaper),
                                )),
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        color: Theme.of(context).cardColor,
                        child: ListTile(
                          title: Text(
                            notice.title,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                          subtitle: Text(
                            notice.summary,
                            maxLines: 3,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
