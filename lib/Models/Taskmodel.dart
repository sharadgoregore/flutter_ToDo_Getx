// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Task {
  final int? id;
  final String? title;
  final String? note;
  final int? iscompleted;
  final String? date;
  final  starttime;
  final String? endtime;
  final int? color;
  final int? remind;
  final String? repeat;
  //final String? tasktype;
  Task({
    this.color,
    this.date,
    this.endtime,
    this.id,
    this.iscompleted,
    this.note,
    this.remind,
    this.repeat,
    this.starttime,
    this.title,
    //this.tasktype
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(title != null){
      result.addAll({'title': title});
    }
    if(note != null){
      result.addAll({'note': note});
    }
    if(iscompleted != null){
      result.addAll({'iscompleted': iscompleted});
    }
    if(date != null){
      result.addAll({'date': date});
    }
    if(starttime != null){
      result.addAll({'starttime': starttime});
    }
    if(endtime != null){
      result.addAll({'endtime': endtime});
    }
    if(color != null){
      result.addAll({'color': color});
    }
    if(remind != null){
      result.addAll({'remind': remind});
    }
    if(repeat != null){
      result.addAll({'repeat': repeat});
    }
  //  if(tasktype != null){
  //     result.addAll({'tasktype': tasktype});
  //   }
    return result;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id']?.toInt(),
      title: map['title'],
      note: map['note'],
      iscompleted: map['iscompleted']?.toInt(),
      date: map['date'],
      starttime: map['starttime'],
      endtime: map['endtime'],
      color: map['color']?.toInt(),
      remind: map['remind']?.toInt(),
      repeat: map['repeat'],
     // tasktype: map['tasktype']
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
