import 'package:flutter/material.dart';
import 'search.dart';

class App extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return new MaterialApp(
			title: "Purdue Directory",
			home: new SearchView(),
			theme: new ThemeData(
				primaryColor: new Color.fromARGB(255, 192, 142, 14),
				accentColor: new Color.fromARGB(255, 173, 31, 101),
			),
		);
	}
}