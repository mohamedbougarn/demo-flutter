// @dart = 2.3
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _State createState()=> _State();


}

class _State extends State<MyApp>
{

  String barcode = "";
  @override
  Widget build(BuildContext context)
  {

    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Scan code',style: TextStyle( color: Colors.black54,fontWeight: FontWeight.bold)),
            backgroundColor: Colors.red,
          ),
           floatingActionButton: FloatingActionButton.extended(onPressed: barcodeScanning,
             label: Text('SCAN',style: TextStyle(color: Colors.black54,
                 fontWeight: FontWeight.bold)),
             
             backgroundColor: Colors.red,
             icon: const Icon(Icons.qr_code_scanner, color: Colors.black54),

           ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: Container(
            padding: const EdgeInsets.all(8.0),
            child:Center(

              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.all(10.0),

                      ),
                  Padding(padding: EdgeInsets.all(8.0),
                  ),
                  Text('Scanned Barcode Number',style: TextStyle(fontSize: 20),),
                  Text(barcode.toString(),style: TextStyle(fontSize: 25,color: Colors.green),)
              ],
              ),
            ),
          ),

        ),

    );


  }
  //scan barcode asynchronously
  Future barcodeScanning() async {
    try {
      String barcode; 
      await BarcodeScanner.scan().then((value) => barcode = value.toString());
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code != BarcodeScanner.cameraAccessDenied) {
        setState(() => this.barcode = 'Unknown error: $e');
      } else {
        setState(() {
          this.barcode = 'No camera permission!';
        });
      }
    } on FormatException {
      setState(() => this.barcode =
      'Nothing captured.');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}



