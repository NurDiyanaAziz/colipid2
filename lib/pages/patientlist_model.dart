class PatientListModel {
  final String fullname;
  String id;
  String? phone;
  final String ic;
  String? date;
  String? time;

  PatientListModel({
    required this.fullname,
    this.id = '',
    this.phone,
    required this.ic,
    this.date = '',
    this.time = '',
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
      'id': id,
      'phone': phone,
      'ic': ic,
      'date': date,
      'time': time,
    };
  }

  static PatientListModel fromJson(Map<String, dynamic> json) =>
      PatientListModel(
          id: json['id'], fullname: json['fullname'], ic: json['ic']);
}
