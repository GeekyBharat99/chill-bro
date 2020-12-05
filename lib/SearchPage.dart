import 'package:admob_flutter/admob_flutter.dart';
import 'package:chill_bro/widgets/styles.dart';
import 'package:chill_bro/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chill_bro/Data/API.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController inputController = TextEditingController();
  GlobalKey<ScaffoldState> _key = GlobalKey();
  bool _isInputValid = true;
  var finalUrl;
  List searchedData = null;
  var isLoading = false;

  clearInput() {
    inputController.clear();
  }

  errorMessage() {
    final bar = snackSample("Something went Wrong!");
    _key.currentState.showSnackBar(bar);
  }

  search() async {
    try {
      setState(() {
        isLoading = true;
      });
      Response searchResponse = await Dio().get(finalUrl);
      setState(() {
        searchedData = searchResponse.data;
        isLoading = false;
      });
    } catch (e) {
      errorMessage();
      setState(() {
        isLoading = false;
      });
    }
  }

  sendRequest() {
    setState(() {
      inputController.text.isEmpty
          ? _isInputValid = false
          : _isInputValid = true;
    });
    if (_isInputValid) {
      FocusScope.of(context).unfocus();
      var urlToRequest = searchUrl + "${inputController.text}";

      setState(() {
        finalUrl = urlToRequest;
      });
      search();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Input field must not be blank.",
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            content: Text(
              "Please Enter something, it is required.",
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "CLOSE",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Search",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w700,
              color: Colors.red,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
        ),
        body: searchedData == null
            ? ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.0),
                    child: Theme(
                      data: ThemeData(),
                      child: TextField(
                        autofocus: true,
                        onEditingComplete: sendRequest,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        controller: inputController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                              )),
                          hintText: "Sinchan...",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: clearInput,
                          ),
                          hintStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          errorText:
                              _isInputValid ? null : "This field is required.",
                          errorStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (isLoading)
                    Column(
                      children: [
                        Center(
                            child: Text(
                          "Loading...",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                        VideoShimmer(),
                        VideoShimmer(),
                      ],
                    )
                ],
              )
            : searchedData.length == 0
                ? Center(
                    child: Text(
                      "No Results For '${inputController.text}'",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  )
                : GridView(
                    children: [
                      for (var product in searchedData)
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
