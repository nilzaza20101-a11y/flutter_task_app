import 'package:flutter/material.dart';
import 'package:flutter_task_app/views/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//-----------------------------------------------------
void main() async {
  //-----------กำหนดค่าการติดต่อ Project บน Supabase ที่จะทำงานด้วย-----
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ygzahkjmgacbjyfyxtrg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlnemFoa2ptZ2FjYmp5Znl4dHJnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUyMDkyNTAsImV4cCI6MjA5MDc4NTI1MH0.wHB17m1W8oJWSZDivSNVOqvJzya_1LfeNrS6rWrfyfQ',
  );

  //--------------------------------------------------------------

  runApp(
    FlutterTaskApp(),
  );
}

//----------------------------
class FlutterTaskApp extends StatefulWidget {
  const FlutterTaskApp({super.key});

  @override
  State<FlutterTaskApp> createState() => _FlutterTaskAppState();
}

class _FlutterTaskAppState extends State<FlutterTaskApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUi(),
      theme: ThemeData(
        textTheme: GoogleFonts.promptTextTheme(Theme.of(context).textTheme),
      ),
    );
  }
}
