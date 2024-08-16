class ExerciseTakenModel {
  String name;
  double cal;
  double durations;
  String id;
  String? time;
  String? date;
  final String ic;

  ExerciseTakenModel(
      {this.name = '',
      this.cal = 0,
      this.time = '',
      this.date = '',
      this.durations = 0,
      this.id = '',
      this.ic = ''});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ic': ic,
      'cal': cal,
      'name': name,
      'time': time,
      'date': date,
      'duration': durations,
    };
  }

  static ExerciseTakenModel fromJson(Map<String, dynamic> json) =>
      ExerciseTakenModel(
          id: json['id'],
          name: json['name'],
          cal: json['cal'],
          time: json['time'],
          date: json['date'],
          ic: json['ic'],
          durations: json['duration']);
}
