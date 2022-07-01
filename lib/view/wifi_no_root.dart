import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan/scan.dart';
import 'package:wifi/generated/l10n.dart';

class WifiNoRoot extends StatefulWidget {
  const WifiNoRoot({Key ? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _WifiNoRootState();
}

class _WifiNoRootState extends State<WifiNoRoot> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  showPass(context, ssid, psk) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            title: Text(S.of(context).WiFiInformation),
            content: Container(
              height: 250,
              width: 200,
              // color: Colors.black54,
              alignment: Alignment.center,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(S.of(context).ssid + ssid,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Text(S.of(context).psk + psk,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: ssid));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(S.of(context).WiFiPageOneCopySuss),
                        ));
                      },
                      child: Text(S.of(context).copySsid)
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: psk));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(S.of(context).WiFiPageOneCopySuss),
                        ));
                      },
                      child: Text(S.of(context).copyPsk)
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: "ssid:" + ssid + " " + "psk: " + psk));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(S.of(context).WiFiPageOneCopySuss),
                        ));
                      },
                      child: Text(S.of(context).copySsidAndPsk)
                  )
                ],
              )
            ),
          );
        }
    );
  }

  Future scan() async {
    String ssid = "";
    String psk = "";
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image?.path != null && image?.path != "") {
      print(image?.path);
      var result = await Scan.parse(image!.path);
      result ??= "";
      if (result != "" && result.startsWith("WIFI")) {
        print("oo");
        result.split(";").forEach((element) {
          if (element.startsWith("WIFI:S:")) {
            ssid = element.substring(7);
          } else if (element.startsWith("P:")) {
           psk = element.substring(2);
          } else if (element.startsWith("T:")) {
            print(element.substring(2));
          }
        });
        showPass(context, ssid, psk);
        return;
      }
    }
    (){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(S.of(context).notFoundQrcode),
      ));
    }();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).shiYong1),
                Text(S.of(context).shiYong2, style: TextStyle(
                  color: Colors.black,
                  fontSize: 13
                ),),
                Text(""),
                Text(S.of(context).shiYong3),
                Text(S.of(context).shiYong4, style: TextStyle(
                    color: Colors.black,
                    fontSize: 13
                ),)
              ],
            )
          )
        ),
        Flexible(
          child: Container(
            alignment: Alignment.topCenter,
            child: OutlinedButton(
              onPressed: () => scan(),
              child: Text(S.of(context).WiFiPageTitleTwoQRCode),
            ),
          )
        ),
      ],
    );
  }
}