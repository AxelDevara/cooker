import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  CreatePost({this.img});

  final Image img;
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _formKey = GlobalKey<FormState>();

  String _title;
  String _description;
  int _price;
  DateTime _pickedDate;
  DateTime _date = DateTime.now();

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: _date,
        lastDate: _date.add(new Duration(days: 7)));
    if (picked != null && picked != _pickedDate) {
      _pickedDate = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        postTitle(),
        postDescription(),
        postPrice(),
        postDate(),
        RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text('Processing Data')));
            }
          },
          child: Text('Submit'),
        ),
      ],
    );
  }

  Widget postTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
            border: OutlineInputBorder(), hintText: 'Title'),
        validator: (value) => value.isEmpty ? 'Title can\'t be empty' : null,
        onSaved: (value) => _title = value.trim(),
      ),
    );
  }

  Widget postPrice() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: new InputDecoration(
            border: OutlineInputBorder(), hintText: 'Price'),
        validator: (value) => value.isEmpty ? 'Price can\'t be empty' : null,
        onSaved: (value) => _price = int.parse(value.trim()),
      ),
    );
  }

  Widget postDescription() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
            border: OutlineInputBorder(), hintText: 'Description'),
        validator: (value) =>
            value.isEmpty ? 'Description can\'t be empty' : null,
        onSaved: (value) => _description = value.trim(),
      ),
    );
  }

  Widget postDate() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.datetime,
        autofocus: false,
        decoration: new InputDecoration(hintText: 'Date'),
        validator: (value) => value.isEmpty ? 'Date can\'t be empty' : null,
        onTap: () {
          selectDate(this.context);
        },
      ),
    );
  }
}
