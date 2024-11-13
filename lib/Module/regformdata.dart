class Quotes {
  String uname;
  String email;
  String unumber;
  String country;
  String city;
  String address;
  String upassword;

  Quotes({
    required this.uname,
    required this.email,
    required this.unumber,
    required this.country,
    required this.city,
    required this.address,
    required this.upassword,
  });

  factory Quotes.fromJson(Map<String, dynamic> json) => Quotes(
        uname: json["uname"],
        email: json["email"],
        unumber: json["unumber"],
        country: json["country"],
        city: json["city"],
        address: json["address"],
        upassword: json["upassword"],
      );

  Map<String, dynamic> toJson() => {
        "uname": uname,
        "email": email,
        "unumber": unumber,
        "country": country,
        "city": city,
        "address": address,
        "upassword": upassword,
      };
}
