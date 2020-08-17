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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 5,
      clipBehavior: Clip.hardEdge,
      child: GridTile(
        footer: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${notice.title}',
            maxLines: 3,
            style: TextStyle(color: Colors.black87),
          ),
        ),
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
          child: Container(
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
        ),
      ),
    );
  }
}
