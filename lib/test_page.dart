import 'package:flutter/material.dart';
import 'package:flutter_app_test1/test_controller.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final TextEditingController _textController = TextEditingController();
  final TestController _controller = TestController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _controller.addItemToList();
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          _searchWidget(),
          Expanded(
            child: StreamBuilder<List<String>>(
                stream: _controller.controller,
                builder: (_, snapshot) {
                  return _testListWidget(snapshot.data);
                }),
          )
        ],
      ),
    );
  }

  Widget _searchWidget() {
    return TextField(
      controller: _textController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: (val) {
        _controller.searchFromList(val);
      },
    );
  }

  Widget _testListWidget(List<String>? testList) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 10),
      shrinkWrap: true,
      itemCount: testList?.length ?? 0,
      itemBuilder: (_, index) {
        final data = testList![index];
        if (index.isOdd)
          return _testItemWidget(index, color: Colors.blueAccent, data: data);
        return _testItemWidget(index, color: Colors.yellow, data: data);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 4);
      },
    );
  }

  Widget _testItemWidget(int index,
      {required Color color, required String data}) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        color: color,
        child: Row(
          children: [
            Text(data),
            const Spacer(),
            IconButton(
              onPressed: () {
                _controller.deleteItemFromList(index);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ));
  }
}
