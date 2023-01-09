import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController textData;

  var tokenData;

  //get data from local
  getDataToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('token_data');
    setState(() {
      tokenData = action;
      print(tokenData);
    });
  }

  //set data to local
  setDataTokenToken(String tokenValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token_data', tokenValue);
  }

  @override
  void initState() {
    super.initState();
    textData = TextEditingController();
    getDataToken();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textData.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Token',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xffB04CA1)),
                // ignore: prefer_const_constructors
                child: Text(
                  tokenData ?? "No Token Data",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Set Token',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xffE8E8E8)),
                child: TextField(
                  controller: textData,
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                  color: const Color(0xffE469D1),
                  onPressed: () {
                    setDataTokenToken(textData.text);
                    getDataToken();
                    setState(() {});
                  },
                  child: const Text(
                    'Set Data',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
