final String baseUrl =
    "https://worldometers.p.rapidapi.com/api/coronavirus/country/";
final String baseUrlNepal = "https://corona.askbhunte.com/api/";
final String baseUrlNepalVersion = "v1/";
final String mythEndPoints = "myths";
final String hospitalEndPoint = "hospitals";

Uri requestSummary(String country) {
  print("$baseUrl$country");
  return Uri.parse("$baseUrl$country");
}

Uri requestNepal(String endpoint) {
  print("$baseUrlNepal$baseUrlNepalVersion$endpoint");
  return Uri.parse("$baseUrlNepal$baseUrlNepalVersion$endpoint");
}
