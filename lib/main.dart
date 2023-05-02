import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String name = "Country Name: No Data";
  String capital = "Capital City: No Data";
  String currency = "Currency: No Data";
  Uri image1 = Uri.parse(
      'https://raw.githubusercontent.com/LeonKings/Gambar/main/download.png');
  TextEditingController countryName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text(
          "Country Information",
        ),
      ),
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Search Country",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Country name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              controller: countryName,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                onPressed();
              },
              child: const Text("Search")),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: 100,
            width: 350,
            decoration: BoxDecoration(border: Border.all()),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    width: 64,
                    image: NetworkImage('$image1'),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(fontSize: 13)),
                      Text(capital, style: const TextStyle(fontSize: 13)),
                      Text(currency, style: const TextStyle(fontSize: 13))
                    ],
                  )
                ],
              ),
            ]),
          )
        ]),
      ),
    ));
  }

  Future<void> onPressed() async {
    String cntryName = countryName.text;
    var apiid = "AZUgK5qPxs5cgclNWbwwQw==jYxMWcPiPQlbVFR6";
    Uri url =
        Uri.parse('https://api.api-ninjas.com/v1/country?name=$cntryName');
    var response = await http.get(url, headers: {'X-Api-Key': apiid});
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      if (parsedJson.toString() == '[]') {
        failed();
      } else {
        setState(() {
          var cap = parsedJson[0]['capital'];
          var curr1 = parsedJson[0]['currency']['code'];
          var curr2 = parsedJson[0]['currency']['name'];
          var iso = parsedJson[0]['iso2'];
          name = "Country Name: $cntryName";
          capital = "Capital City: $cap";
          currency = "Currency: $curr1 - $curr2";
          image1 = Uri.parse('https://flagsapi.com/$iso/shiny/64.png');
        });
      }
    } else {
      failed();
    }
  }

  void failed() {
    setState(() {
      name = "Country Name: No Data";
      capital = "Capital City: No Data";
      currency = "Currency: No Data";
      image1 = Uri.parse(
          'https://raw.githubusercontent.com/LeonKings/Gambar/main/download.png');
    });
  }
}
