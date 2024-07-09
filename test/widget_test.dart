import 'package:flutter_test/flutter_test.dart';

void main() {
  String url = "www.google.com/api/{name}/hello/{score}";
  Map<String, String> mapForTest = {"name": "Noor", "score": "30"};

  // String replaceUrlFromMap(String link, Map<String, String> map) {
  //   if (map.isEmpty) {
  //     return link;
  //   } else {
  //     map.forEach((key, value) {
  //       link = link.replaceAll(RegExp(r'\{' + key + r'\}'), value);
  //     });
  //     return link;
  //   }
  // }

  String replaceUrlFromMap(String url, Map<String, dynamic> map) {
    return url.replaceAllMapped(RegExp(r'\{([\w\.]+)\}'), (match) {
      String key = match.group(1)!;
      var value = map;

      // Traverse the map for nested keys
      for (var part in key.split('.')) {
        if (value.containsKey(part)) {
          value = value[part];
        } else {
          return match.group(
              0)!; // Return the original placeholder if the key is not found
        }
      }

      // Check if value is a map and format it correctly
      // Format the map entries as {key: value}
      if (value.isNotEmpty) {
        String formatted =
            value.entries.map((e) => '${e.key}: ${e.value}').join(', ');
        return '{$formatted}';
      } else {
        return '{}'; // Handle empty map case
      }

      // Handle other types (e.g., strings)
      return value.toString();
    });
  }

  void main() {
    String url = "www.google.com/api/{name.ht}/hello/{score}";

    test("The Key was mapped", () {
      expect(
          replaceUrlFromMap(url, {
            "name": {"ht": "ht"},
            "score": "30"
          }),
          "www.google.com/api/{ht: ht}/hello/30");
    });
  }

  int counter = 0;

  test("Example", () {
    expect(counter, 0);
  });

  test("The Happy Scinro of MyFunction", () {
    expect(
        replaceUrlFromMap(url, mapForTest), "www.google.com/api/Noor/hello/30");
  });

  test("The Map is Empty", () {
    expect(
        replaceUrlFromMap(url, {}), "www.google.com/api/{name}/hello/{score}");
  });

  test("The Map has one enrty ", () {
    expect(replaceUrlFromMap(url, {"name": "Noor"}),
        "www.google.com/api/Noor/hello/{score}");
  });

  test("The Map Has same Key", () {
    expect(
        replaceUrlFromMap(
            url, {"name": "Noor", "name": "Ahmad", "score": "30"}),
        "www.google.com/api/Ahmad/hello/30");
  });

  test("The Key of map has empty value", () {
    expect(replaceUrlFromMap(url, {"name": "{}"}),
        "www.google.com/api/{}/hello/{score}");
  });

  test("The Key", () {
    expect(replaceUrlFromMap(url, {"name": ""}),
        "www.google.com/api/{}/hello/{score}");
  });

  test("The Key was empty", () {
    expect(replaceUrlFromMap(url, {"name": "John", "score": ""}),
        "www.google.com/api/John/hello/");
  });

  test("The Key was mapped", () {
    expect(
        replaceUrlFromMap(url, {
          "name": {"ht": "ht"},
          "score": "30"
        }),
        "www.google.com/api/{ht: ht}/hello/30");
  });
}
