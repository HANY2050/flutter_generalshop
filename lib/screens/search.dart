import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generalshops/api/search_api.dart';
import 'package:generalshops/product/product.dart';
import 'package:generalshops/screens/single_product.dart';
import 'package:http/http.dart' as http;

import '../animaterout.dart';

class HomeSearch extends StatefulWidget {
  @override
  _HomeSearchState createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  List<Product> _product = List<Product>();
  List<Product> _productDisplay = new List<Product>();
  /*ScrollController _scrollController = new ScrollController();*/
  final scrollController = ScrollController();
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    fetchProduct().then((value) {
      setState(() {
        _product.addAll(value);
        _productDisplay = _product;

        _isLoading = false;
      });
    });
    scrollController.addListener(() {
      print(scrollController.position.pixels);
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        _productDisplay.length;
      }
    });

    super.initState();
  }

  /* @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('بحث عن منتج معين')),
      body: ListView.builder(
        controller: scrollController,
        itemBuilder: (context, index) {
          if (!_isLoading) {
            return index == 0 ? _searchBar() : _ListItem(index - 1);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
        itemCount: _productDisplay.length + 1,
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextField(
        decoration: InputDecoration(
            hintText: '   بحث ...', hintStyle: TextStyle(fontSize: 18)),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _productDisplay = _product.where((product) {
              var productTitle = product.product_title.toLowerCase();
              return productTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  void _gotoSingleProduct(Product product, BuildContext context) {
    Navigator.of(context).push(SlideRight(Page: SingleProduct(product)));
  }

  _ListItem(index) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(
          top: 32,
          bottom: 32,
          left: 16,
          right: 50,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(_productDisplay[index].featuredImage()),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.all(new Radius.circular(100.00)),
              ),
            ),
            /* Padding(
              padding: EdgeInsets.only(left: 50),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image:
                          NetworkImage(_productDisplay[index].featuredImage()),
                      fit: BoxFit.fill),
                ),
              ),
            ),*/
            Text(
              _productDisplay[index].product_title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              _productDisplay[index].product_description,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\R.Y ${_productDisplay[index].product_price.toString()}',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Text(
                'مشاهدة المزيد',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                _gotoSingleProduct(_productDisplay[index], context);
              },
            ),
          ],
        ),
      ),
    );
  }

  fech() async {
    final responce =
        await http.get('http://shop.myadeentrading.com/api/showProduct');
    if (responce.statusCode == 200) {
      setState(() {
        _productDisplay.add(json.decode(responce.body)['massage']);
      });
    } else {
      throw Exception('Requset Api Error');
    }
  }

  fetchfive() {
    for (int i = 0; i < 5; i++) {
      fech();
    }
  }
}
