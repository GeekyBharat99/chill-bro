import 'package:admob_flutter/admob_flutter.dart';
import 'package:chill_bro/widgets/hero.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final product;

  const DetailsScreen({Key key, this.product}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              MyHero(
                product: widget.product,
              ),
              SizedBox(
                height: 11,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      widget.product["name"],
                      style: Theme.of(context).textTheme.headline,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    AdmobBanner(
                        adUnitId: 'ca-app-pub-8853110266408068/4550683598',
                        adSize: AdmobBannerSize.LARGE_BANNER),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
