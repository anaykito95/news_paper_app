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

class NoticeDetail extends StatefulWidget {
  @override
  _NoticeDetailState createState() => _NoticeDetailState();
}

class PopupTextScale {
  final String label;
  final double value;

  PopupTextScale(this.label, this.value);
}

class _NoticeDetailState extends State<NoticeDetail> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100),
        () => Provider.of<Notice>(context, listen: false).synchronize(context));
  }

  final _stream = StreamController<double>.broadcast();

  @override
  void dispose() {
    super.dispose();
    _stream.close();
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
              backgroundColor: notice.newspaperBase.color,
              builder: (context) => Container(
                height: 80,
                child: ListTile(
//                  title: Text('Tamaño del texto'),
//                  trailing: Icon(FontAwesomeIcons.font),
                  title: StreamBuilder<double>(
                      stream: _stream.stream,
                      initialData: MediaQuery.of(context).textScaleFactor,
                      builder: (context, snapshot) {
                        return Slider(
                          value: snapshot.data,
                          onChanged: (value) => null,
                          activeColor: notice.newspaperBase.actionColor,
                          inactiveColor: Colors.grey,
                          onChangeEnd: (value) => _stream.add(value),
                          min: 0.8,
                          max: 2.0,
                        );
                      }),
                ),
              ),
            ),
          )
//          StreamBuilder<double>(
//              stream: _stream.stream,
//              initialData: MediaQuery.of(context).textScaleFactor,
//              builder: (context, snapshot) {
//                return PopupMenuButton<PopupTextScale>(
//                  icon: Icon(Icons.format_size),
//                  onSelected: (value) => _stream.add(value.value),
//                  itemBuilder: (context) => [
//                    PopupTextScale('Normal', 1.0),
//                    PopupTextScale('Medio', 1.2),
//                    PopupTextScale('Grande', 1.5),
//                    PopupTextScale('Muy Grande', 1.8)
//                  ].map((e) {
//                    return PopupMenuItem(
//                        value: e,
//                        child: Text(
//                          e.label,
//                          style: TextStyle(
//                              fontWeight:
//                                  e.value == snapshot.data ? FontWeight.bold : FontWeight.normal,
//                              color: e.value == snapshot.data ? Colors.black87 : Colors.grey),
//                        ));
//                  }).toList(),
//                );
//              }),
        ],
        backgroundColor: notice.newspaperBase.color,
        elevation: 5,
        iconTheme: IconThemeData(color: notice.newspaperBase.actionColor),
      ),
      body: Container(
        color: Colors.black12.withOpacity(0.04),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: notice.html != null
            ? StreamBuilder<double>(
                stream: _stream.stream,
                initialData: MediaQuery.of(context).textScaleFactor,
                builder: (context, snapshot) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: snapshot.data),
                    child: SafeArea(
                      child: Markdown(
                        data: html2md.convert(notice.html),
                        imageDirectory: notice.newspaperBase.baseUrl,
                        builders: {
                          'h6': CenteredHeaderBuilder(),
                          'sub': SubscriptBuilder(),
                        },
                      ),
                    ),
                  );
                })
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
