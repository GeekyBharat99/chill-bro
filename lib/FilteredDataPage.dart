import 'package:admob_flutter/admob_flutter.dart';
import 'package:chill_bro/SearchPage.dart';
import 'package:chill_bro/widgets/movie_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilteredDataPage extends StatefulWidget {
  final products;
  final category;

  const FilteredDataPage({Key key, this.products, this.category})
      : super(key: key);
  @override
  _FilteredDataPageState createState() => _FilteredDataPageState();
}

class _FilteredDataPageState extends State<FilteredDataPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(widget.category["name"],
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700,
                color: Colors.red,
              )),
          centerTitle: true,
        ),
        body: GridView(
          children: [
            for (var product in widget.products)
              if (product["category"] ==
                  "https://your-own-api/category/${widget.category["id"]}/")
                MovieContainer(
                  product: product,
                ),
            AdmobBanner(
              adUnitId: 'ca-app-pub-8853110266408068/4550683598',
              adSize: AdmobBannerSize.ADAPTIVE_BANNER(
                width: MediaQuery.of(context).size.width ~/ 2.3,
              ),
            ),
          ],
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
        ),
      ),
    );
  }
}
