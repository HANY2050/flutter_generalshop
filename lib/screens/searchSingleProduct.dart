import 'package:flutter/material.dart';
import 'package:generalshops/product/search.dart';

class SearchSingle extends StatefulWidget {
  final Search search;
  SearchSingle(this.search);

  @override
  _SearchSingleState createState() => _SearchSingleState();
}

class _SearchSingleState extends State<SearchSingle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(widget.search.product_title),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'هاني سهيل للبرمجة تطبيقات الاندرويد والايفون',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
