import 'package:flutter/material.dart';

import '../animaterout.dart';
import 'infoShops.dart';

class SingleShop extends StatefulWidget {
  @override
  _SingleShopState createState() => _SingleShopState();
}

class _SingleShopState extends State<SingleShop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('المنتجات'),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(SlideRight(Page: HomeShop()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
