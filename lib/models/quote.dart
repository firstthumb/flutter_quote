import 'package:html_unescape/html_unescape.dart';
import 'package:meta/meta.dart';

class Quote {
  int id;
  String title;
  String content;
  String link;

  Quote(
      {@required this.id,
      @required this.title,
      @required this.content,
      @required this.link});

  Quote.fromJson(Map<String, dynamic> map)
      : this(
            id: map["ID"],
            title: _unescape.convert(map["title"]),
            content: _unescape.convert(
                map["content"].replaceAll(new RegExp('[(<p>)(</p>)]'), '')),
            link: map["link"]);

  Map<String, dynamic> toJson() {
    return {"ID": id, "title": title, "content": content, "link": link};
  }
}

final HtmlUnescape _unescape = new HtmlUnescape();
