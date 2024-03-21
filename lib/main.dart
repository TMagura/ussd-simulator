import 'package:flutter/material.dart';
import 'package:ussd_simulator/model/ussd_request.dart';
import 'package:ussd_simulator/ussd_repo.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isUssdRunning = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumber = TextEditingController();
    phoneNumber.text='263';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sierra Leone Ussd Simulator",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: isUssdRunning ? Colors.black : Colors.blue,
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        color: isUssdRunning ? Colors.black : Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 10, bottom: 10, left: 2, right: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
                      flex: 2,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '*143*',
                        ),
                        readOnly: true,
                      )),
                  const SizedBox(
                    width: 2,
                  ),
                  Flexible(
                    flex: 8,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter mobile number',
                        focusColor: Colors.black,
                      ),
                      controller: phoneNumber,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  const Flexible(
                      flex: 1,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '#',
                        ),
                        readOnly: true,
                      )),
                ],
              ),
            ),
            Visibility(
              visible: !isUssdRunning,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isUssdRunning = true;
                  });
                  UssdRequest ussdRequest = UssdRequest(
                      stage: "FIRST",
                      reference: "SIMBA12",
                      phoneNumber: phoneNumber.text,
                      message: "");
                  UssdRepo.sendRequest(ussdRequest, context);
                },
                child: const Text("Request Ussd"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
