import 'dart:math';

import 'package:flutter/material.dart';
import 'package:generalshops/animaterout.dart';
import 'package:generalshops/api/cart_api.dart';
import 'package:generalshops/api/helpers_api.dart';
import 'package:generalshops/product/home_products.dart';
import 'package:generalshops/product/product.dart';
import 'package:generalshops/product/product_category.dart';
import 'package:generalshops/screens/infoShops.dart';
import 'package:generalshops/screens/search.dart';
import 'package:generalshops/screens/single_product.dart';
import 'package:generalshops/screens/streams/dots_stream.dart';
import 'package:generalshops/screens/utilities/helperswidgets.dart';
import 'package:generalshops/screens/utilities/screen_utilities.dart';
import 'package:generalshops/screens/utilities/size_config.dart';

import 'cart_screen.dart';

class HomePage extends StatefulWidget {
  Product product;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  ScreenConfig screenConfig;
  TabController tabController;
  int currentIndex = 0;
  CartApi cartApi = CartApi();
  List<ProductCategory> productsCategories;
  PageController _pageController;
  HelpersApi helpersApi = HelpersApi();
  DotsStream dotsStream = DotsStream();
  bool _addingToFavorite = false;

  ValueNotifier<int> dotsIndex = ValueNotifier(1);

  HomeProductBloc homeProductBloc = HomeProductBloc();

