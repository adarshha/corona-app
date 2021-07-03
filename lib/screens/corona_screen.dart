import 'package:corona_class/network/networks.dart';
import 'package:corona_class/screens/myth_screen.dart';
import 'package:flutter/material.dart';
import 'package:corona_class/models/covid_model.dart';

import 'hospital_screen.dart';

class CoronaScreen extends StatefulWidget {
  @override
  _CoronaScreenState createState() => _CoronaScreenState();
}

class _CoronaScreenState extends State<CoronaScreen> {
  Network network;
  Covid coronaSummary;
  bool isloading = true;
  @override
  void initState() {
    super.initState();
    requestCountry();
  }

  requestCountry({String country}) async {
    setState(() {
      isloading = true;
    });
    network = Network(country: country);
    coronaSummary = await network.getCoronaSummary();
    setState(() {
      isloading = false;
    });
    print(coronaSummary);
  }

  // ignore: missing_return
  List<DropdownMenuItem<String>> getDropDownItem() {
    List<DropdownMenuItem<String>> dropdownitems = [];
    List<String> countries = ["Nepal", "India", "Bhutan", "China"];
    for (int i = 0; i < countries.length; i++) {
      dropdownitems.add(DropdownMenuItem(
        value: countries[i],
        child: Text(countries[i]),
      ));
    }
    return dropdownitems;
  }

  void mythPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MythScreen();
    }));
  }

  void hospitalPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HospitalScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid-19 Status'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: isloading || coronaSummary == null
              ? CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Card(
                    elevation: 10.0,
                    child: Column(
                      children: [
                        Text(
                          'Covid Status of ${coronaSummary.country}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        MyTile(
                          leading: '🔬',
                          title: 'Total Active Case',
                          trailing: coronaSummary.totalActiveCase,
                        ),
                        MyTile(
                          leading: '🦠',
                          title: 'Total Test Positive',
                          trailing: coronaSummary.totalTestPostive,
                        ),
                        MyTile(
                          leading: '💪',
                          title: 'Total Recovered Case',
                          trailing: coronaSummary.totalRecovred,
                        ),
                        MyTile(
                          leading: '😭',
                          title: 'Total Deaths',
                          trailing: coronaSummary.totalDeaths,
                        ),
                        MyTile(
                          leading: '😷',
                          title: 'New Confirm Case',
                          trailing: coronaSummary.newConfirmCase,
                        ),
                        MyTile(
                          leading: '💪',
                          title: 'New Recovered Case',
                          trailing: coronaSummary.newRecovered,
                        ),
                        MyTile(
                          leading: '😭',
                          title: 'New Deaths',
                          trailing: coronaSummary.newDeaths,
                        ),
                        MyTile(
                          leading: '🕒',
                          title: 'Last Updated',
                          trailing: coronaSummary.updateTime,
                        ),

                        // =============DropDown=--------------

                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            value: coronaSummary.country,
                            onChanged: (value) {
                              requestCountry(country: value);
                            },
                            items: getDropDownItem(),
                          ),
                        ),

                        // ============Myth and HOspital--------------
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () => mythPage(),
                                child: Card(
                                  elevation: 10.0,
                                  child: Column(
                                    children: [
                                      Icon(Icons.fact_check),
                                      Text('Corona Myths'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () => hospitalPage(),
                                child: Card(
                                  elevation: 10.0,
                                  child: Column(
                                    children: [
                                      Icon(Icons.local_hospital),
                                      Text('Hospital Infos'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyTile extends StatelessWidget {
  String title;
  String leading;
  String trailing;
  MyTile({this.title, this.leading, this.trailing});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(this.leading),
      title: Text(this.title),
      trailing: Text(this.trailing),
    );
  }
}

// class MyMenu extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
