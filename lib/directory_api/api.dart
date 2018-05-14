import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';

import 'person.dart';
import 'query.dart';
import 'fields.dart';

class Api {
  static Future<List<Person>> search(Query query) async {
    http.Response httpResponse = await http.post('http://purdue.edu/directory/Advanced', body: {
      "SearchString": query.query,
      "SelectedSearchTypeId": Pool.values.indexOf(query.pool).toString(),
      "UsingParam": _stringify(query.field),
      "CampusParam": _stringify(query.campus),
      "DepartmentParam": _stringify(query.department),
      "SchoolParam": _stringify(query.school)
    });

    Document document = parser.parse(httpResponse.body);
    List<Element> results = document.getElementById('results').getElementsByTagName('li');

    if (results.isEmpty)
      throw Exception(document.getElementById('results').getElementsByTagName('p')[0].text);

    List<Person> people = [];
    for (var e in results) {
      String fullName = e.getElementsByClassName("cn-name")[0].text;
      if (fullName == "") continue;

      List<String> nameParts = fullName.split(" ");
      String alias = _findInDOM(e, "alias");
      String profilePicture = _getProfilePictureURL(alias);
      String nickname = _findInDOM(e, "nickname");
      String email = _findInDOM(e, "email");
      String campus = _findInDOM(e, "campus");
      String department = _findInDOM(e, "department");
      String title = _findInDOM(e, "title");
      String school = _findInDOM(e, "school");
      String fax = _findInDOM(e, "fax");
      String pager = _findInDOM(e, "pager");
      String phone = _findInDOM(e, "other phone");
      String building = _findInDOM(e, "building");
      String office = _findInDOM(e, "office");
      String officeHours = _findInDOM(e, "office hours");
      String qualifiedName = _findInDOM(e, "qualified name");
      String comment = _findInDOM(e, "comment");
      String project = _findInDOM(e, "project");
      String url = _findInDOM(e, "url");

      people.add(new Person(
          fullName,
          nameParts[0],
          nameParts.length == 3 ? nameParts[1] : "",
          nameParts.length == 3 ? nameParts[2] : nameParts[1],
          profilePicture,
          alias,
          nickname,
          email,
          campus,
          department,
          title,
          school,
          fax,
          pager,
          phone,
          building,
          office,
          officeHours,
          qualifiedName,
          comment,
          project,
          url));
    }

    return people;
  }

  static String _stringify(dynamic og) {
    return og.toString()
        .substring(og.toString().indexOf(".") + 1)
        .replaceAll("0", " ")
        .replaceAll("1", "/")
        .replaceAll("2", "-")
        .replaceAll("3", ".")
        .replaceAll("4", ",")
        .replaceAll("5", ":")
        .replaceAll("6", "(")
        .replaceAll("7", ")")
        .replaceAll("8", "'");
  }

  static String _findInDOM(Element hay, String needle) {
    List<Element> els = hay.getElementsByTagName("th");
    for (int i = 0; i < els.length; i++) {
      Element e = els[i];
      if (e.text.toLowerCase() == needle.toLowerCase()) {
        return hay.getElementsByTagName("td")[i - 1].text;
      }
    }
    return "";
  }

  static String _getProfilePictureURL(String username) {
    return "https://graph.microsoft.com/v1.0/users/$username@purdue.edu/photo/\$value";
  }
}
