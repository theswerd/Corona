import 'package:Corona/Constants.dart';
import 'package:Corona/DataSources.dart';
import 'package:Corona/developedByPage.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mdi/mdi.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

class CoronaHomePage extends StatefulWidget {
  @override
  _CoronaHomePageState createState() => _CoronaHomePageState();
}

class _CoronaHomePageState extends State<CoronaHomePage>
    with TickerProviderStateMixin {
  PanelController menuPanelController;
  PanelController countryPanelController;
  Map selectedCountry = {};

  List<Widget> listItems;
  @override
  void initState() {
    super.initState();

    menuPanelController = new PanelController();
    countryPanelController = new PanelController();

    listItems = [
      GlobalData(),
      Container(height: 45),
      DataByCountry(this, countryPanelController)
    ];
  }

  set panelCountry(Map countryData) {
    setState(() {
      selectedCountry = countryData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("COVID-19"),
          leading: IconButton(
              icon: Icon(Icons.info),
              tooltip: "Menu",
              onPressed: () => menuPanelController.isPanelOpen
                  ? menuPanelController.close()
                  : menuPanelController.open()),
        ),
        body: SlidingUpPanel(
          controller: menuPanelController,
          minHeight: 0,
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.all(15),
          backdropEnabled: true,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          panel: Column(
            children: <Widget>[
              Center(
                child: Container(
                  height: 5,
                  width: 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.green),
                  //color: Colors.green,
                ),
              ),
              ListTile(
                title: Text("Data Sources"),
                subtitle: Text("Where our data comes from"),
                trailing: Icon(Mdi.database),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (c) => DataSourcesPage(),
                    maintainState: true,
                    fullscreenDialog: true)),
              ),
              ListTile(
                title: Text("About"),
                trailing: Icon(Mdi.account),
                onTap: ()=>Navigator.of(context).push(MaterialPageRoute(
                    builder: (c) => DevelopedBy(),
                    maintainState: true,
                    fullscreenDialog: true)),
              ),
              ListTile(
                title: Text("Contribute"),
                subtitle: Text("Add to our code"),
                trailing: Icon(Mdi.codeTags),
                onTap: ()=>launch(""),
              ),
            ],
          ),
          body: SlidingUpPanel(
            controller: countryPanelController,
            color: Theme.of(context).backgroundColor,
            backdropEnabled: true,
            minHeight: 0,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            panelBuilder: (c) {
              Map<String, double> pieChartData = {
                "Recovered": selectedCountry['recovered'],
                "Deaths": selectedCountry['deaths'],
                "Serious Condition": selectedCountry['serious'],
                "Critical Condition": selectedCountry['critical'],
              };
              print(selectedCountry['country'].toString());
              return Column(children: <Widget>[
                Container(
                  height: 10,
                ),
                Center(
                  child: Text(
                    selectedCountry['country'].toString(),
                    textAlign: TextAlign.center,
                    textScaleFactor: 2.1,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            FloatingActionButton(
                              heroTag: "Cases",
                              backgroundColor: Colors.blue,
                              child: Icon(Mdi.accountGroup),
                              onPressed: () {},
                            ),
                            Container(
                              height: 10,
                            ),
                            Text(selectedCountry['cases']
                                    .toString()
                                    .split('.')
                                    .first +
                                " Cases")
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            FloatingActionButton(
                              heroTag: "Recovered",
                              backgroundColor: Colors.green,
                              child: Icon(Icons.healing),
                              onPressed: () {},
                            ),
                            Container(
                              height: 10,
                            ),
                            Text(selectedCountry['recovered']
                                    .toString()
                                    .split('.')
                                    .first +
                                " Recovered")
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            FloatingActionButton(
                              heroTag: "Dead",
                              backgroundColor: Colors.redAccent,
                              child: Icon(Mdi.heartPulse),
                              onPressed: () {},
                            ),
                            Container(
                              height: 10,
                            ),
                            Text(selectedCountry['deaths']
                                    .toString()
                                    .split('.')
                                    .first +
                                " Deaths")
                          ],
                        ),
                      ]),
                ),
                Divider(),
                PieChart(dataMap: pieChartData, colorList: [
                  Colors.greenAccent,
                  Colors.redAccent,
                  Colors.orangeAccent,
                  Colors.yellowAccent
                ]),
              ]);
            },
            body: ListView(padding: EdgeInsets.all(25), children: listItems),
          ),
        ));
  }
}

class DataByCountry extends StatelessWidget {
  const DataByCountry(
    this.superPage,
    this.panelController,
  );

