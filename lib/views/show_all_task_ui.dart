// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_task_app/models/task.dart';
import 'package:flutter_task_app/services/supabase_services.dart';
import 'package:flutter_task_app/views/add_task_ui.dart';
import 'package:flutter_task_app/views/update_delete_task_ui.dart';

class ShowAllTaskUi extends StatefulWidget {
  const ShowAllTaskUi({super.key});

  @override
  State<ShowAllTaskUi> createState() => _ShowAllTaskUiState();
}

class _ShowAllTaskUiState extends State<ShowAllTaskUi> {
  //สร้าง instance/object
  final service = SupabaseService();
  //สร้างตัวแปรเพื่อเก็บข้อมูลที่ดึงมา
  List<Task> tasks = [];
  //สร้างเมธอดเพื่อดึงข้อมูล
  void loadTasks() async {
    final data = await service.getAllTasks();
    //เอาข้อมูลที่ดึงมา กำหนดตัวแปร
    setState(() {
      tasks = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'TASK ME',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskUi(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue[900],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //ส่วนของbody
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Image.asset(
              'assets/images/logo.png',
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 50),
            //ส่วนของ ลิสวิว แสดงรายการข้อมูลที่ดึงมาจาก supabase
            Expanded(
              child: ListView.builder(
                //จำนวนรายการใน ลิสวิว
                itemCount: tasks.length,
                //สร้างหน้าตาของแต่ละรายการ
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 40,
                      right: 40,
                      top: 5,
                      bottom: 5,
                    ),
                    child: ListTile(
                      onTap: (){
                        //เปิดไปหน้าอัพเดท แบบย้อนกลับได้
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateDeleteTaskUi(),
                          ),
                        );
                      },
                      title: Text(
                        'งาน: ${tasks[index].task_name}',
                      ),
                      subtitle: Text(
                        'สถานะ: ${tasks[index].task_status == true ? 'เสร็จแล้ว' : 'ยังไม่เสร็จ'}',
                      ),
                      trailing: Icon(
                        Icons.info,
                        color: Colors.greenAccent,
                      ),
                      leading: tasks[index].task_image_url == ''
                          ? Image.asset(
                              'assets/images/task.png',
                            )
                          : Image.network(
                              tasks[index].task_image_url!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                    tileColor: index % 2 == 0 ? Colors.green[200] : Colors.amber[50],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
