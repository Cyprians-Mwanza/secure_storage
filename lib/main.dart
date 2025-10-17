import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/note_cubit.dart';
import 'pages/notes_page.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NoteCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App (SQLite + Bloc)',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NotesPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}