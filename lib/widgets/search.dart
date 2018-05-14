import 'package:flutter/material.dart';
import '../directory_api/fields.dart';
import '../directory_api/query.dart';
import '../directory_api/person.dart';
import '../directory_api/api.dart';
import 'results.dart';

class SearchView extends StatefulWidget {
  @override
  State createState() => new _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _textController = new TextEditingController();
  Query _query = Query("", Pool.values[0], Field.values[0], Campus.values[0], Department.values[0],
      School.values[0]);

  void _handleSubmitted() async {
    _query.setQuery(_textController.text);

    try {
      showDialog(
          context: context,
          builder: (context) {
            return new AlertDialog(
              title: new Text("Searching Directory"),
              content: new Center(
                heightFactor: 2.0,
                child: new CircularProgressIndicator(),
              ),
            );
          });

      List<Person> results = await Api.search(_query);
      Navigator.of(context).pop();
      Navigator
          .of(context)
          .push(new MaterialPageRoute(builder: (context) => new ResultsView(results)));
    } on Exception catch (e) {
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (context) {
            return new AlertDialog(
              title: new Text("No Results Found"),
              content: new Text(e.toString()),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('OK'),
                  onPressed: Navigator.of(context).pop,
                ),
              ],
            );
          });
    }
  }

  Padding _buildRow(String label, String value, Widget input) {
    return new Padding(
      padding: new EdgeInsets.all(16.0),
      child: new Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        new Flexible(
          child: new RichText(
	          text: new TextSpan(
	              style: new TextStyle(fontSize: 18.0, color: Colors.black),
	              children: <TextSpan>[
	                new TextSpan(text: label, style: new TextStyle(fontWeight: FontWeight.bold)),
	                new TextSpan(text: value)
	              ]
	          ),
	          overflow: TextOverflow.clip,
	          maxLines: 1,
          )
        ),
        new Flexible(
          flex: 0,
          child: new Padding(
            padding: new EdgeInsets.symmetric(horizontal: 16.0),
            child: input,
          ),
        ),
      ]),
    );
  }

  TextField _buildInput(String hint, TextEditingController controller) {
    return new TextField(
      controller: controller,
      decoration: new InputDecoration.collapsed(
        hintText: hint,
        hintStyle: new TextStyle(fontSize: 22.0),
        border: new UnderlineInputBorder(),
      ),
      style: new TextStyle(fontSize: 22.0, color: Colors.black),
    );
  }

  Padding _buildButton(IconData icon, String text, Function clickHandler) {
    return new Padding(
      padding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 64.0),
      child: new RaisedButton.icon(
        icon: new Icon(icon),
        label: new Text(text),
        onPressed: clickHandler,
        color: Theme.of(context).primaryColor,
        textColor: Theme.of(context).primaryTextTheme.title.color,
      ),
    );
  }

  String _stringify(dynamic x) {
    return x
        .toString()
        .substring(x.toString().indexOf(".") + 1)
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

  _setQueryProperty(Function setter, String title, List values) async {
    var val = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return new SimpleDialog(
              title: new Text(title),
              children: values
                  .map((v) => new SimpleDialogOption(
                      onPressed: () {
                        Navigator.pop(context, v);
                      },
                      child: new Text(_stringify(v), style: new TextStyle(fontSize: 18.0))))
                  .toList());
        });

    setState(() {
      setter(val);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Purdue Directory")),
      body: new ListView(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.all(16.0),
            child: new Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              new Text("Query",
                  overflow: TextOverflow.ellipsis,
                  style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 22.0)),
              new Expanded(
                child: new Padding(
                  padding: new EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildInput("Your Query", _textController),
                ),
              ),
            ]),
          ),
          _buildRow(
            "Pool: ",
            _stringify(_query.pool),
            new RaisedButton(
              onPressed: () {
                _setQueryProperty(_query.setPool, "Set Pool", Pool.values);
              },
              child: new Text("Set Pool"),
            ),
          ),
          _buildRow(
            "Field: ",
            _stringify(_query.field),
            new RaisedButton(
              onPressed: () {
                _setQueryProperty(_query.setField, "Set Field", Field.values);
              },
              child: new Text("Set Field"),
            ),
          ),
          _buildRow(
            "Campus: ",
            _stringify(_query.campus),
            new RaisedButton(
              onPressed: () {
                _setQueryProperty(_query.setCampus, "Set Campus", Campus.values);
              },
              child: new Text("Set Campus"),
            ),
          ),
          _buildRow(
            "Department: ",
            _stringify(_query.department),
            new RaisedButton(
              onPressed: () {
                _setQueryProperty(_query.setDepartment, "Set Department", Department.values);
              },
              child: new Text("Set Department"),
            ),
          ),
          _buildRow(
            "School: ",
            _stringify(_query.school),
            new RaisedButton(
              onPressed: () {
                _setQueryProperty(_query.setSchool, "Set School", School.values);
              },
              child: new Text("Set School"),
            ),
          ),
          _buildButton(Icons.search, "Search", this._handleSubmitted),
        ],
      ),
    );
  }
}
