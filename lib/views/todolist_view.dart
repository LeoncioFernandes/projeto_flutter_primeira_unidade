import 'package:flutter/material.dart';
import '../controllers/tarefa_controller.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoList();
}

class _TodoList extends State<TodoList> {
  final _edtatt = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final TarefaController _tarefaController = TarefaController();

  void _addTarefa() {
    setState(() {
      _tarefaController.addTarefa(_edtatt.text);
      _edtatt.clear();
    });
  }

  void _marcarTarefa(int index, bool? value) {
    setState(() {
      _tarefaController.marcarTarefa(index, value);
    });
  }

  void _deletarTarefa(int index) {
    setState(() {
      _tarefaController.deletarTarefa(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "To Do List",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Form(
          key: _formState,
          child: Column(
            children: [
              TextFormField(
                controller: _edtatt,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.task_outlined),
                    labelText: "Tarefa",
                    border: OutlineInputBorder()),
                validator: (value) {
                  if (value != null && value.trim().isEmpty) {
                    return "O campo não pode estar vazio";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formState.currentState!.validate()) {
                          _addTarefa();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        "Cadastrar Tarefa",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Divider(
                thickness: 1,
                color: Colors.black.withOpacity(0.5),
              ),
              Expanded(
                child: _tarefaController.tarefas.isEmpty
                    ? const Text("Adicione uma Tarefa")
                    : ListView.builder(
                        itemCount: _tarefaController.tarefas.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Checkbox(
                                value:
                                    _tarefaController.tarefas[index].isChecked,
                                activeColor: Colors.green,
                                onChanged: (bool? value) {
                                  _marcarTarefa(index, value);
                                },
                              ),
                              Expanded(
                                child: Text(
                                  _tarefaController.tarefas[index].nome,
                                  style: TextStyle(
                                      decoration: _tarefaController
                                              .tarefas[index].isChecked
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _deletarTarefa(index);
                                },
                              )
                            ],
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
