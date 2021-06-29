import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generalshops/api/cart_api.dart';
import 'package:generalshops/cart/cart.dart';
import 'package:generalshops/screens/order.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartApi cartApi = CartApi();
  Cart cart;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Padding(
          padding: EdgeInsets.only(left: 78),
          child: MaterialButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderHome()));
            },
            color: Color(0xff0095ff),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              'اكمال عملية الشراء',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
        //Icon(Icons.title),
        Padding(
          padding: EdgeInsets.only(left: 78),
          child: Text(
            'اجمالي سلة المشتريات',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder(
          future: CartApi().fetchCart(),
          builder: (BuildContext context, AsyncSnapshot<Cart> snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.only(left: 110),
                child: Container(
                  child: Text(
                    '\R.Y ${snapshot.data.total.toString()}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );

              /*  return _drawCartRow(snapshot.data.cart.);*/
            } else if (snapshot.hasError) {
              return Padding(
                padding: EdgeInsets.only(left: 140),
                child: Container(
                  child: Text(
                    '\R.Y ${'0'}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }
            return CircularProgressIndicator();
          },
        ),
        Padding(
          padding: EdgeInsets.only(left: 87),
          child: Text(
            'افراغ سلة المشتريات',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder(
          future: CartApi().fetchCart(),
          builder: (BuildContext context, AsyncSnapshot<Cart> snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.only(left: 150),
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await cartApi.DeleteAllCarts(snapshot.data.id);
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
              );

              /*  return _drawCartRow(snapshot.data.cart.);*/
            } else if (snapshot.hasError) {
              return Text("");
            }
            return CircularProgressIndicator();
          },
        ),
      ],
      appBar: AppBar(
        title: Text('سلة المشتريات'),
      ),
      body: (isLoading)
          ? _showLoading()
          : FutureBuilder(
              future: CartApi().fetchCart(),
              builder: (BuildContext context, AsyncSnapshot<Cart> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text('No ConnectionState');
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'سلة المشتريات فارغة',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      );
                    } else {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data.cartItems.length,
                          itemBuilder: (BuildContext context, int position) {
                            return _drawProductRow(
                              snapshot.data.cartItems[position],
                            );
                          },
                        );
                      } else {
                        return Text('no data');
                      }
                    }
                    break;
                  default:
                    return Container();
                    break;
                }

                return Container();
              },
            ),
    );
  }

  Widget _showLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _drawCartRow(Cart cart) {
    IconButton(
      icon: Icon(Icons.delete),
      onPressed: () async {
        setState(() {
          isLoading = true;
        });
        await cartApi.DeleteAllCarts(cart.id);
        setState(() {
          isLoading = false;
        });
      },
    );
    Padding(
      padding: EdgeInsets.only(left: 85),
      child: Container(
        child: Text(
          '\R.Y ${cart.total.toString()}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _drawProductRow(CartItem cartItem) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(cartItem.product.product_title),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '\R.Y  ${cartItem.product.product_price.toString()}',
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(cartItem.product.featuredImage()),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await cartApi
                      .removeProductFromCart(cartItem.product.product_id);
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              Text(cartItem.qty.toString()),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await cartApi.addProductToCart(cartItem.product.product_id);
                  setState(() {
                    isLoading = false;
                  });
                },
              ),

              /* IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await cartApi.DeleteOneCarts(cartItem.product.product_id);
                  setState(() {
                    isLoading = false;
                  });
                },
              ),*/
            ],
          ),
        ],
      ),
    );
  }
}

/*class Total extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المتاجر'),
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
}*/
