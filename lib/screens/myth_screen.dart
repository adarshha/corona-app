import 'package:corona_class/models/myth_model.dart';
import 'package:corona_class/network/networks.dart';
import 'package:flutter/material.dart';

class MythScreen extends StatefulWidget {
  @override
  _MythScreenState createState() => _MythScreenState();
}

class _MythScreenState extends State<MythScreen> {
  Network _network;
  List<CovidMyths> covidMyths = [];
  bool loading = false;

  @override
  void initState() {
    loadMythsCovid();
    super.initState();
  }

  void loadMythsCovid() async {
    setState(() {
      loading = true;
    });
    _network = Network();
    covidMyths = await _network.getMyth();

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Myths About Covid-19'),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: covidMyths.length,
              itemBuilder: (context, position) {
                return Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Card(
                    elevation: 10.0,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Myths ${position + 1}',
                          style: TextStyle(fontSize: 32.0),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Myth English: ${covidMyths[position].mythEnglish}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Myth Nepali: ${covidMyths[position].mythNepali}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Reality English: ${covidMyths[position].realityEnglish}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Reality Nepali: ${covidMyths[position].realityNepali}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        covidMyths[position].networkImage != null
                            ? Image(
                                height: 400,
                                width: MediaQuery.of(context).size.width - 10,
                                image: NetworkImage(
                                    covidMyths[position].networkImage),
                              )
                            : SizedBox(
                                height: 10,
                              )
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
