class SavedAddressModel {
  String title;
  String name;
  String address;

  SavedAddressModel({required this.title,required this.name,required this.address});

}

List<SavedAddressModel> savedAddressList (){
  List<SavedAddressModel> tempSavedAddress = [];

  tempSavedAddress.add(
    SavedAddressModel(title: "Home", name:  "Andrew Ainsley", address: "701 7th Ave, New York, NY 10036, USA")
  );
  tempSavedAddress.add(
      SavedAddressModel(title: "Apartment", name:  "Andrew Ainsley", address: "Liberty Island, New York, NY 10004, USA")
  );
  tempSavedAddress.add(
      SavedAddressModel(title: "Mom's House", name:  "Jenny Wilson", address: "Central Park, New York, NY 10022, USA")
  );

  return tempSavedAddress;
}
