import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_paper/model/notice.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:news_paper/ui/screen/notice_detail.dart';
import 'package:provider/provider.dart';

class NoticeListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notice = Provider.of<Notice>(context, listen: false);
    return InkWell(
      highlightColor: notice.newspaperBase.actionColor.withOpacity(0.3),
      hoverColor: notice.newspaperBase.actionColor.withOpacity(0.3),
      splashColor: notice.newspaperBase.actionColor.withOpacity(0.3),
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
              trailing: Visibility(
                visible: notice.html != null,
                child: Icon(Icons.save, size: 12, color: Colors.grey),
              ),
              title: Text(notice.date,
                  style: Theme.of(context).textTheme.caption,
              ),
              subtitle: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    notice.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Visibility(
                      visible: notice.summary != null,
                      child: Markdown(
                        data: html2md.convert(notice.summary),
                        styleSheet: MarkdownStyleSheet(
                            p: Theme.of(context).textTheme.subtitle1
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(4),
                        shrinkWrap: true,
                      ))
                ],
              ),
            ),
          );
          return notice.imageUrl == null || true
              ? data
              : Container(
                  child: data,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
                    image: CachedNetworkImageProvider(notice.imageUrl),
                    fit: BoxFit.cover,
                  )));
        },
      ),
    );
  }
}
