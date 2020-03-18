import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DataSourcesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Data Sources"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "All of the data shown on our main feed comes from",
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
              ),
              FlatButton(
                child: Text("bnonews.com"),
                color: Colors.green,
                onPressed: () => launch(
                    "https://bnonews.com/index.php/2020/02/the-latest-coronavirus-cases/"),
              ),
              Divider(
                height: 30,
              ),
              Text(
                "We are accessing it in a CSV format",
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
              ),
              FlatButton(
                child: Text("Here"),
                color: Colors.green,
                onPressed: () => launch(
                    "https://docs.google.com/spreadsheets/d/e/2PACX-1vR30F8lYP3jG7YOq8es0PBpJIE5yvRVZffOyaqC0GgMBN6yt0Q-NI8pxS7hd1F9dYXnowSC6zpZmW9D/pub?gid=0&output=csv"),
              ),
              Divider(
                height: 30,
              ),
              Text(
                "In future iterations, I plan on implementing a map, based on data taken from",
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
              ),
              FlatButton(
                child: Text("LatLong.net"),
                color: Colors.green,
                onPressed: () => launch(
                    "https://www.latlong.net/category/states-236-14.html"),
              ),
              
            ],
          ),
        ));
  }
}
