class BodyModel {
  String id;
  String gender;
  double weight, height, hip, waist, bmi, ratio;
  String bmiStatus;
  String? time;
  String? date;
  final String ic;

  String? ratiostat;

  BodyModel({
    this.id = '',
    this.gender = '',
    this.weight = 0,
    this.height = 0,
    this.time = '',
    this.date = '',
    this.hip = 0,
    this.waist = 0,
    this.ratio = 0,
    this.bmi = 0,
    this.bmiStatus = '',
    required this.ic,
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
      'id': id,
      'gender': gender,
      'weight': weight,
      'height': height,
      'hip': hip,
      'waist': waist,
      'bmi': bmi,
      'bmistatus': bmiStatus,
      'ic': ic,
      'ratio': ratio,
      'ratioStat': ratiostat,
      'time': time,
      'date': date,
    };
  }

  static BodyModel fromJson(Map<String, dynamic> json) => BodyModel(
        id: json['id'],
        gender: json['gender'],
        ic: json['ic'],
        weight: json['weight'],
        height: json['height'],
        hip: json['hip'],
        waist: json['waist'],
        bmi: json['bmi'],
        bmiStatus: json['bmistatus'],
        ratio: json['ratio'],
        ratiostat: json['ratioStat'],
        time: json['time'],
        date: json['date'],
      );
}
