import 'package:flutter/material.dart';
import 'package:ungmitrphol/models/sqlite_model.dart';
import 'package:ungmitrphol/utility/sqlite_helper.dart';
import 'package:ungmitrphol/widgets/show_process.dart';

class ShowChart extends StatefulWidget {
  @override
  _ShowChartState createState() => _ShowChartState();
}

class _ShowChartState extends State<ShowChart> {
  bool load = true;
  List<SQLiteModel> sqliteModels = [];

  @override
  void initState() {
    super.initState();
    readAllCart();
  }

  Future<Null> readAllCart() async {
    await SQLiteHelper().readAllSQLite().then((value) {
      setState(() {
        load = false;
        sqliteModels = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildButton(),
      appBar: AppBar(
        title: Text('Show Cart'),
      ),
      body: load
          ? ShowProcess()
          : sqliteModels.length == 0
              ? Center(child: Text('Empty Cart'))
              : buildListView(),
    );
  }

  Future<Null> deleteSQLbyId(int id) async {
    await SQLiteHelper().deleteSQLiteWhereId(id).then((value) {
      sqliteModels.clear();
      readAllCart();
    });
  }

  ListView buildListView() {
    return ListView.builder(
      itemCount: sqliteModels.length,
      itemBuilder: (context, index) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sqliteModels[index].codeKey,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(sqliteModels[index].codeStamp),
                ],
              ),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteSQLbyId(sqliteModels[index].id))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(onPressed: () {}, child: Text('Upload')),
        SizedBox(
          width: 8,
        ),
        ElevatedButton(
          onPressed: () {
            processClearSQLite();
          },
          child: Text('Clear All SQLite'),
          style: ElevatedButton.styleFrom(primary: Colors.red[700]),
        ),
      ],
    );
  }

  Future<Null> processClearSQLite() async {
    await SQLiteHelper().clearSQLite().then((value) {
      setState(() {
        sqliteModels.clear();
      });
    });
  }
}
