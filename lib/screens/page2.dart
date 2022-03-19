import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:database_trial/models/users.dart';
import 'package:database_trial/config.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  Future<List<User>> fetchUsers() async {
    if (prodEnv = true) {
      var response = await http
          .get(Uri.parse("http://" + apiUrl + "/api/retrieve/data"));
      if (response.statusCode == 200) {
        return userFromJson(response.body);
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(
          'Saving and Retrieving data \n from the database',
          style: TextStyle(color: Colors.black87),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: FutureBuilder(
            future: fetchUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    User users = snapshot.data[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${users.firstname}",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            Text(
                              "${users.lastname}",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.green),
                            ),
                            Text(
                              "${users.age}",
                              style: TextStyle(fontSize: 18, color: Colors.red),
                            ),
                            Image.network("http://" +
                                apiUrl +
                                "/docImages/" +
                                "${users.blob}"),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
