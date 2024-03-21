import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ussd_simulator/model/ussd_request.dart';
import 'package:ussd_simulator/model/ussd_response.dart';

import '../ussd_repo.dart';

class CustomAlertDialog {
  static void showAlertDialog(
      {required BuildContext myContext, required UssdResponse ussdResponse}) {
    TextEditingController message = TextEditingController();
    String content = formatText(ussdResponse.message!);
    AlertDialog alertDialog = AlertDialog(

      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            content,
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
          Visibility(
            visible: isUssdComplete(ussdResponse.stage!),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: '',
              ),
              controller: message,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Visibility(
          visible: isUssdComplete(ussdResponse.stage!),
          child: TextButton(
            onPressed: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              //Navigator.of(myContext).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text("Cancel"),
            ),
          ),
        ),
        Visibility(
          visible: isUssdComplete(ussdResponse.stage!),
          child: TextButton(
            onPressed: () {
              UssdRequest ussdRequest = UssdRequest(
                  stage: "PENDING",
                  reference: "SIMBA12",
                  phoneNumber: "263771802352",
                  message: message.text);
              UssdRepo.sendRequest(ussdRequest, myContext);
              Navigator.of(myContext).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text("Send"),
            ),
          ),
        ),
        Visibility(
          visible: !isUssdComplete(ussdResponse.stage!),
          child: Center(
            child: TextButton(
              onPressed: () {
                //close app
               // Navigator.of(myContext).pop();
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                child: const Text("Ok"),
              ),
            ),
          ),
        ),
      ],
    );

    showDialog(context: myContext, builder: (_) => alertDialog);
  }

  static bool isUssdComplete(String stage) {
    if (stage != 'COMPLETED') {
      return true;
    } else {
      return false;
    }
  }

  static String formatText(String text) {
    List<String> content = text.split('\\n');
    String newContent = "";
    int x = 0;
    content.forEach((element) {
      if (x == 0) {
        newContent = newContent + element;
      } else {
        newContent = newContent + "\n" + element;
      }
      x++;
    });

    return newContent;
  }
}
