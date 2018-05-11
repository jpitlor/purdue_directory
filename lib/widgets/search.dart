import 'package:flutter/material.dart';
import '../directory_api/fields.dart';
import '../directory_api/query.dart';
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


		Navigator.of(context).push(
			new MaterialPageRoute(
				builder: (context) => new ResultsView([])
			)
		);
	}

	Padding _buildRow(String label, Widget input) {
		return new Padding(
			padding: new EdgeInsets.all(16.0),
			child: new Row(
				mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				children: <Widget>[
					new Text(
						label, style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0)),
					new Expanded(
						child: new Padding(
							padding: new EdgeInsets.only(left: 16.0),
							child: input,
						),
					),
				],
			),
		);
	}

	TextField _buildInput(String hint, TextEditingController controller) {
		return new TextField(
			controller: controller,
			decoration: new InputDecoration.collapsed(
				hintText: hint,
				hintStyle: new TextStyle(fontSize: 18.0),
				border: new UnderlineInputBorder(),
			),
			style: new TextStyle(fontSize: 20.0, color: Colors.black),
		);
	}

	Padding _buildButton(IconData icon, String text, Function clickHandler) {
		return new Padding(
			padding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 64.0),
			child: new RaisedButton.icon(
				icon: new Icon(icon),
				label: new Text(text),
				onPressed: clickHandler,
				color: Theme
					.of(context)
					.primaryColor,
				textColor: Theme
					.of(context)
					.primaryTextTheme
					.title
					.color,
			),
		);
	}

	DropdownMenuItem _buildListItem(dynamic x) {
		return new DropdownMenuItem(
			value: x,
			child: new Text(_stringify(x), style: new TextStyle(fontSize: 18.0))
		);
	}

	String _stringify(dynamic x) {
		return x
			.toString()
			.substring(x.toString().indexOf(".") + 1)
			.replaceAllMapped(new RegExp('([A-Z])'), (match) => ' ${match[1]}')
			.replaceAllMapped(
			new RegExp('(.)(.*)'), (match) => '${match[1].toUpperCase()}${match[2]}');
	}

	Function _buildSetState(Function setter) {
		return (dynamic x) =>
			setState(() {
				setter(x);
			});
	}

	@override
	Widget build(BuildContext context) {
		return new Scaffold(
			appBar: new AppBar(title: new Text("Purdue Directory")),
			body: new ListView(
				children: <Widget>[
					_buildRow("Query", _buildInput("Your Query", _textController)),
					_buildRow(
						"Pool",
						new DropdownButton(
							value: _query.pool,
							items: Pool.values.map(_buildListItem).toList(),
							onChanged: _buildSetState(_query.setPool),
						)
					),
					_buildRow(
						"Field",
						new DropdownButton(
							value: _query.field,
							items: Field.values.map(_buildListItem).toList(),
							onChanged: _buildSetState(_query.setField)
						)
					),
					_buildRow(
						"Campus",
						new DropdownButton(
							value: _query.campus,
							items: Campus.values.map(_buildListItem).toList(),
							onChanged: _buildSetState(_query.setCampus),
						)
					),
					_buildRow(
						"Department",
						new DropdownButton(
							value: _query.department,
							items: Department.values.map(_buildListItem).toList(),
							onChanged: _buildSetState(_query.setDepartment),
						)
					),
					_buildRow(
						"School",
						new DropdownButton(
							value: _query.school,
							items: School.values.map(_buildListItem).toList(),
							onChanged: _buildSetState(_query.setSchool),
						)
					),
					_buildButton(Icons.search, "Search", this._handleSubmitted),
				],
			),
		);
	}
}
