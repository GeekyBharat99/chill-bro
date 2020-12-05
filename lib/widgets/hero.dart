import 'package:flutter/material.dart';
import 'package:chill_bro/player.dart';

class MyHero extends StatefulWidget {
  final product;

  const MyHero({Key key, @required this.product}) : super(key: key);

  @override
  _MyHeroState createState() => _MyHeroState();
}

class _MyHeroState extends State<MyHero> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 3.0),
      height: MediaQuery.of(context).size.height / 1.5,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 25,
            left: 0,
            right: 0,
            top: 0,
            child: ClipPath(
              clipper: CustomClip(),
              child: FadeInImage.assetNetwork(
                placeholder: 'placeholder.png',
                image: widget.product["img_link"],
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            child: Container(
              color: Colors.black.withOpacity(.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 3.0,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              padding: EdgeInsets.all(5.0),
              child: IconButton(
                color: Colors.red,
                iconSize: 35.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayer(
                        link: widget.product["link"],
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.play_arrow),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 31);
    path.quadraticBezierTo(
        size.width / 2, size.height + 31, size.width, size.height - 31);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClip oldClipper) {
    return true;
  }
}
