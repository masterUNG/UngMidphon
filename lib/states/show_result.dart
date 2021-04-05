import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ungmitrphol/models/result_model.dart';
import 'package:ungmitrphol/models/sqlite_model.dart';
import 'package:ungmitrphol/utility/sqlite_helper.dart';
import 'package:ungmitrphol/widgets/show_process.dart';

class ShowResult extends StatefulWidget {
  @override
  _ShowResultState createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> with WidgetsBindingObserver {
  bool load = true;
  List<ResultModel> resultModels = [];

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.inactive:
        print('### inactive ###');
        break;
      case AppLifecycleState.paused:
        print('### paused ###');
        break;
      case AppLifecycleState.resumed:
        print('### resume ###');
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    readDatabase();
    aboutNotification();
  }

  Future<Null> aboutNotification() async {
    FirebaseMessaging firebaseMessaging;
    await firebaseMessaging
        .getToken()
        .then((value) => print('### token = $value'));
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  Future<Null> readDatabase() async {
    print('readDatabase Work');
    String path = 'https://smart.mitrphol.com/api_dataset/iot/getAllData';
    await Dio().post(path).then((value) {
      var result = value.data['result'];
      print('### result = $result ###');

      for (var map in result) {
        ResultModel model = ResultModel.fromMap(map);
        setState(() {
          resultModels.add(model);
        });
      }

      setState(() {
        load = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Result'),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () => Navigator.pushNamed(context, '/showMap'),
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/showCart'),
          ),
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await Firebase.initializeApp().then((value) async {
                  await FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/authen', (route) => false));
                });
              }),
        ],
      ),
      body: load ? ShowProcess() : buildListView(),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      itemCount: resultModels.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          print('You Click index = $index');
          resultDialog(resultModels[index]);
        },
        child: Card(
          color: index % 2 == 0 ? Colors.grey.shade400 : Colors.grey.shade200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          resultModels[index].codeKey,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(resultModels[index].createStamp),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(resultModels[index].codeName),
                    Text(resultModels[index].codeValue),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> addChart(ResultModel model) async {
    SQLiteModel sqLiteModel = SQLiteModel(
      codeKey: model.codeKey,
      codeName: model.codeName,
      codeValue: model.codeValue,
      codeStamp: model.createStamp,
    );

    SQLiteHelper().insertValueToSQLite(sqLiteModel);
  }

  Future<Null> resultDialog(ResultModel model) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: Icon(
            Icons.alarm,
            size: 48,
          ),
          title: Text(model.codeKey),
          subtitle: Text(model.createStamp),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(model.codeName),
              Text(model.codeValue),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    addChart(model);
                  },
                  child: Text('Add Chart')),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
            ],
          )
        ],
      ),
    );
  }
}
