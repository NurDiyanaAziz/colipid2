class UserModel {
  final String fullname;
  String age;
  String id;
  String gender;
  double weight, height, hip, waist, bmi, calorieNeeded, ratio;
  String bmiStatus;
  String dob;
  String? allergic;
  String active;
  String? phone;
  String? usertype;
  final String ic;
  bool? med;

  String? medname;
  String? ratiostat;

  UserModel({
    required this.fullname,
    this.age = '',
    this.id = '',
    this.gender = '',
    this.weight = 0,
    this.height = 0,
    this.hip = 0,
    this.waist = 0,
    this.ratio = 0,
    this.bmi = 0,
    this.calorieNeeded = 0,
    this.bmiStatus = '',
    this.dob = '',
    this.allergic = '',
    this.active = '',
    this.phone,
    required this.ic,
    this.usertype = '',
    this.med = false,
    this.medname = '',
    this.ratiostat = '',
  });
  /*factory UserModel.fromMap(map) {
    return UserModel(
      fullname: map['fullname'],
      age: map['age'],
      id: map['id'],
      gender: map['gender'],
      weight: map['weight'],
      height: map['height'],
      hip: map['hip'],
      waist: map['waist'],
      bmi: map['bmi'],
      calorieNeeded: map['calorieNeeded'],
      bmiStatus: map['bmistatus'],
      dob: map['dob'],
      allergic: map['allergic'],
      active: map['active'],
      phone: map['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullname': fullname,
      'age': age,
      'id': id,
      'gender': gender,
      'weight': weight,
      'height': height,
      'hip': hip,
      'waist': waist,
      'bmi': bmi,
      'calorieNeeded': calorieNeeded,
      'bmistatus': bmiStatus,
      'dob': dob,
      'allergic': allergic,
      'active': active,
      'phone': phone,
    };
  }*/

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'age': age,
      'id': id,
      'gender': gender,
      'weight': weight,
      'height': height,
      'hip': hip,
      'waist': waist,
      'bmi': bmi,
      'calorieNeeded': calorieNeeded,
      'bmistatus': bmiStatus,
      'dob': dob,
      'allergic': allergic,
      'active': active,
      'phone': phone,
      'ic': ic,
      'usertype': usertype,
      'med': med,
      'medname': medname,
      'ratio': ratio,
      'ratiostat': ratiostat,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) =>
      UserModel(id: json['id'], fullname: json['fullname'], ic: json['ic']);
}
