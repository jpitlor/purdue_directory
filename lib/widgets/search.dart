import 'package:flutter/material.dart';
import '../purdue_directory/fields.dart';
import '../purdue_directory/query.dart';

class SearchView extends StatefulWidget {
	@override
	State createState() => new _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
	final TextEditingController _textController = new TextEditingController();
	Query query = Query("", Pool.values[0], SearchBy.values[0], Campus.values[0],
		Department.values[0], School.values[0]);

	void _handleSubmitted() {
		_textController.clear();
	}

	Widget _buildRow(String label, Widget input) {
		return new Padding(
			padding: new EdgeInsets.all(16.0),
			child: new Row(
				mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				children: <Widget>[
					new Text(label,
						style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0)),
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

	Widget _buildInput(String hint, TextEditingController controller) {
		return new TextField(
			controller: controller,
			decoration: new InputDecoration.collapsed(
				hintText: hint,
				hintStyle: new TextStyle(fontSize: 18.0),
				border: new UnderlineInputBorder(),
			),
			style: new TextStyle(
				fontSize: 20.0,
				color: Colors.black
			),
		);
	}

	Widget _buildDropdown(List choices, String value) {
		List<String> stringChoices = _mapToStrings(choices);

		return new DropdownButton(
			items: stringChoices.map((choice) => new DropdownMenuItem(
				child: new Text(choice,
					style: new TextStyle(fontSize: 18.0),
				)
			)).toList(),
			onChanged: (v) => this,
		);
	}

	Widget _buildButton(IconData icon, String text, Function clickHandler) {
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

	List<String> _mapToStrings(List pValues) {
		List<String> res = [];
		pValues.forEach((p) => res.add(p
			.toString()
			.substring(p.toString().indexOf(".") + 1)
			.replaceAllMapped(new RegExp('([A-Z])'), (match) => ' ${match[1]}') // Add spaces
			.replaceAllMapped(new RegExp('(.)(.*)'), (match) => '${match[1].toUpperCase()}${match[2]}'))); // Capitalize first letter
		return res;
	}

	@override
	Widget build(BuildContext context) {
		return new Scaffold(
			appBar: new AppBar(
				title: new Text("Purdue Directory")
			),
			body: new ListView(
				children: <Widget>[
					_buildRow("Query", _buildInput("Your Query", _textController)),
					_buildRow("Pool", _buildDropdown(Pool.values, query.school)),
					_buildRow("Field", _buildDropdown(SearchBy.values)),
					_buildRow("Campus", _buildDropdown(Campus.values)),
					_buildRow("Department", _buildDropdown(Department.values)),
					_buildRow("School", _buildDropdown(School.values)),
					_buildButton(Icons.search, "Search", this._handleSubmitted),
				],
			),
		);
	}
}