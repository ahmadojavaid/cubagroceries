class HelpCenterModel {
  String question;
  String description;

  HelpCenterModel({required this.question, required this.description});
}

List<HelpCenterModel> helpCenterList() {
  List<HelpCenterModel> tempHelpCenterList = [];

  tempHelpCenterList.add(
      HelpCenterModel(question: "What is Caffely?",
      description: "Caffely is a vibrant coffee destination dedicated to crafting exceptional coffee experiences. We offer a wide range of premium coffee blends, beverages, and treats, all prepared with passion and expertise.")
  );
  tempHelpCenterList.add(
      HelpCenterModel(question: "Whare is Caffely located ?",
          description: "Caffely is a vibrant coffee destination dedicated to crafting exceptional coffee experiences. We offer a wide range of premium coffee blends, beverages, and treats, all prepared with passion and expertise.")
  );
  tempHelpCenterList.add(
      HelpCenterModel(question:"What types of coffee caffely serve ?",
          description: "Caffely is a vibrant coffee destination dedicated to crafting exceptional coffee experiences. We offer a wide range of premium coffee blends, beverages, and treats, all prepared with passion and expertise.")
  );
  tempHelpCenterList.add(
      HelpCenterModel(question: "Can i customize my coffee order ?",
          description: "Caffely is a vibrant coffee destination dedicated to crafting exceptional coffee experiences. We offer a wide range of premium coffee blends, beverages, and treats, all prepared with passion and expertise.")
  );
  tempHelpCenterList.add(
      HelpCenterModel(question: "Is Wi-Fi available in Caffely shop ?",
          description: "Caffely is a vibrant coffee destination dedicated to crafting exceptional coffee experiences. We offer a wide range of premium coffee blends, beverages, and treats, all prepared with passion and expertise.")
  );
  tempHelpCenterList.add(
      HelpCenterModel(question: "Do Caffely have a loyalty program ?",
          description: "Caffely is a vibrant coffee destination dedicated to crafting exceptional coffee experiences. We offer a wide range of premium coffee blends, beverages, and treats, all prepared with passion and expertise.")
  );

  return tempHelpCenterList;
}