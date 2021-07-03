import 'package:corona_class/models/covid_model.dart';
import 'package:corona_class/models/hospital_model.dart';
import 'package:corona_class/models/myth_model.dart';
import 'package:corona_class/network/endpoints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  String country;
  Network({this.country});

  // ignore: missing_return
  Future<Covid> getCoronaSummary() async {
    if (country == null) {
      country = "Nepal";
    }
    try {
      http.Response response;
      response = await http.get(requestSummary(country), headers: {
        "x-rapidapi-key": "757d02bda2msh9c9ccec72b99b9dp11907djsn658419b200ca"
      });
      var result = json.decode(response.body);

      String totalActiveCase = result["data"]["Active Cases"];
      String totalPostiveCase = result["data"]["Total Cases"];
      String totalRecovered = result["data"]["Total Recovered"];
      String totalDeaths = result["data"]["Total Deaths"];
      String newPositiveCase = result["data"]["New Cases"];
      String newRecovered = result["data"]["New Recovered"];
      String newDeaths = result["data"]["New Deaths"];
      String updateTime = result["last_update"];

      Covid covid = Covid(
        totalActiveCase: totalActiveCase,
        totalTestPostive: totalPostiveCase,
        totalRecovred: totalRecovered,
        totalDeaths: totalDeaths,
        newConfirmCase: newPositiveCase,
        newRecovered: newRecovered,
        newDeaths: newDeaths,
        country: country,
        updateTime: updateTime,
      );
      return covid;
    } catch (e) {
      print('Something went wrong');
    }
  }

  // ignore: missing_return
  Future<List<Hospital>> getHospitalList() async {
    try {
      http.Response response;
      response = await http.get(requestNepal(hospitalEndPoint));
      var result = json.decode(response.body);
      var hospitalListsData = result["data"];
      print(hospitalListsData);
      List<Hospital> hospitalList = [];
      for (int i = 0; i < hospitalListsData.length; i++) {
        hospitalList.add(
          Hospital(
            contactPerson: hospitalListsData[i]["contact_person"],
            contactPersonNumber: hospitalListsData[i]["contact_person_number"],
            hospitalName: hospitalListsData[i]["name"],
            bedCapacity: hospitalListsData[i]['capacity']['beds'],
            doctorCapacity: hospitalListsData[i]['capacity']['doctors'],
            isolationCapacity: hospitalListsData[i]['capacity']
                ['isolation_beds'],
            nurseCapacity: hospitalListsData[i]['capacity']['ventilators'],
            ventilatorCapacity: hospitalListsData[i]['capacity']['ventilators'],
          ),
        );
      }
      return hospitalList;
    } catch (e) {
      print(e);
    }
  }

  // ignore: missing_return
  Future<List<CovidMyths>> getMyth() async {
    try {
      http.Response response;
      response = await http.get(requestNepal(mythEndPoints));
      var result = json.decode(response.body);
      var covidMythsData = result["data"];
      List<CovidMyths> covidMyths = [];
      for (int i = 0; i < covidMythsData.length; i++) {
        covidMyths.add(CovidMyths(
            mythEnglish: covidMythsData[i]["myth"],
            mythNepali: covidMythsData[i]["myth_np"],
            realityEnglish: covidMythsData[i]["reality"],
            realityNepali: covidMythsData[i]["reality_np"],
            networkImage: covidMythsData[i]["image_url"]));
      }

      return covidMyths;
    } catch (e) {
      print('somewthing went wrong');
    }
  }
}
// ignore: missing_return
// Future<List<CovidMyths>> getMyth() async {
//   try {
//     http.Response response;
//     response = await http.get(requestNepal(mythEndPoints));
//     var result = json.decode(response.body);
//     // print(result['data']);
//     var covidMythsData = result['data'];
//     List<CovidMyths> covidMyths = [];
//     for (int i = 0; i <= covidMythsData.length; i++) {
//       // print(covidMythsData[i]['myth']);
//       covidMyths.add(CovidMyths(
//         mythEnglish: covidMythsData[i]["myth"],
//         mythNepali: covidMythsData[i]["myth_np"],
//         realityEnglish: covidMythsData[i]["reality"],
//         realityNepali: covidMythsData[i]["reality_np"],
//         networkImage: covidMythsData[i]["image_url"],
//       ));
//     }
//     return covidMyths;
//   } catch (e) {
//     print(e);
//   }
// }
