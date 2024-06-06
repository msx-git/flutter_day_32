import 'package:flutter/material.dart';
import 'package:flutter_day_32/service/database/local_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final localDatabase = LocalDatabase();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final db = localDatabase.database;
  }

  void addNote() async {
    setState(() {
      isLoading = true;
    });
    await localDatabase.addNote("New todo");
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite example'),
        actions: [
          IconButton(
            onPressed: addNote,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : const Text("Note added"),
      ),
    );
  }
}
