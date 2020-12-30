import 'package:admob_flutter/admob_flutter.dart';
import 'package:chill_bro/FilteredDataPage.dart';
import 'package:chill_bro/Navigation.dart';
import 'package:chill_bro/SearchPage.dart';
import 'package:chill_bro/widgets/Slider.dart';
import 'package:chill_bro/widgets/styles.dart';
import 'package:chill_bro/widgets/widgets.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chill_bro/Data/API.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _key = GlobalKey();

  List categories = null;
  List products = null;
  List slider = null;
  var note = null;
  var subscription;
  var isconnectedToInternet = false;

  AdmobInterstitial interstitialAd;

  errorMessage() {
    final bar = snackSample("Something went Wrong!");
    _key.currentState.showSnackBar(bar);
  }

  getSliderData() async {
    try {
      Response sliderResponse = await Dio().get(sliderUrl);
      setState(() {
        slider = sliderResponse.data;
      });
    } catch (e) {
      errorMessage();
    }
  }

  getCategoryData() async {
    try {
      Response categoryResponse = await Dio().get(categoriesUrl);
      setState(() {
        categories = categoryResponse.data;
      });
    } catch (e) {
      errorMessage();
    }
  }

  getProductData() async {
    try {
      Response productResponse = await Dio().get(productsUrl);
      setState(() {
        products = productResponse.data;
      });
    } catch (e) {
      errorMessage();
    }
  }

  getNote() async {
    try {
      Response noteResponse = await Dio().get(noteUrl);
      setState(() {
        note = noteResponse.data;
      });
    } catch (e) {
      errorMessage();
    }
  }

  checkConnectivityListener() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // Got a new connectivity status!
      if (result == ConnectivityResult.none) {
        setState(() {
          isconnectedToInternet = false;
        });
      } else {
        setState(() {
          isconnectedToInternet = true;
          getSliderData();
          getCategoryData();
          getProductData();
          getNote();
        });
      }
    });
  }

  @override
  initState() {
    super.initState();
    checkConnectivityListener();
    interstitialAd = AdmobInterstitial(
      adUnitId: 'ca-app-pub-8853110266408068/7754242065',
    );
  }

// Be sure to cancel subscription after you are done
  @override
  dispose() {
    interstitialAd.dispose();
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(),
                    ),
                  );
                })
          ],
          title: Text("CHILL BRO",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,
                color: Colors.red,
              )),
          centerTitle: true,
        ),
        body: isconnectedToInternet
            ? ListView(
                children: [
                  Column(
                    children: <Widget>[
                      slider == null
                          ? ProfilePageShimmer()
                          : Container(
                              child: SliderWidget(
                                slider: slider,
                              ),
                            ),
                      categories == null
                          ? Center(
                              child: Text(
                                "Loading...",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 5.0),
                                  height: 61,
                                  child: ListView.builder(
                                    itemCount: categories.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FilteredDataPage(
                                                category: categories[index],
                                                products: products,
                                              ),
                                            ),
                                          );
                                          interstitialAd.load();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            color: Colors.red,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.red,
                                                blurRadius: 2.5,
                                              )
                                            ],
                                          ),
                                          constraints:
                                              BoxConstraints(minWidth: 150),
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 7,
                                            vertical: 5.0,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Text(
                                            categories[index]["name"],
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline
                                                .apply(color: Colors.white),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: AdmobBanner(
                                    adUnitId:
                                        'ca-app-pub-8853110266408068/4550683598',
                                    adSize: AdmobBannerSize.BANNER,
                                  ),
                                )
                              ],
                            ),
                      if (products == null) VideoShimmer(),
                      if (products != null)
                        for (var category in categories)
                          Container(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      category["name"],
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      alignment: Alignment.centerRight,
                                      icon: Icon(
                                        Icons.arrow_forward,
                                        size: 30.0,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FilteredDataPage(
                                              category: category,
                                              products: products,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                if (products != null)
                                  Container(
                                    height: MediaQuery.of(context).size.height /
                                        3.8,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        for (var product in products)
                                          if (product["category"] ==
                                              "https://your-own-api/category/${category["id"]}/")
                                            MovieContainer(product: product),
                                      ],
                                    ),
                                  ),
                                SizedBox(
                                  height: 5.0,
                                )
                              ],
                            ),
                          ),
                      note == null
                          ? VideoShimmer()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: AdmobBanner(
                                    adUnitId:
                                        'ca-app-pub-8853110266408068/4550683598',
                                    adSize: AdmobBannerSize.LARGE_BANNER,
                                  ),
                                ),
                                Text(
                                  "Note:-",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${note["note"]}",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "No Internet!, Please connect to Internet.",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
        drawer: Drawer(
          child: MyNavigationDrawer(),
        ),
      ),
    );
  }
}
