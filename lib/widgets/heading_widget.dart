import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadingWidget extends StatefulWidget {
  final IconData? iconData;
  final String? title;
  final String? subtitle;
  const HeadingWidget({super.key, this.iconData, this.title, this.subtitle});

  @override
  State<HeadingWidget> createState() => _HeadingWidgetState();
}

class _HeadingWidgetState extends State<HeadingWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: height / 9,
        width: width / 3.3,
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                widget.iconData,
                color: Colors.orange,
                size: 37,
              ),
              SizedBox(
                width: 4,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title.toString(),
                    style: GoogleFonts.abrilFatface(
                        color: Colors.white, fontSize: 15),
                  ),
                  Text(
                    widget.subtitle.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
