import '../models/tarefa_model.dart';

class TarefaController {
  List<Tarefa> tarefas = [];

  void addTarefa(String tafefa) {
    tarefas.add(Tarefa(nome: tafefa.trim()));
    _ordenarTarefas(tarefas);
  }

  void marcarTarefa(int index, bool? value) {
    tarefas[index].isChecked = value ?? false;
    _ordenarTarefas(tarefas);
  }

  void deletarTarefa(int index) {
    tarefas.removeAt(index);
  }

  List<Tarefa> _ordenarTarefas(List<Tarefa> tarefas) {
    tarefas.sort((a, b) {
      if (a.isChecked != b.isChecked) {
        return a.isChecked ? 1 : -1;
      }
      return a.nome.compareTo(b.nome);
    });
    return tarefas;
  }
}
