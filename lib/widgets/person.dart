import 'package:flutter/material.dart';
import '../purdue_directory/person.dart';

class PersonView extends StatefulWidget {
	final Person _person;

	PersonView(this._person);

	@override
	State<StatefulWidget> createState() => new _PersonViewState(_person);
}

class _PersonViewState extends State<PersonView> {
	Person _person;

	_PersonViewState(this._person);

	@override
	Widget build(BuildContext context) {
		return new Scaffold(
			appBar: new AppBar(
				title: new Text(_person.fullName)
			),
			body: new Column(
				children: <Widget>[
				],
			),
		);
	}
}