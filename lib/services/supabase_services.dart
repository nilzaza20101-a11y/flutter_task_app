//ไฟล์ที่ใช้ทำงานต่างๆ กับ supabase
//กรณี Table ก็ CRUD (Create/Insert, Read/Select, Update, Delete) ข้อมูล
//กรณี Bucket ก็ Upload, Delete , GetUrl

import 'dart:io';

import 'package:flutter_task_app/models/task.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class SupabaseService {
  // สร้าง instance/object/ตัวแทน ของ Supabase_flutter เพื่อจะทำงานต่างๆ กับ Supabase
  final supabase = Supabase.instance.client;
  //(มีเยอะหน่อย)เมธอดการทำงานต่างๆกับ Supabase
  //เมธอดดึงข้อมูลงานทั้งหมด จากตาราง tasks_tb เพื่อไปใช้กับหน้า ShowAllTaskUi
  Future<List<Task>> getAllTasks() async {
    //ดึงข้อมูล
    final data = await supabase.from('task_tb').select('*');

    //ส่งค่าข้อมูลที่ดึงกลับไปใช้งานอย่างที่ต้องการ
    return data.map((e) => Task.fromJson(e)).toList();
  }


  //เมธอด Upload ไฟล์รูปภาพไปยัง task_bk และรับ URL ของรูปภาพที่อัปโหลดมา เพื่อใช้กับหน้า AddTaskUi และ UpdateDeleteTaskUi
  Future<String?> uploadFileToBucket(File file) async {
   //ตั้งชื่อไฟล์ใหม่เพื่อไม่ให้ซ้ำก่อนอัปโหลด
    final newFileName = '${DateTime.now()}_${file.path.split('/').last}';
   //อัปโหลดไฟล์ไปยัง bucket
   await supabase.storage.from('task_bk').upload(newFileName, file);

  //ส่งค่าข้อมูล URL ของไฟล์ที่อัปโหลดกลับไปใช้งานอย่างที่ต้องการ
  return supabase.storage.from('task_bk').getPublicUrl(newFileName);
  }


  //เมธอด เพิ่ม ข้อมูลลงตาราง tasks_tb เพื่อใช้กับหน้า AddTaskUi
  Future<void> insertTask(Task task) async {
    await supabase.from('task_tb').insert(task.toJson());
  }

  //เมธอด ลบ ไฟล์รูปภาพใน task_bk เพื่อใช้กับหน้า UpdateDeleteTaskUi
  Future<void> deleteFileFromBucket(String task_image_url) async {
    //การลบจะตัดเอาเฉพาะชื่อ
    final fileName = task_image_url.split('/').last;
    
    await supabase.storage.from('task_bk').remove([fileName]);
  }


  //เมธอด แก้ไข  ข้อมูลในตาราง tasks_tb เพื่อใช้กับหน้า UpdateDeleteTaskUi
  Future<void> updateTask(String id, Task task) async {
    await supabase.from('task_tb').update(task.toJson()).eq('id', id);
  }

  //เมธอด ลบ  ข้อมูลในตาราง tasks_tb เพื่อใช้กับหน้า UpdateDeleteTaskUi
  Future<void> deleteTask(String id) async {
    await supabase.from('task_tb').delete().eq('id', id);
  }
}