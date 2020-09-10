import 'dart:async';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:markdown/markdown.dart' as md;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_paper/model/notice.dart';
import 'package:news_paper/provider/provider_news.dart';
import 'package:news_paper/ui/widget/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../util.dart';

class NoticeDetail extends StatefulWidget {
  @override
  _NoticeDetailState createState() => _NoticeDetailState();
}

class ItemTextScale {
  final String label;
  final double value;

  ItemTextScale(this.label, this.value);
}

class _NoticeDetailState extends State<NoticeDetail> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    Future.delayed(Duration(milliseconds: 100),
        () => Provider.of<Notice>(context, listen: false).synchronize(context));
  }

  ScrollController _scrollController;

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.shareAlt),
            onPressed: () => Share.share(notice.url),
          ),
          IconButton(
            icon: Icon(Icons.format_size),
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) => Container(
//                height: 60,
                color: Colors.white,
                child: ChangeNotifierProvider.value(
                  value: notice,
                  child: Consumer<Notice>(
                    builder: (context, provider, child) => ListTile(
                      title: Text('Tamaño del texto'),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ItemTextScale('Ch', 0.8),
                          ItemTextScale('N', 1.0),
                          ItemTextScale('M', 1.3),
                          ItemTextScale('L', 1.6),
                          ItemTextScale('XL', 2.0)
                        ]
                            .map((e) => GestureDetector(
                                  onTap: () => provider.changeTextScaleFactor(e.value),
                                  child: Chip(
                                    label: Text(
                                      e.label,
                                      textScaleFactor: e.value,
                                      style: TextStyle(
                                        color: e.value == provider.textScaleFactor
                                            ? Colors.white
                                            : Colors.black26,
                                      ),
                                    ),
                                    backgroundColor: e.value == provider.textScaleFactor
                                        ? Colors.black87
                                        : Colors.grey,
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
        backgroundColor: notice.newspaperBase.color,
        elevation: 5,
        iconTheme: IconThemeData(color: notice.newspaperBase.actionColor),
      ),
      body: Container(
        color: Colors.white,
        child: notice.html != null
            ? ListView(
                controller: _scrollController,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(notice.date, style: Theme.of(context).textTheme.caption),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    title: Text(
                      notice.title,
//                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    subtitle: Markdown(
                      data: html2md.convert(notice.summary),
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(4),
                      shrinkWrap: true,
                    ),
                  ),
                  Divider(
                    thickness: 0.8,
                    indent: 10,
                    endIndent: 10,
                  ),
                  MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: notice.textScaleFactor),
                    child: SafeArea(
                      top: false,
                      child: Markdown(
                        data: html2md.convert(notice.html),
                        controller: _scrollController,
                        shrinkWrap: true,
                        imageBuilder: (uri, title, alt) {
                          final imageUrl = uri.toString().startsWith('http')
                              ? uri.toString()
                              : '${notice.newspaperBase.baseUrl}${uri.toString()}';
//                      Future.delayed(
//                          Duration(milliseconds: 500), () => notice.setNoticeImage(imageUrl));
                          return GestureDetector(
                              child: Image.network(imageUrl),
                              onTap: () => showDialog(
                                  context: context,
                                  builder: (context) => MediaQuery.removeViewInsets(
                                        removeLeft: true,
                                        removeTop: true,
                                        removeRight: true,
                                        removeBottom: true,
                                        context: context,
                                        child: AlertDialog(
                                          title: ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            trailing: CircleAvatar(
                                              backgroundColor: Colors.white70,
                                              child: IconButton(
                                                icon: Icon(Icons.close),
                                                iconSize: 24,
                                                color: Colors.black87,
                                                onPressed: () => Navigator.of(context).pop(),
                                              ),
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.zero,
                                          insetPadding: EdgeInsets.zero,
                                          elevation: 0,
                                          backgroundColor: Colors.black54,
                                          content: Builder(builder: (context) {
                                            var height = MediaQuery.of(context).size.height;
                                            return Container(
                                              height: height - 20,
                                              width: double.infinity,
                                              child: ExtendedImage.network(
                                                imageUrl,
                                                fit: BoxFit.fitWidth,
                                                //enableLoadState: false,
                                                mode: ExtendedImageMode.gesture,
                                                initGestureConfigHandler: (state) => GestureConfig(
                                                  minScale: 0.9,
                                                  animationMinScale: 0.7,
                                                  maxScale: 3.0,
                                                  animationMaxScale: 3.5,
                                                  speed: 1.0,
                                                  inertialSpeed: 100.0,
                                                  initialScale: 0.9,
                                                  inPageView: true,
                                                  initialAlignment: InitialAlignment.center,
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      )));
                        },
                        imageDirectory: notice.newspaperBase.baseUrl,
//                    padding: const EdgeInsets.all(0),
                        onTapLink: (href) => launch(href),
                        builders: {
                          'h6': CenteredHeaderBuilder(),
                          'sub': SubscriptBuilder(),
                        },
                      ),
                    ),
                  ),
                ],
              )
            : ShimmerPlaceholder(),
      ),
    );
  }
}

class CenteredHeaderBuilder extends MarkdownElementBuilder {
  @override
  Widget visitText(md.Text text, TextStyle preferredStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(text.text, style: preferredStyle),
      ],
    );
  }
}

class SubscriptBuilder extends MarkdownElementBuilder {
  static const List<String> _subscripts = ['₀', '₁', '₂', '₃', '₄', '₅', '₆', '₇', '₈', '₉'];

  @override
  Widget visitElementAfter(md.Element element, TextStyle preferredStyle) {
    // We don't currently have a way to control the vertical alignment of text spans.
    // See https://github.com/flutter/flutter/issues/10906#issuecomment-385723664
    String textContent = element.textContent;
    String text = '';
    for (int i = 0; i < textContent.length; i++) {
      text += _subscripts[int.parse(textContent[i])];
    }
    return SelectableText.rich(TextSpan(text: text));
  }
}

class SubscriptSyntax extends md.InlineSyntax {
  static final _pattern = r'_([0-9]+)';

  SubscriptSyntax() : super(_pattern);

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    parser.addNode(md.Element.text('sub', match[1]));
    return true;
  }
}
