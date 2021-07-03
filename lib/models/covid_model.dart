class Covid {
  String totalActiveCase = "";
  String totalTestPostive = "";
  String totalRecovred = "";
  String totalDeaths = "";
  String newConfirmCase = "";
  String newRecovered = "";
  String newDeaths = "";
  String country = "";
  String updateTime = "";

  Covid(
      {this.country,
      this.newConfirmCase,
      this.newDeaths,
      this.newRecovered,
      this.totalActiveCase,
      this.totalDeaths,
      this.totalRecovred,
      this.totalTestPostive,
      this.updateTime});
}
