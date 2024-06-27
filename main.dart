import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

void main() async {
  final url = Uri.parse('https://en.wikipedia.org/wiki/Dracula');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final document = parser.parse(response.body);
    final bodyElement = document.querySelector('body');
    final bodyContent = _stripTags(bodyElement?.outerHtml ?? '');

    // final serviceUrl = Uri.parse('https://example.com/api');
    //await http.post(serviceUrl, body: bodyContent);

    print('Содержимое запроса без тегов:');
    print(bodyContent);
  } else {
    print('Ошибка при выполнении запроса. Код ошибки: ${response.statusCode}');
  }
}

String? _stripTags(String htmlString) {
  final element = parser.parseFragment(htmlString);
  return element.text;
}
