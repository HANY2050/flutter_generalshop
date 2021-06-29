import 'package:flutter/material.dart';
import 'package:generalshops/api/info_shop_api.dart';
import 'package:generalshops/info_shop/info_shop.dart';
import 'package:generalshops/screens/SingleShop.dart';
import 'package:generalshops/screens/home_page.dart';

import '../animaterout.dart';

class HomeShop extends StatefulWidget {
  @override
  _HomeShopState createState() => _HomeShopState();
}

class _HomeShopState extends State<HomeShop> {
  @override
  void initState() {
    super.initState();
    InfoShopApi().fetchInfoShop(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المتاجر'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(SlideRight(Page: HomePage()));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder<List<InfoShop>>(
        future: InfoShopApi().fetchInfoShop(1),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Card(
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    final url = snapshot.data[i].info_shop_image_profile;
                    // Text(snapshot.data[i].info_shop_image_profile);
                    return Padding(
                      padding: EdgeInsets.only(
                        right: 0.0,
                        left: 12.0,
                        top: 30.0,
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SingleShop()));
                        },
                        subtitle: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'http://shop.myadeentrading.com/public/$url'),
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ),
                            Text(
                              snapshot.data[i].info_shop_shop_name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          } else if (snapshot.hasError) {
            return Text("ssgsg");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
