import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';

import 'person.dart';
import 'query.dart';

class Api {
  Future<List<Person>> search(Query query) async {
    http.Response httpResponse = await http.post('http://purdue.edu/directory/Advanced', body: {
      "SearchString": query.query,
      "SelectedSearchId": query.pool,
      "UsingParam": query.field,
      "CampusParam": query.campus,
      "DepartmentParam": query.department,
      "School Param": query.school
    });
    Document document = parser.parse(httpResponse.body);
    List<Element> results = document.getElementById('results').getElementsByTagName('li');
    List<Person> people;
    for (var e in results) {
      String fullName = e.getElementsByClassName("cn-name")[0].text;
      if (fullName == "") continue;

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

  String _findInDOM(Element hay, String needle) {
    List<Element> els = hay.getElementsByTagName("th");
    for (int i = 0; i < els.length; i++) {
      Element e = els[i];
      if (e.text.toLowerCase() == needle.toLowerCase()) {
        return hay.getElementsByTagName("td")[i - 1].text;
      }
    }
    return "";
  }

  String _getProfilePictureURL(String username) {
    return "https://nam.delve.office.com/mt/v3/people/profileimage?userId=$username%40purdue.edu&size=L";
  }
}
