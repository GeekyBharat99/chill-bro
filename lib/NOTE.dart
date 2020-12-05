import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Note extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "NOTE",
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
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Text(
              "This project is for learning purpose only. All My Post are Freely Available On Internet Posted By Somebody Else, I'm Not VIOLATING Any COPYRIGHTED LAW, If Anything is Against LAW, Please Notify Me So That It Can Be Removed. I don't host or stream any TV channel or videos, I share free Links which are already on Google. if you found something wrong, let me know i will remove that.",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
