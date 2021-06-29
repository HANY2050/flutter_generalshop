/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generalshops/screens/home_page.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  var my_product = [
    {
      "pro_id": "1",
      "pro_name": "rice and sand",
      "pro_desc": "rice and sand no one take",
      "pro_image": "assets/images/onboarding3.jpg",
    },
    {
      "pro_id": "2",
      "pro_name": "rice and sand",
      "pro_desc": "rice and sand no one take",
      "pro_image": "assets/images/onboarding3.jpg",
    },
    {
      "pro_id": "3",
      "pro_name": "rice and sand",
      "pro_desc": "rice and sand no one take",
      "pro_image": "assets/images/onboarding3.jpg",
    },
    {
      "pro_id": "3",
      "pro_name": "rice and sand",
      "pro_desc": "rice and sand no one take",
      "pro_image": "assets/images/onboarding3.jpg",
    },
    {
      "pro_id": "3",
      "pro_name": "rice and sand",
      "pro_desc": "rice and sand no one take",
      "pro_image": "assets/images/onboarding3.jpg",
    },
    {
      "pro_id": "3",
      "pro_name": "rice and sand",
      "pro_desc": "rice and sand no one take",
      "pro_image": "assets/images/onboarding3.jpg",
    },
    {
      "pro_id": "3",
      "pro_name": "rice and sand",
      "pro_desc": "rice and sand no one take",
      "pro_image": "assets/images/onboarding3.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("المفضلة"),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: GridView.builder(
            itemCount: my_product.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.8),
            itemBuilder: (BuildContext context, int index) {
              return SingleProducts(
                pro_id: my_product[index]["pro_id"],
                pro_name: my_product[index]["pro_name"],
                pro_image: my_product[index]["pro_image"],
                pro_desc: my_product[index]["pro_desc"],
              );
            }),
      ),
    );
  }
}

class SingleProducts extends StatelessWidget {
  final String pro_id;
  final String pro_name;
  final String pro_desc;
  final String pro_image;
  SingleProducts({this.pro_id, this.pro_name, this.pro_desc, this.pro_image});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      },
      child: new Container(
        margin: EdgeInsets.all(5),
        height: 400.0,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.topRight,
                child: new Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                )),
            new Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 2 - 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(pro_image))),
            ),
            Expanded(
              child: new Text(
                pro_name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Row(
              children: <Widget>[
                Text(pro_id),
                Expanded(child: Text("")),
                Text(pro_id),
                Icon(
                  Icons.star_border,
                  color: Colors.yellow,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/
