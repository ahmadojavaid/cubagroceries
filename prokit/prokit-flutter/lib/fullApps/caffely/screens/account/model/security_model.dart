class SecurityModel {
  String name;
  bool isActive;

  SecurityModel({required this.name, required this.isActive});
}

List<SecurityModel> securityList (){
  List<SecurityModel> tempSecurityList = [];

  tempSecurityList.add(
    SecurityModel(name: "Remember me", isActive: true)
  );
  tempSecurityList.add(
      SecurityModel(name: "Biometric ID", isActive: false)
  );
  tempSecurityList.add(
      SecurityModel(name: "Face ID" ,isActive: false)
  );
  tempSecurityList.add(
      SecurityModel(name: "SMS Authenticator", isActive: false)
  );
  tempSecurityList.add(
      SecurityModel(name: "Google Authenticator", isActive: false)
  );
  return tempSecurityList;
}