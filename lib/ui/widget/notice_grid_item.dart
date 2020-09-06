import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_paper/provider/provider_news.dart';
import 'package:news_paper/ui/screen/notice_detail.dart';
import 'package:provider/provider.dart';

class NoticeListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notice = Provider.of<Notice>(context, listen: false);
    return InkWell(
      highlightColor: notice.newspaperBase.actionColor,
      hoverColor: notice.newspaperBase.actionColor,
      splashColor: notice.newspaperBase.actionColor,
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 400),
            pageBuilder: (_, __, ___) =>
                ChangeNotifierProvider.value(value: notice, child: NoticeDetail()),
          ),
        );
      },
      child: Consumer<Notice>(
        builder: (context, notice, child) {
          final data = Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(notice.date,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: notice.imageUrl != null ? Colors.white : Colors.black87)),
              subtitle: Text(
                notice.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: notice.imageUrl != null ? Colors.white : Colors.black87),
              ),
            ),
          );
          return notice.imageUrl == null
              ? data
              : Stack(
                  children: <Widget>[
                    Builder(
                        builder: (context) => CachedNetworkImage(
                              imageUrl: notice.imageUrl,
                              color: Colors.black54,
                              colorBlendMode: BlendMode.darken,
                              placeholder: (_, __) => Container(
                                  color: Colors.black54,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  )),
                              errorWidget: (ctx, _, __) => Container(
                                  color: Colors.black54,
                                  child: Center(
                                    child: Icon(FontAwesomeIcons.solidNewspaper),
                                  )),
                              fit: BoxFit.cover,
                            )),
                    Positioned(
                      bottom: 1,
                      right: 1,
                      left: 1,
                      child: data,
                    ),
                  ],
                );
        },
      ),
    );
  }
}
