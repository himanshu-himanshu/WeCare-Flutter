class Patient {
  final String id;
  final String name;
  final String phone;
  final String dob;
  final String address;
  final String country;
  final String bloodGroup;

  Patient(
      {this.id = "",
      this.name = "",
      this.phone = "",
      this.dob = "",
      this.address = "",
      this.country = "",
      this.bloodGroup = ""});

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
        id: json['_id'] as String,
        name: json['name'] as String,
        phone: json['phone'] as String,
        dob: json['dob'] as String,
        address: json['address'] as String,
        country: json['country'] as String,
        bloodGroup: json['bloodGroup'] as String);
  }

  @override
  String toString() {
    return '{id: $id, name: $name, phone: $phone, dob: $dob, address: $address, country: $country, bloodGroup: $bloodGroup}';
  }
}
