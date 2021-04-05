import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungmitrphol/models/permitt_model.dart';
import 'package:ungmitrphol/widgets/show_alert.dart';

class CheckWorkGroup extends StatefulWidget {
  @override
  _CheckWorkGroupState createState() => _CheckWorkGroupState();
}

class _CheckWorkGroupState extends State<CheckWorkGroup> {
  String workGroup;
  PermittModel permittModel;

  List<String> pathImages = [
    'images/category1.png',
    'images/category2.png',
    'images/category3.png',
    'images/category4.png',
  ];

  List<String> titleCats = [
    'createPermit',
    'readPermit',
    'updatePermit',
    'deletePermit',
  ];

  List<Widget> widgets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              buildColumnTop(),
              buildExpanded(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildExpanded() => Expanded(
        child: Center(
          child: permittModel == null
              ? SizedBox()
              : GridView.extent(
                  maxCrossAxisExtent: 250,
                  children: widgets,
                ),
        ),
      );

  Column buildColumnTop() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildWorkgroup(),
        buildCheck(),
      ],
    );
  }

  Container buildCheck() {
    return Container(
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          if (workGroup?.isEmpty ?? true) {
            normalDialog('Have Space ?', 'Please Fill Every Blank');
          } else {
            threadCheckWorkGroup();
          }
        },
        child: Text('Check'),
      ),
    );
  }

  Container buildWorkgroup() {
    return Container(
      margin: EdgeInsets.only(top: 100, bottom: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => workGroup = value.trim(),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.lock_outline),
          labelText: 'workGroupCodeNameTh',
        ),
      ),
    );
  }

  Future<Null> normalDialog(String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: ShowAlert(),
          title: Text(title),
          subtitle: Text(message),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<Null> threadCheckWorkGroup() async {
    if (widgets.length != 0) {
      widgets.clear();
      permittModel = null;
      // workGroup = null;
    }

    String path =
        'https://smart.mitrphol.com/api_portal_smart/authorization/authorize/permission';

    Map<String, dynamic> data = {};
    data['workGroupCodeNameTh'] = workGroup;
    data['taskCodeNameTh'] = 'Management Rooms Main Page';

    Map<String, dynamic> header = {};
    header['Accept'] = 'application/json';
    header['Content-Type'] = 'application/x-www-form-urlencoded';

    await Dio().post(path, data: data, options: Options(headers: header)).then(
      (value) {
        print('#### value => $value ###');
        var result = value.data['data'];
        for (var item in result) {
          setState(() {
            permittModel = PermittModel.fromMap(item);
            crateWidgets();
          });
          if (permittModel.readPermit) {
            print('readPermit ==> True');
          } else {
            normalDialog('WorkGroup False', 'Please Try Again WorkGroup False');
          }
        }
      },
    );
  }

  void crateWidgets() {
    List<bool> permits = [];
    permits.add(permittModel.createPermit);
    permits.add(permittModel.readPermit);
    permits.add(permittModel.updatePermit);
    permits.add(permittModel.deletePermit);

    print('length of permits ==> ${permits.length}');
    print('readPermit ==>> ${permits[1]}');

    int index = 0;
    for (var permit in permits) {
      widgets.add(
        Card(
          color: permit ? Colors.green[200] : Colors.red[200],
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 100,
                  child: Image.asset(pathImages[index]),
                ),
                Text(titleCats[index]),
              ],
            ),
          ),
        ),
      );
      index++;
    }
    // setState(() {});
  }
}
