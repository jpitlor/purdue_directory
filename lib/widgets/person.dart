import 'package:flutter/material.dart';
import '../directory_api/person.dart';

class PersonView extends StatelessWidget {
	final Person _person;

	PersonView(this._person);

	@override
	Widget build(BuildContext context) {
		return new Scaffold(
			appBar: new AppBar(
				title: new Text(_person.toString())
			),
			body: new Column(
				children: <Widget>[
				],
			),
		);
	}
}
