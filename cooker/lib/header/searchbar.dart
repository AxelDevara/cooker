import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 96,),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0.0),
          child: Container(
              height: 30,
              width: MediaQuery.of(context).size.width - 50,
              child: searchInput()),
        ),
      ],
    );
  }

  Widget searchInput() {
    return new TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: new InputDecoration(
        prefix: Icon(Icons.search),
          contentPadding: EdgeInsets.all(16),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          labelText: 'Search'),
    );
  }
}
