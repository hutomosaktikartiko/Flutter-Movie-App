import 'package:flutter/material.dart';
import 'package:movie_app/utilities/app_style.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppStyle.bg,
          title: Text(
            "About",
            style: AppStyle.title,
          )),
      body: Container(
          color: AppStyle.bg,
          width: MediaQuery.of(context).size.height * 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5)),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'This is open source project, if you want to contribution just contact me on instagram or you can commit on this github respositori.',
                          style: TextStyle(color: Colors.white30, fontSize: 20),
                        ),
                      )),
                  width: MediaQuery.of(context).size.width * 1,
                ),
                SizedBox(height: 10),
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppStyle.bg2,
                        borderRadius: BorderRadius.circular(5)),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'See my Github',
                            style:
                                TextStyle(color: Colors.white30, fontSize: 20),
                          ),
                        )),
                    width: MediaQuery.of(context).size.width * 1,
                    height: 50,
                  ),
                  onTap: () async {
                    const url = 'https://github.com/hutomosaktikartiko';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                SizedBox(height: 10),
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppStyle.bg2,
                        borderRadius: BorderRadius.circular(5)),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Contact me on Instagram',
                            style:
                                TextStyle(color: Colors.white30, fontSize: 20),
                          ),
                        )),
                    width: MediaQuery.of(context).size.width * 1,
                    height: 50,
                  ),
                  onTap: () async {
                    const url = 'https://www.instagram.com/hutomooskoj/';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                SizedBox(height: 10),
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppStyle.bg2,
                        borderRadius: BorderRadius.circular(5)),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'API from www.themoviedb.org',
                            style:
                                TextStyle(color: Colors.white30, fontSize: 20),
                          ),
                        )),
                    width: MediaQuery.of(context).size.width * 1,
                    height: 50,
                  ),
                  onTap: () async {
                    const url = 'https://www.themoviedb.org/';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                )
              ],
            ),
          )),
    );
  }
}
