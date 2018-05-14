import 'package:flutter/material.dart';
import '../directory_api/person.dart';
import 'person.dart';

class ResultsView extends StatelessWidget {
	final List<Person> _people;

	ResultsView(this._people);

	Widget toListItem(Person person, BuildContext context) {
		return new ListTile(
			title: new Text(person.fullName,
				style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
			subtitle: new Text(person.email),
			leading: new ImageIcon(new NetworkImage(person.profilePicture)),
			onTap: () {
				Navigator.of(context).push(
					new MaterialPageRoute(
						builder: (context) => new PersonView(person),
					)
				);
			},
		);
	}

	@override
	Widget build(BuildContext context) {
		return new Scaffold(
			appBar: new AppBar(
				title: new Text("Search Results")
			),
			body: new ListView(
				children: _people.map((p) => toListItem(p, context)).toList(),
			),
		);
	}
}