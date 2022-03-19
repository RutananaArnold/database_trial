import 'dart:html';

import 'package:database_trial/config.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:database_trial/components/RoundedButton.dart';
import 'package:database_trial/components/RoundedInputField.dart';
import 'package:database_trial/screens/page2.dart';
import 'package:flushbar/flushbar.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final TextEditingController fnameController = new TextEditingController();
  final TextEditingController lnameController = new TextEditingController();
  final TextEditingController ageController = new TextEditingController();
  List<int> _selectedFile;
  Uint8List _bytesData;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              inputSection(),
              registerButton(),
            ],
          ),
        ),
      ),
    );
  }

  //UI Components

  inputSection() {
    return Column(
      children: [
        RoundedInputField(
          hintText: "First Name",
          icon: Icons.person,
          fcolor: Colors.grey,
          field: fnameController,
        ),
        RoundedInputField(
          hintText: "Last Name",
          icon: Icons.person,
          fcolor: Colors.grey,
          field: lnameController,
        ),
        RoundedInputField(
          hintText: "Age",
          icon: Icons.person,
          fcolor: Colors.grey,
          keyboard: TextInputType.number,
          field: ageController,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black87),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.upload_file),
                  onPressed: startWebFilePicker,
                ),
                SizedBox(
                  height: 5,
                ),
                if (_selectedFile != null)
                  kIsWeb
                      ? Image.memory(
                          _selectedFile,
                          fit: BoxFit.fill,
                        )
                      : Image.memory(_selectedFile),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  startWebFilePicker() async {
    html.InputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files[0];
      final reader = new html.FileReader();

      reader.onLoadEnd.listen((e) {
        _handleResult(reader.result);
      });
      reader.readAsDataUrl(file);
    });
  }

  void _handleResult(Object result) {
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
    });
  }

  registerButton() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.blue),
        ),
      );
    } else {
      return RoundedButton(
        text: "REGISTER",
        color: Colors.green,
        press: () {
          if (fnameController.text == "" ||
              lnameController.text == "" ||
              _selectedFile == "" ||
              ageController.text == "") {
            Flushbar(
              message: "Empty field/s found!",
              icon: Icon(Icons.info_outline, size: 25.0, color: Colors.red),
              duration: Duration(seconds: 3),
              leftBarIndicatorColor: Colors.red,
            )..show(context);
          } else {
            setState(() {
              _isLoading = true;
            });
            prodEnv
                ? test_save(fnameController.text, lnameController.text,
                    ageController.text, _selectedFile)
                : Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) => Page2(),
                    ),
                    (Route<dynamic> route) => false);
          }
        },
      );
    }
  }

  // logic

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
      };

  test_save(String firstname, lastname, age, List<int> _selectedFile) async {
    print(firstname + ", " + lastname + ", " + age + " ,");
    print(_selectedFile);

    var request = http.MultipartRequest(
        'POST', Uri.parse("http://" + apiUrl + "/api/register/user"));
    request.fields.addAll({
      'firstname': firstname,
      'lastname': lastname,
      'age': age,
    });
    request.files.add(http.MultipartFile.fromBytes('blob', _selectedFile,
        contentType: new MediaType('application', 'octet-stream'),
        filename: "fileName"));

    request.send().then((response) {
      print("test");
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("Uploaded!");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => Page2(),
            ),
            (Route<dynamic> route) => true);
      } else {
        print('no');
      }
    });
  }

  save(String firstname, lastname, age, fileName) async {
    Map data = {
      "firstname": firstname,
      "lastname": lastname,
      "age": age,
      "blob": fileName,
    };
    print(data);

    var jsonResponse;

    var response = await http.post(
      Uri.parse("http://" + apiUrl + "/register/user"),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );

    if (response.statusCode == 201) {
      // print("infor uploaded");
      // return true;
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => Page2(),
            ),
            (Route<dynamic> route) => true);
      }
    } else {
      // print("upload failed");
      // return false;
      jsonResponse = json.decode(response.body);
      Flushbar(
        message: jsonResponse['message'],
        icon: Icon(Icons.info_outline, size: 25.0, color: Colors.red),
        duration: Duration(seconds: 100),
        leftBarIndicatorColor: Colors.red,
      )..show(context);
    }
  }
}
