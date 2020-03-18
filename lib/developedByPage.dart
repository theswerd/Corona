import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:url_launcher/url_launcher.dart';

class DevelopedBy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About")),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(
          children: <Widget>[
            Text(
              "About Me",
              textAlign: TextAlign.center,
              textScaleFactor: 1.75,
            ),
            Divider(),
            Text(
              "This COVID-19 Tracker was created by Benjamin Swerdlow. I'm a sophomore at Santa Monica High School",
              textAlign: TextAlign.center,
              textScaleFactor: 1.45,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: "LinkedIn",
                    tooltip: "LinkedIn",
                    child: Icon(
                      Mdi.linkedin,
                      size: 36,
                    ),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    onPressed: () =>
                        launch("https://www.linkedin.com/in/benswerdlow"),
                  ),
                  FloatingActionButton(
                    heroTag: "Instagram",
                    tooltip: "Instagram",
                    child: Icon(Mdi.instagram, size: 36),
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                    onPressed: () =>
                        launch("https://www.instagram.com/ben_swerdlow/"),
                  ),
                  FloatingActionButton(
                    heroTag: "Github",
                    tooltip: "Github",
                    child: Icon(Mdi.githubCircle, size: 36),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    onPressed: () => launch("https://github.com/theswerd"),
                  )
                ],
              ),
            ),
            Divider(),
            Text("Languages/Frameworks/Standards Used",
                textScaleFactor: 1.75, textAlign: TextAlign.center),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[
                  FloatingActionButton.extended(
                    heroTag: "Material Design",
                    icon: Icon(
                      Mdi.materialDesign,
                      size: 36,
                    ),
                    label: Text("Material Design Standard"),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    onPressed: () => launch("https://material.io/design/"),
                  ),
                  Divider(),
                  FloatingActionButton.extended(
                    heroTag: "Google Sheets",
                    icon: Icon(
                      Mdi.googleSpreadsheet,
                      size: 36,
                    ),
                    label: Text("Google Sheets"),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    onPressed: () => launch("https://developers.google.com/sheets"),
                  ),
                  Divider(),
                  FloatingActionButton.extended(
                    heroTag: "Flutter",
                    label: Text("Flutter"),
                    icon: FlutterLogo(
                      colors: MaterialColor(0, {
                        100: Colors.white,
                        200: Colors.white,
                        300: Colors.white,
                        400: Colors.white,
                        500: Colors.white,
                        600: Colors.white,
                        700: Colors.white,
                        800: Colors.white,
                        900: Colors.white,
                      }),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    onPressed: () => launch("https://flutter.dev"),
                  )
                ],
              ),
            ),
            Text("Inspiration",
                textScaleFactor: 1.75, textAlign: TextAlign.center),
                Container(height: 10,),
            Wrap(
              alignment: WrapAlignment.center,
              children: <Widget>[
                FloatingActionButton.extended(
                        heroTag: "Inspiration",
                        icon: Icon(
                          Mdi.web,
                          size: 36,
                        ),
                        label: Text("ncov2019.live"),
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        onPressed: () => launch("https://ncov2019.live"),
                      ),
              ],
            ),
            Divider(),
            Text("Coming Soon",
                textScaleFactor: 1.75, textAlign: TextAlign.center),
            ListTile(
              title: Text("Maps"),
              subtitle: Text("Viewing Corona Spread in a map interface"),
              trailing: Icon(Mdi.map),
            ),
            ListTile(
              title: Text("Search"),
              subtitle: Text("Search for countries rather than scrolling"),
              trailing: Icon(Mdi.tableSearch),
            ),
            ListTile(
              title: Text("Detailed Analysis"),
              subtitle: Text("Individual state and province based analytics"),
              trailing: Icon(Mdi.chartGantt),
            )
          ],
        ),
      ),
    );
  }
}
