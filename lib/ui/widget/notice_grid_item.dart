import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_paper/provider/provider_news.dart';
import 'package:news_paper/ui/screen/notice_detail.dart';
import 'package:provider/provider.dart';

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
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 400),
                pageBuilder: (_, __, ___) =>
                    ChangeNotifierProvider.value(value: notice, child: NoticeDetail()),
              ),
            );
          },
          splashColor: Colors.white,
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
                flex: 1,
                child: Container(
                    color: Theme.of(context).cardColor,
                    child: ListTile(
                      title: Text(
                        notice.title ?? '-',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
//                      subtitle: Text(
//                        notice.summary ?? '-',
//                        maxLines: 3,
//                        overflow: TextOverflow.fade,
//                        textAlign: TextAlign.center,
//                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
