import 'dart:async';
import 'dart:math';

class TestController {
  StreamController<List<String>> _controller = StreamController<List<String>>();
  Stream<List<String>> get controller => _controller.stream;

  final List<String> _list = [];

  void addItemToList() {
    Random random = Random();
    _list.add('Test ${random.nextInt(10000)}');
    _controller.sink.add(_list);
  }

  void deleteItemFromList(int index) {
    _list.removeAt(index);
    _controller.sink.add(_list);
  }

  void searchFromList(String textSearch) {
    final List<String> result = _list
        .where((element) =>
            element.toLowerCase().contains(textSearch.toLowerCase()))
        .map((e) => e)
        .toList();
    _controller.sink.add(result);
  }
}
