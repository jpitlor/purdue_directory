import 'package:flutter/material.dart';
import '../directory_api/person.dart';

class PersonView extends StatelessWidget {
	final Person _person;

	PersonView(this._person);

	void _call() {

	}

	void _text() {

	}

	void _email() {

	}

	void _goToWebsite() {

	}

	Widget _buildActions() {
		return new Row(
			mainAxisAlignment: MainAxisAlignment.spaceAround,
			children: <Widget>[
				new IconButton(icon: new Icon(Icons.phone), onPressed: _call),
				new IconButton(icon: new Icon(Icons.message), onPressed: _text),
				new IconButton(icon: new Icon(Icons.email), onPressed: _email),
				new IconButton(icon: new Icon(Icons.link), onPressed: _goToWebsite)
			],
		);
	}

	@override
	Widget build(BuildContext context) {
		return new Scaffold(
			appBar: new AppBar(
				title: new Text(_person.toString())
			),
			body: new Column(
				children: <Widget>[
					_buildActions(),
					// name
					// alias
					// nickname
					// email
					// campus
					// dept
					// title
					// school
					// fax
					// pager
					// phone
					// building
					// office
					// office hours
					// qualified name
					// comment
					// project
					// url
					// todo: pgp key
				],
			),
		);
	}
}
