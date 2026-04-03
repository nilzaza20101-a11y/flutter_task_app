// ไฟล์ที่ตรงกับข้อมูลในตาราง บน supabase
class Task {
// ตัวแปรที่ตรงกับตาราง
  String? id;
  String? task_name;
  String? task_where;
  int? task_person;
  bool? task_status;
  String? task_duedate;
  String? task_image_url;

// constructor
// ที่เอาไปแพ๊กข้อมูลเวลาส่งไป insert/update ไปยยัง suppabase
// ที่เอาไว้แพ๊กข้อมูลเวลาส่งค่าระหว่างหน้าจอ หรือส่งข้อมู,
Task({
  this.id,
  this.task_name,
  this.task_where,
  this.task_person,
  this.task_status,
  this.task_duedate,
  this.task_image_url,
});

//คำสั้งในการแปลงข้อมูลจาก supabase JSon --- > fromJson
factory Task.fromJson(Map<String, dynamic> json) => Task(
  id: json['id'],
  task_name: json['task_name'],
  task_where: json['task_where'],
  task_person: json['task_person'],
  task_status: json['task_state'],
  task_duedate: json['task_duedate'],
  task_image_url: json['task_image_url'],
);

// คำสั่งในการแปลงข้อมูลจาก แอป ไปเป็น JSON  --- > toJson
Map<String, dynamic> toJson() => {
  'id': id,
  'task_name': task_name,
  'task_Where': task_where,
  'task_person': task_person,
  'task_status': task_status,
  'task_duedate': task_duedate,
  'task_image_Url': task_image_url,
  };
}