  /*_HomePageState(this.user);*/

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 1,
      viewportFraction: 0.75,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    homeProductBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenConfig = ScreenConfig(context);
    return FutureBuilder(
      future: helpersApi.fetchCategories(),
      builder: (BuildContext context,
          AsyncSnapshot<List<ProductCategory>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return error("No connection made");
            break;
          case ConnectionState.waiting:
            return loading();
            break;

          case ConnectionState.done:
          case ConnectionState.active:
            if (snapshot.hasError) {
              return error(snapshot.error.toString());
            } else {
              if (!snapshot.hasData) {
                return error("No Data Found");
              } else {
                this.productsCategories = snapshot.data;
                homeProductBloc.fetchProducts
                    .add(this.productsCategories[0].category_id);
                return _screen(snapshot.data, context);
              }
            }
            break;
        }
        return Container();
      },
    );
  }

  Widget _screen(List<ProductCategory> categories, BuildContext context) {
    tabController = TabController(
      initialIndex: 0,
      length: categories.length,
      vsync: this,
    );
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  Text("معلومات المستخدم"),
                  Text("معلومات المستخدم"),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
            ),
            ListTile(
              title: Text('سلة المشتريات'),
              leading: Icon(Icons.card_travel),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
            ),
            ListTile(
              title: Text('المتاجر'),
              leading: Icon(Icons.domain_sharp),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeShop()));
              },
            ),
            ListTile(
              title: Text('خاصية البحث'),
              leading: Icon(Icons.search),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeSearch()));
              },
            ),
            /*   ListTile(
              title: Text('المفضلة'),
              leading: Icon(Icons.favorite),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new Favorite()));
              },
            ),*/
            ListTile(
              title: Text('اتصل بنا'),
              leading: Icon(Icons.phone_in_talk_outlined),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
            ),
            ListTile(
              title: Text('معلومات عنا'),
              leading: Icon(Icons.info_outline),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'Home',
          // ignore: deprecated_member_use
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeSearch()));
              },
            ),
          ),
        ],
        bottom: TabBar(
          indicatorColor: ScreenUtilities.mainBlue,
          labelStyle: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ), //For Selected tab
          unselectedLabelStyle: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),

          indicatorWeight: 2,
          controller: tabController,
          isScrollable: true,
          tabs: _tabs(categories),
          onTap: (int index) {
            homeProductBloc.fetchProducts
                .add(this.productsCategories[index].category_id);
          },
        ),
      ),
      body: Container(
        child: StreamBuilder(
          stream: homeProductBloc.productsStream,
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return error('No Think Is Working!');
                break;
              case ConnectionState.waiting:
                return loading();
                break;
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return error(snapshot.error.toString());
                } else {
                  if (!snapshot.hasData) {
                    return error('No Data');
                  } else {
                    return _drawProducts(snapshot.data, context);
                  }
                }
                break;
            }
            return Container();
          },
        ),
      ),
    );
  }

  List<Product> _randomTopProducts(List<Product> products) {
    List<int> indexes = [];
    Random random = Random();
    int counter = 3;
    List<Product> newProducts = [];
    do {
      int rnd = random.nextInt(products.length);
      if (!indexes.contains(rnd)) {
        indexes.add(rnd);
        counter--;
      }
    } while (counter != 0);

    for (int index in indexes) {
      newProducts.add(products[index]);
    }

    return newProducts;
  }

  Widget _drawProducts(List<Product> products, BuildContext context) {
    List<Product> topProducts = _randomTopProducts(products);
    return Container(
      padding: EdgeInsets.only(top: 24),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: topProducts.length,
                onPageChanged: (int index) {
                  dotsIndex.value = index;
                },
                itemBuilder: (context, position) {
                  return InkWell(
                    onTap: () {
                      _gotoSingleProduct(topProducts[position], context);
                    },
                    child: Card(
                      margin: EdgeInsets.only(left: 4, right: 4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                        /*child: Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(Icons.favorite),
                        ),*/
                        child: Image(
                          loadingBuilder: (context, image,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) {
                              return image;
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              topProducts[position].featuredImage()),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ValueListenableBuilder(
              valueListenable: dotsIndex,
              builder: (context, value, _) {
                return Container(
                  padding: EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _drawDots(topProducts.length, value),
                  ),
                );
              },
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 16),
                child: GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, position) {
                      return InkWell(
/*
                      onTap: () {
                   Navigator.pop(context);
                   Navigator.push(context,
                   MaterialPageRoute(builder: (context) => _gotoSingleProduct(products[position], context)));*/

                        onTap: () {
                          _gotoSingleProduct(products[position], context);
                        },
                        child: Column(
                          children: <Widget>[
                            /* Padding(
                              padding: EdgeInsets.only(),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 17,
                                ),
                              ),
                            ),*/
                            SizedBox(
                              child: Container(
                                /*  child: Image(
                                  loadingBuilder: (context, image,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) {
                                      return image;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  image: NetworkImage(
                                    products[position].featuredImage(),
                                  ),
                                  fit: BoxFit.cover,
                                ),*/
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                        decoration: new BoxDecoration(
                                            color: Colors.white),
                                        alignment: Alignment.center,
                                        height: 150,
                                        width: 150,
                                        child: Image.network(
                                            products[position].featuredImage(),
                                            fit: BoxFit.cover)),
                                    /* Padding(
                                      padding: EdgeInsets.only(right: 15),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: RaisedButton(
                                          child: (_addingToFavorite)
                                              ? CircularProgressIndicator()
                                              : Icon(
                                                  Icons.favorite_border,
                                                  size: 25,
                                                ),
                                          onPressed: () async {
                                            SharedPreferences pref =
                                                await SharedPreferences
                                                    .getInstance();
                                            int userId = pref.getInt('user_id');
                                            if (userId == null) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage2()));
                                            } else {
                                              setState(() {
                                                _addingToFavorite = true;
                                                return ('تم الاضافة الي سبة المشتريات');
                                              });
                                              await cartApi.addProductToCart(
                                                  widget.product.product_id);
                                              setState(() {
                                                _addingToFavorite = false;
                                              });
                                            }
                                            // To Do Add To Cart
                                          },
                                        ),
                                      ),
                                    ),*/
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                products[position].product_title,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                '\R.Y  ${products[position].product_price}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.subhead,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _drawDots(int qty, int index) {
    List<Widget> Wigdets = [];
    for (int i = 0; i < qty; i++) {
      Wigdets.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: (i == index)
                ? ScreenUtilities.mainBlue
                : ScreenUtilities.LightGrey,
          ),
          width: 10,
          height: 10,
          margin: (i == qty - 1)
              ? EdgeInsets.only(right: 10)
              : EdgeInsets.only(right: 10),
        ),
      );
    }
    return Wigdets;
  }

  List<Tab> _tabs(List<ProductCategory> categories) {
    List<Tab> tabs = [];

    for (ProductCategory category in categories) {
      tabs.add(
        Tab(
          text: category.category_name,
        ),
      );
    }
    return tabs;
  }

  void _gotoSingleProduct(Product product, BuildContext context) {
    Navigator.of(context).push(SlideRight(Page: SingleProduct(product)));
  }
}

/*class DataSearch extends SearchDelegate<DataSearch> {
  final name = [
    'hany',
    'mohamed',
    'kmal',
    'smeer',
    'ramy',
    'ramy',
    'haithem',
    'noon',
    'naerlin',
    'bosh',
    'shafoot',
  ];
  final recentName = [
    'hany',
    'mohamed',
  ];

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
                showSuggestions(context);
              }
            })
      ];
  // action for app bar

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back), onPressed: () => close(context, null),
        //close(context, null);
      );

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_city,
              size: 120,
            ),
            const SizedBox(
              height: 48,
            ),
            Text(
              query,
              style: TextStyle(
                color: Colors.black,
                fontSize: 64,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) => Container(
        color: Colors.black,
        child: FutureBuilder<List<Product>>(
          future: ProductsApi.fetchSearch(query),
          builder: (context, snapshot) {
            if (query.isEmpty) return buildNoSuggestions();
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError || snapshot.data.isEmpty) {
                  return buildNoSuggestions();
                } else {
                  return buildSuggestionsSuccess(snapshot.data.toList());
                }
            }
          },
        ),
      );

  Widget buildNoSuggestions() => Center(
        child: Text(
          'no suggestion',
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
      );

  Widget buildSuggestionsSuccess(List<Product> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          final queryText = suggestion.product_title;
          final remainingText = suggestion.product_price.toString();
          return ListTile(
            onTap: () {
              // query = suggestion;
              showResults(context);
              */ /* Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => ResultPage(),
                ),
              );*/ /*
            },
            leading: Icon(Icons.location_city),
            //title: Text(suggestion),
            title: RichText(
              text: TextSpan(
                text: queryText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: remainingText,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
}*/
