class LipidModel {
  String? date;
  String? id;
  String? time;
  String? comment;
  String? ic;
  double tc, hdl, ldl, trigly; //TotalCholesterol = tc
  String? tcstatus, ldlstatus, hdlstatus, triglystatus;
  String? drname;

  LipidModel({
    this.comment = '',
    this.date = '',
    this.id = '',
    this.time = '',
    this.ic = '',
    this.tc = 0,
    this.hdl = 0,
    this.ldl = 0,
    this.trigly = 0,
    this.tcstatus = '',
    this.hdlstatus = '',
    this.ldlstatus = '',
    this.triglystatus = '',
    this.drname = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'date': date,
      'id': id,
      'time': time,
      'ic': ic,
      'tc': tc,
      'hdl': hdl,
      'ldl': ldl,
      'trigly': trigly,
      'tcstatus': tcstatus,
      'hdlstatus': hdlstatus,
      'ldlstatus': ldlstatus,
      'triglystatus': triglystatus,
      'drname': drname,
    };
  }

  LipidModel.fromMap(Map<String, dynamic> map)
      : assert(map['date'] != null),
        assert(map['tc'] != null),
        assert(map['hdl'] != null),
        assert(map['ldl'] != null),
        assert(map['trigly'] != null),
        date = map['date'],
        tc = map['tc'],
        hdl = map['hdl'],
        ldl = map['ldl'],
        trigly = map['trigly'];

  @override
  String toString() => "Record<$date:$tc:$hdl:$ldl:$trigly>";

  static LipidModel fromJson(Map<String, dynamic> json) => LipidModel(
        id: json['id'],
        date: json['date'],
        comment: json['comment'],
        time: json['time'],
        ic: json['ic'],
        tc: json['tc'],
        hdl: json['hdl'],
        ldl: json['ldl'],
        trigly: json['trigly'],
        tcstatus: json['tcstatus'],
        hdlstatus: json['hdlstatus'],
        ldlstatus: json['ldlstatus'],
        triglystatus: json['triglystatus'],
        drname: json['drname'],
      );
}
