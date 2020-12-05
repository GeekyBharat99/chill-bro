import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class MyNavigationDrawer extends StatelessWidget {
  final _menutextcolor = TextStyle(
    color: Colors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );
  final _iconcolor = IconThemeData(
    color: Color(0xff303841),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Center(
            child: Image(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              image: AssetImage('logo.png'),
            ),
          ),
          Divider(
            thickness: 2.0,
          ),
          ListTile(
            leading: IconTheme(
              data: _iconcolor,
              child: Icon(Icons.info),
            ),
            title: Text("Contact Us", style: _menutextcolor),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed("/contactUs");
            },
          ),
          ListTile(
            leading: IconTheme(
              data: _iconcolor,
              child: Icon(Icons.group),
            ),
            title: Text("Telegram Group", style: _menutextcolor),
            onTap: () async {
              Navigator.of(context).pop();
              const url = 'https://t.me/joinchat/L1Aq2xou_JpyJJH5l1YgKw';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not open App';
              }
            },
          ),
          ListTile(
            leading: IconTheme(
              data: _iconcolor,
              child: Icon(Icons.share),
            ),
            title: Text("Share with Friends", style: _menutextcolor),
            onTap: () {
              // you can modify message if you want.
              Share.share(
                  "Hi, I found an awesome app\n\n*A complete Entertainment App* \n\ Watch Classic cartoons like Tom & Jerry, Sinchan, Doraemon.\n Watch Live Tv Channels, New Movies etc. \n\n* Download Link:-  * \n\n 👇👇👇👇👇\n\n  https://play.google.com/store/apps/details?id=com.BharatTiwari.chill_bro");
            },
          ),
          ListTile(
            leading: IconTheme(
              data: _iconcolor,
              child: Icon(Icons.rate_review),
            ),
            title: Text("Rate and Review", style: _menutextcolor),
            onTap: () async {
              Navigator.of(context).pop();
              const url =
                  'https://play.google.com/store/apps/details?id=com.BharatTiwari.chill_bro';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not open App';
              }
            },
          ),
          ListTile(
            leading: IconTheme(
              data: _iconcolor,
              child: Icon(Icons.info),
            ),
            title: Text("NOTE", style: _menutextcolor),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed("/note");
            },
          ),
        ],
      ),
    );
  }
}
