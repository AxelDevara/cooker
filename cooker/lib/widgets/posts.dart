import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final record = Record.fromSnapshot(data);
  return Padding(
    key: ValueKey(record.title),
    padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
    child: Container(
      height: 200,
      width: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        title: Text(record.title),
        trailing: Text(record.price.toString()),
        onTap: () => print(record),
      ),
    ),
  );
}

class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Posts').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new CircularProgressIndicator();
          default:
            return SafeArea(
              child: new ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return _buildListItem(context, document);
                }).toList(),
              ),
            );
        }
      },
    );
  }
}

class Record {
  final String title;
  final int price;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['Title'] != null),
        assert(map['Price'] != null),
        title = map['Title'],
        price = map['Price'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$title:$price>";
}
