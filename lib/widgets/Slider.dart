import 'package:admob_flutter/admob_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chill_bro/DetailsPage.dart';
import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  final slider;
  SliderWidget({this.slider});
  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: widget.slider.length + 1,
      itemBuilder: (BuildContext context, int itemIndex) {
        if (itemIndex == widget.slider.length) {
          return Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    blurRadius: 5.0,
                    color: Colors.grey[400],
                    offset: Offset(0, 3))
              ],
            ),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: AdmobBanner(
                      adUnitId: 'ca-app-pub-8853110266408068/4550683598',
                      adSize: AdmobBannerSize.ADAPTIVE_BANNER(
                        width: 250,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return Container(
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  blurRadius: 5.0,
                  color: Colors.grey[400],
                  offset: Offset(0, 3))
            ],
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    product: widget.slider[itemIndex],
                  ),
                ),
              );
            },
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'placeholder.png',
                      image: widget.slider[itemIndex]["img_link"],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      color: Colors.black45,
                    ),
                    child: Text(
                      widget.slider[itemIndex]["name"],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        initialPage: 0,
        height: MediaQuery.of(context).size.height / 3.8,
      ),
    );
  }
}
