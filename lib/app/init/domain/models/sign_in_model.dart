class SignInModel {
  String? name;
  String? lastName;
  String? country;
  String? email;
  String? professionType;
  String? professionID;
  String? status;
  String? sponsor;
  bool? isNewDis;

  SignInModel({
    this.name,
    this.lastName,
    this.email,
    this.country,
    this.professionType,
    this.professionID,
    this.status,
    this.sponsor,
    this.isNewDis,
  });

  factory SignInModel.fromClienteMap(Map<String, dynamic> json) => SignInModel(
        name: json["name"],
        lastName: json["lastName"],
        email: json["email"],
        country: json["country"],
        sponsor: json["sponsor"],
        isNewDis: true,
      );

  factory SignInModel.fromDisMap(Map<String, dynamic> json) => SignInModel(
        name: json["name"],
        lastName: json["lastname"],
        email: json["email"],
        country: json["country"],
        sponsor: json["sponsor"],
        professionType: json["profession"],
        professionID: json["hid"],
        status: json["status"],
        isNewDis: false,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, String>{};
    data['firstName'] = name;
    data['lastName'] = lastName;
    data['email'] = email;
    data['country'] = country;
    data['sponsor'] = sponsor;
    data['professionType'] = professionType;
    data['professionID'] = professionID;
    data['status'] = status;

    return data;
  }
}
