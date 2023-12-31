// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_unnecessary_containers, constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:be_aydi/cubit/cubit.dart';
import 'package:be_aydi/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController barcode_controller = TextEditingController();
  bool isBarcode = false;
  bool isBarcode_scanner = false;
  bool isWrite = false;
  String barcode_scanner = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MasryCubit, MasryStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MasryCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF212121),
            title: Text(
              'بأيدي مصرية',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Container(
            color: Color(0xFF121212),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: barcode_controller,
                          onFieldSubmitted: (value) {
                            setState(() {
                              if (value == "") {
                                isWrite = false;
                              }
                              if (cubit.Products.containsKey(
                                  barcode_controller.text)) {
                                isBarcode = true;
                                isBarcode_scanner = false;
                              } else {
                                isBarcode = false;
                              }
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              if (value == "") {
                                isWrite = false;
                              } else {
                                isWrite = true;
                              }
                              if (cubit.Products.containsKey(
                                  barcode_controller.text)) {
                                isBarcode = true;
                                isBarcode_scanner = false;
                              } else {
                                isBarcode = false;
                              }
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "أدخل باركود المنتج",
                            labelStyle: TextStyle(
                              color: Colors.white70,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white70,
                            ),
                            fillColor: Color(0xFF303030),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white54, width: 1.0),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF2196F3), width: 1.0),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      CircleAvatar(
                        radius: 25.0,
                        backgroundColor: Colors.grey[800],
                        child: IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            size: 30.0,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            var res = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SimpleBarcodeScannerPage(
                                    lineColor: colorToHex(Colors.blue),
                                  ),
                                ));
                            setState(() {
                              isWrite = true;
                              if (res == "") {
                                isWrite = false;
                              }
                              if (res is String && res != "") {
                                barcode_scanner = res;
                                if (cubit.Products.containsKey(
                                    barcode_scanner)) {
                                  isBarcode_scanner = true;
                                  isBarcode = true;
                                  barcode_controller.text = "";
                                } else {
                                  isBarcode_scanner = false;
                                  isBarcode = false;
                                }
                              } else {
                                isBarcode_scanner = false;
                                isBarcode = false;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Expanded(
                    child: isWrite
                        ? Center(
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: isBarcode
                                  ? Center(
                                      child: Container(
                                        width: double.infinity,
                                        height: MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF303030),
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          border: Border.all(
                                            color: Colors.blue,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 80.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[800],
                                                  borderRadius:
                                                      BorderRadius.circular(16.0),
                                                  border: Border.all(
                                                    color: Colors.blue,
                                                    width: 0.50,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        "مصرية ",
                                                        style: TextStyle(
                                                          fontSize: 40,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        "بأيدي",
                                                        style: TextStyle(
                                                          fontSize: 40,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Center(
                                                child: Text(
                                                  'اسم المنتج',
                                                  style: TextStyle(
                                                    fontSize: 17.0,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${isBarcode_scanner ? cubit.Products[barcode_scanner]!["name"] : cubit.Products[barcode_controller.text]!["name"]}',
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.red,
                                                thickness: 3.0,
                                                height: 5.0,
                                                indent: 40,
                                                endIndent: 40,
                                              ),
                                              Center(
                                                child: Text(
                                                  'باركود المنتج',
                                                  style: TextStyle(
                                                    fontSize: 17.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${isBarcode_scanner ? cubit.Products[barcode_scanner]!["barcode"] : cubit.Products[barcode_controller.text]!["barcode"]}',
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.white,
                                                thickness: 3.0,
                                                height: 5.0,
                                                indent: 40,
                                                endIndent: 40,
                                              ),
                                              Center(
                                                child: Text(
                                                  'وصف المنتج',
                                                  style: TextStyle(
                                                    fontSize: 17.0,
                                                    color: Colors.yellow,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${isBarcode_scanner ? cubit.Products[barcode_scanner]!["description"] : cubit.Products[barcode_controller.text]!["description"]}',
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.black,
                                                thickness: 3.0,
                                                height: 5.0,
                                                indent: 40,
                                                endIndent: 40,
                                              ),
                                              Center(
                                                child: Text(
                                                  'تقييم المنتج',
                                                  style: TextStyle(
                                                    fontSize: 17.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              RatingBar.builder(
                                                initialRating: isBarcode_scanner ? cubit.Products[barcode_scanner]!["rate"] : cubit.Products[barcode_controller.text]!["rate"],
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                itemBuilder: (context, _) => Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                                onRatingUpdate: (rating) {
                                                },
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        '!غير موجود ',
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                            ),
                          )
                        : Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'أدخل باركود المنتج',
                                    style: TextStyle(
                                        fontSize: 25.0, color: Colors.grey),
                                  ),
                                  Text(
                                    'أو',
                                    style: TextStyle(
                                        fontSize: 25.0, color: Colors.grey),
                                  ),
                                  Text(
                                    'قم بقرائته بإستخدام الكاميرا',
                                    style: TextStyle(
                                        fontSize: 25.0, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


String colorToHex(Color color) {
  String hex = color.value.toRadixString(16);
  return '#${hex.substring(2)}';
}
