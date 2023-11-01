class SignUpModel {
  String firstName;
  String lastName;
  String country;
  String email;
  String password;
  String profesionType;
  String profesionID;
  String status;
  String sponsor;
  bool isNewDis;

  SignUpModel({
    required this.firstName,
    this.lastName = "",
    required this.email,
    required this.password,
    this.country = "",
    this.profesionType = "",
    this.profesionID = "",
    this.status = "",
    this.sponsor = "",
    this.isNewDis = false,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, String>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['country'] = country;
    data['email'] = email;
    data['profesionType'] = profesionType;
    data['profesionID'] = profesionID;
    return data;
  }
}
