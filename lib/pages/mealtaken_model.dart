class MealTakenModel {
  String plan;
  String id;
  String plantype;
  String? date;
  String? time;
  final String ic;

  MealTakenModel({
    this.plan = '',
    this.time = '',
    this.date = '',
    this.plantype = '',
    this.ic = '',
    this.id = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'ic': ic,
      'plan': plan,
      'plantype': plantype,
      'id': id,
      'time': time,
      'date': date,
    };
  }

  static MealTakenModel fromJson(Map<String, dynamic> json) => MealTakenModel(
      id: json['id'],
      plan: json['plan'],
      plantype: json['plantype'],
      time: json['time'],
      date: json['date'],
      ic: json['ic']);
}
