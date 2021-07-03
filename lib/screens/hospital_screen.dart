import 'package:corona_class/models/hospital_model.dart';
import 'package:corona_class/network/networks.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalScreen extends StatefulWidget {
  @override
  _HospitalScreenState createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  Network _network;
  List<Hospital> hospitalList = [];
  bool loading = false;

  Future<void> launched;

  @override
  void initState() {
    hospitalLists();
    super.initState();
  }

  void hospitalLists() async {
    setState(() {
      loading = true;
    });
    _network = Network();
    hospitalList = await _network.getHospitalList();

    setState(() {
      loading = false;
    });
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospitals For Covid-19 Patient'),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: hospitalList.length,
              itemBuilder: (context, position) {
                return Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Card(
                    elevation: 7.0,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Hospital ${position + 1}',
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Hospital Name: ${hospitalList[position].hospitalName}',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Contact Person: ${hospitalList[position].contactPerson}',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Contact Person Number: ${hospitalList[position].contactPersonNumber}',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.phone),
                          onPressed: () {
                            setState(() {
                              launched = _makePhoneCall(
                                  '${hospitalList[position].contactPersonNumber}');
                            });
                          },
                        ),

                        // IconButton(
                        //   onPressed: () {
                        // setState(() {
                        //   launched = _makePhoneCall(
                        //       '${hospitalList[position].contactPersonNumber}');
                        // });
                        //   },
                        // child: Column(
                        //   children: [
                        //     Text('Make phone call'),
                        //     // Text(
                        //     //   'Contact Person Number: ${hospitalList[position].contactPersonNumber}',
                        //     //   style: TextStyle(
                        //     //       fontSize: 16.0,
                        //     //       color: Colors.blue[700],
                        //     //       fontWeight: FontWeight.bold),
                        //     // ),
                        //   ],
                        // ),

                        SizedBox(
                          height: 5,
                        ),
                        Card(
                          color: Colors.blue.shade100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Hospital Capacity",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "Beds: ${hospitalList[position].bedCapacity}"),
                              Text(
                                  "Ventilators: ${hospitalList[position].ventilatorCapacity}"),
                              Text(
                                  "Isolation Bed: ${hospitalList[position].isolationCapacity}"),
                              Text(
                                  "Doctors: ${hospitalList[position].doctorCapacity}"),
                              Text(
                                  "Nurses:${hospitalList[position].nurseCapacity} "),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }

  // Network network;
  // @override
  // void initState() {
  //   getHospitalList();
  //   super.initState();
  // }

  // void getHospitalList() async {
  //   network = Network();
  //   var result = await network.getHospitalList();
  //   print(result);
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(child: Text('Hospital')),
  //   );
  // }

}
