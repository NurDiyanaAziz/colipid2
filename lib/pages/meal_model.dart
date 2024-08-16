class MealModel {
  String? breakfast;
  String? dinner;
  String? lunch;
  String? morningtea;
  final String plan;
  final String plantype;
  String? teatime;
  final String tag;

  MealModel({
    this.breakfast = '',
    this.dinner = '',
    this.lunch = '',
    this.morningtea = '',
    required this.plan,
    this.plantype = '',
    this.teatime = '',
    required this.tag,
  });

  static MealModel fromJson(Map<String, dynamic> json) => MealModel(
      breakfast: json['breakfast'],
      morningtea: json['fullname'],
      lunch: json['ic'],
      teatime: json['teatime'],
      dinner: json['dinner'],
      plan: json['plan'],
      plantype: json['plantype'],
      tag: json['tag']);
}
