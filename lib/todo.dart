import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.redAccent,
        ),
      ),
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<String> tasks = [];
  final TextEditingController _controller = TextEditingController();

  void _manageTask({int? index}) {
    if (_controller.text.isNotEmpty) {
      setState(() {
        index == null ? tasks.add(_controller.text) : tasks[index] = _controller.text;
      });
      _controller.clear();
      Navigator.pop(context);
    }
  }

  void _showTaskDialog({int? index}) {
    _controller.text = index != null ? tasks[index] : '';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(index == null ? "Add Task" : "Edit Task"),
        content: TextField(controller: _controller, decoration: InputDecoration(hintText: "Enter task...")),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(onPressed: () => _manageTask(index: index), child: Text(index == null ? "Add" : "Update")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To-Do List")),
      body: tasks.isEmpty
          ? Center(child: Text("No tasks yet!", style: TextStyle(color: Colors.white54)))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(tasks[index]),
                onTap: () => _showTaskDialog(index: index),
                trailing: IconButton(icon: Icon(Icons.delete), onPressed: () => setState(() => tasks.removeAt(index))),
              ),
            ),
      floatingActionButton: FloatingActionButton(onPressed: () => _showTaskDialog(), child: Icon(Icons.add)),
    );
  }
}