  final PanelController panelController;
  final _CoronaHomePageState superPage;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      child: FutureBuilder(
        future: get(
            "https://docs.google.com/spreadsheets/d/e/2PACX-1vR30F8lYP3jG7YOq8es0PBpJIE5yvRVZffOyaqC0GgMBN6yt0Q-NI8pxS7hd1F9dYXnowSC6zpZmW9D/pub?gid=0&output=csv"),
        builder: (c, s) {
          if (s.connectionState != ConnectionState.done) {
            return Container(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                  Divider(),
                  Text("Global Information",
                      textScaleFactor: 1.5, textAlign: TextAlign.center),
                ],
              ),
            );
          } else if (s.hasError) {
            return Container(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Mdi.emoticonSad,
                    size: 50,
                  ),
                  Divider(),
                  Text(
                      "Sorry, we are having trouble connecting to the internet",
                      textScaleFactor: 1.5,
                      textAlign: TextAlign.center),
                ],
              ),
            );
          } else {
            try {
              //dom.Element globals = doc.getElementById('0R3');
              List<List<dynamic>> rowsAsListOfValues =
                  const CsvToListConverter().convert(s.data.body);

              rowsAsListOfValues.removeRange(0, 6);

              List<Widget> columnChildren = List.generate(
                  rowsAsListOfValues.length,
                  (index) => ListTile(
                        title: Text(rowsAsListOfValues[index][0]),
                        subtitle: Text(
                          "Total Cases: " +
                              rowsAsListOfValues[index][1].toString(),
                        ),
                        trailing: Text((stringOfValueToDouble(
                                        rowsAsListOfValues[index][5]) /
                                    stringOfValueToDouble(
                                        rowsAsListOfValues[index][1]) *
                                    100)
                                .toStringAsFixed(0) +
                            "% Recovery Rate"),
                        onTap: () {
                          this.superPage.panelCountry = {
                            "country": rowsAsListOfValues[index][0],
                            "cases": stringOfValueToDouble(
                                rowsAsListOfValues[index][1]),
                            "deaths": stringOfValueToDouble(
                                rowsAsListOfValues[index][2]),
                            "serious": stringOfValueToDouble(
                                rowsAsListOfValues[index][3]),
                            "critical": stringOfValueToDouble(
                                rowsAsListOfValues[index][4]),
                            "recovered": stringOfValueToDouble(
                                rowsAsListOfValues[index][5])
                          };
                          panelController.open();
                        },
                      ));

              columnChildren.insert(
                  0,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Cases by country",
                        textAlign: TextAlign.center, textScaleFactor: 1.65),
                  ));
              return Column(
                children: columnChildren,
              );
            } catch (e) {
              print(e);
              return Container();
            }
          }
        },
      ),
    );
  }
}

double stringOfValueToDouble(dynamic value) {
  if (double.tryParse(value.toString()) != null) {
    return double.tryParse(value.toString());
  } else if (value == '-' || value == "") {
    return 0.toDouble();
  } else {
    return double.parse(value.toString().split(",").join());
  }
}

class GlobalData extends StatelessWidget {
  const GlobalData({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<Response>(
          future: get(
              "https://docs.google.com/spreadsheets/d/e/2PACX-1vR30F8lYP3jG7YOq8es0PBpJIE5yvRVZffOyaqC0GgMBN6yt0Q-NI8pxS7hd1F9dYXnowSC6zpZmW9D/pub?gid=0&output=csv"),
          builder: (c, s) {
            if (s.connectionState != ConnectionState.done) {
              return Container(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(child: CircularProgressIndicator()),
                    Divider(),
                    Text("Global Information",
                        textScaleFactor: 1.5, textAlign: TextAlign.center),
                  ],
                ),
              );
            } else if (s.hasError) {
              return Container(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Mdi.emoticonSad,
                      size: 50,
                    ),
                    Divider(),
                    Text(
                        "Sorry, we are having trouble connecting to the internet",
                        textScaleFactor: 1.5,
                        textAlign: TextAlign.center),
                  ],
                ),
              );
            } else {
              try {
                //dom.Element globals = doc.getElementById('0R3');
                List<List<dynamic>> rowsAsListOfValues =
                    const CsvToListConverter().convert(s.data.body);
                List totals = rowsAsListOfValues[3];
                //Cases	Deaths	Serious	Critical	Recovered
                print(totals);
                return Column(
                  children: <Widget>[
                    Center(
                        child: Text(
                      "Global Information",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.85,
                    )),
                    Divider(),
                    Text(totals[0].toString(),
                        textScaleFactor: 1.55, textAlign: TextAlign.center),
                    Text(
                      "Total Cases",
                      textScaleFactor: 1.55,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    Text(totals[1].toString(),
                        textScaleFactor: 1.55, textAlign: TextAlign.center),
                    Text(
                      "Total Deaths",
                      textScaleFactor: 1.55,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    Text(totals[5].toString(),
                        textScaleFactor: 1.55, textAlign: TextAlign.center),
                    Text(
                      "Total Unresolved",
                      textScaleFactor: 1.55,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    Text(totals[3].toString(),
                        textScaleFactor: 1.55, textAlign: TextAlign.center),
                    Text(
                      "Total Recovered",
                      textScaleFactor: 1.55,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ExpansionTile(
                      title: Text("View Chart"),
                      children: <Widget>[
                        PieChart(
                            chartType: ChartType.disc,
                            initialAngle: 30,
                            colorList: [
                              Colors.redAccent,
                              Colors.blueAccent,
                              Colors.greenAccent
                            ],
                            dataMap: {
                              "Deaths": double.parse(
                                      totals[1].toString().split(",").join() ??
                                          "0") ??
                                  0.toDouble(),
                              "Unresolved": double.parse(
                                      totals[5].toString().split(",").join() ??
                                          "0") ??
                                  0,
                              "Recovered": double.parse(
                                      totals[3].toString().split(",").join() ??
                                          "0") ??
                                  0.toDouble(),
                            })
                      ],
                    )
                    //Critical
                  ],
                );
              } catch (e) {
                print(e);
                return Container(
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Mdi.emoticonSad,
                        size: 50,
                      ),
                      Divider(),
                      Text("Sorry, we were unable to access our data sources",
                          textScaleFactor: 1.5, textAlign: TextAlign.center),
                    ],
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
