import 'dart:async';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:markdown/markdown.dart' as md;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class PopupTextScale {
  final String label;
  final double value;

  PopupTextScale(this.label, this.value);
}

class _NoticeDetailState extends State<NoticeDetail> with TickerProviderStateMixin {
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
                height: 60,
                color: Colors.white,
                child: ChangeNotifierProvider.value(
                  value: notice,
                  child: Consumer<Notice>(
                    builder: (context, provider, child) => Slider(
                      value: provider.textScaleFactor,
                      activeColor: Colors.black87,
                      inactiveColor: Colors.grey,
                      onChanged: (value) => provider.changeTextScaleFactor(value),
                      min: 0.8,
                      max: 2.0,
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
//        padding: notice.html == null ? const EdgeInsets.symmetric(horizontal: 10) : null,
        child: notice.html != null
            ? MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: notice.textScaleFactor),
                child: SafeArea(
                  top: false,
                  child: Markdown(
                    data: html2md.convert(notice.html),
                    imageBuilder: (uri, title, alt) => GestureDetector(
                        child: Image.network(uri.toString()),
                        onTap: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Image.network(
                                    uri.toString(),

                                    fit: BoxFit.fill,
                                  ),
                                  contentPadding: const EdgeInsets.all(0),
                                  clipBehavior: Clip.hardEdge,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(10)),
                                ))),
                    imageDirectory: notice.newspaperBase.baseUrl,
//                    padding: const EdgeInsets.all(0),
                    onTapLink: (href) => launch(href),
                    builders: {
                      'h6': CenteredHeaderBuilder(),
                      'sub': SubscriptBuilder(),
                    },
                  ),
                ),
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
