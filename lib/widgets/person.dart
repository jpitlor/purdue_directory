import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../directory_api/person.dart';

class PersonView extends StatelessWidget {
  final Person _person;

  PersonView(this._person);

  Widget _buildColumn(IconData icon, String label, String value) {
    if (value.substring(value.indexOf(":") + 1) == "") return null;

    return new Column(
      children: <Widget>[
        new IconButton(
            icon: new Icon(icon),
            onPressed: () {
              launch(value);
            }),
        new Text(label)
      ],
    );
  }

  Widget _buildActions() {
    List<Widget> children = [
      _buildColumn(FontAwesomeIcons.phone, "Call", "tel:" + _person.otherPhone),
      _buildColumn(FontAwesomeIcons.envelope, "Text", "sms:" + _person.otherPhone),
      _buildColumn(FontAwesomeIcons.at, "Email", "mailto:" + _person.email),
      _buildColumn(FontAwesomeIcons.link, "URL", _person.url)
    ];
    children.removeWhere((w) => w == null);

    return new Padding(
        padding: new EdgeInsets.symmetric(vertical: 15.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: children,
        ));
  }

  Widget _buildRow(IconData iconData, String label, String property) {
    if (property == "") return null;

    Icon icon = iconData == null
        ? new Icon(FontAwesomeIcons.chevronRight, color: Colors.white)
        : new Icon(iconData);

    return new Padding(
        padding: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Padding(
              padding: new EdgeInsets.only(right: 15.0),
              child: icon,
            ),
            new Padding(
                padding: new EdgeInsets.only(right: 10.0),
                child: new Text(label,
                    style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0))),
            new Flexible(
                child: new Text(
              property,
              softWrap: true,
              maxLines: 3,
              style: new TextStyle(fontSize: 18.0),
            ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      _buildActions(),
      _buildRow(FontAwesomeIcons.userCircle, "Name", _person.toString()),
      _buildRow(null, "Alias", _person.alias),
      _buildRow(null, "Nickname", _person.nickname),
      _buildRow(null, "Qualified Name", _person.qualifiedName),
      _buildRow(FontAwesomeIcons.envelope, "Email", _person.email),
      _buildRow(FontAwesomeIcons.flag, "Campus", _person.campus),
      _buildRow(FontAwesomeIcons.sitemap, "Department", _person.department),
      _buildRow(null, "Title", _person.title),
      _buildRow(FontAwesomeIcons.building, "School", _person.school),
      _buildRow(FontAwesomeIcons.fax, "Fax", _person.fax),
      _buildRow(FontAwesomeIcons.phone, "Phone", _person.otherPhone),
      _buildRow(null, "Pager", _person.pager),
      _buildRow(FontAwesomeIcons.building, "Building", _person.building),
      _buildRow(null, "Office", _person.office),
      _buildRow(FontAwesomeIcons.clock, "Office Hours", _person.officeHours),
      _buildRow(FontAwesomeIcons.comment, "Comment", _person.comment),
      _buildRow(null, "Project", _person.project),
      _buildRow(FontAwesomeIcons.link, "URL", _person.url),
      // todo pgp key
    ];
    children.removeWhere((w) => w == null);

    return new Scaffold(
      appBar: new AppBar(title: new Text(_person.toString())),
      body: new ListView(children: children),
    );
  }
}
