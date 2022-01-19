import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scan/scan.dart';

class WifiNoRoot extends StatefulWidget {
  const WifiNoRoot({Key ? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _WifiNoRootState();
}

class _WifiNoRootState extends State<WifiNoRoot> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  Future scan() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image?.path != null && image?.path != "") {
      print(image?.path);
      var result = await Scan.parse(image!.path);
      print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return Container(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          MaterialButton(
            onPressed: (){
              scan();
            },
            child: const Text('ok'),
          )
        ],
      )
    );
  }
}