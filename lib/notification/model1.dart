import 'model.dart';

class ModelNotifci extends Model {

  static String table = 'todo_items';

  int id;
  String title;
  String bady;
  String time;


  ModelNotifci({this.id, this.title, this.bady, this.time});

  Map<String, dynamic> toMap() {

    Map<String, dynamic> map = {
      'title': title,
      'bady': bady,
      'time': time
    };

    if (id != null) { map['id'] = id; }
    return map;
  }

  static ModelNotifci fromMap(Map<String, dynamic> map) {

    return ModelNotifci(
        id: map['id'],
        title: map['title'],
        bady: map['bady'],
        time: map['time'],
    );
  }
}