import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 30,
        height: 30,
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        alignment: Alignment.center,
      );
  }
  }

