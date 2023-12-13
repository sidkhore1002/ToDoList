import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  HomeScreen createState() => HomeScreen();
}

class HomeScreen extends State<Home> {
  var newTaskName = "";
  var updateTaskName = "";
  var todayObj = [];
  var tomorrowObj = [];
  var upcomingObj = [];

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //today's data
    var todayData = prefs.getString("todayObjshared");
    print(todayData);
    if (todayData != null) {
      setState(() {
        todayObj = jsonDecode(todayData);
      });
    } else {
      setState(() {
        todayObj = [];
      });
    }

    //tomorrow's data
    var tomorrowData = prefs.getString("tomorrowObjshared");
    print(tomorrowData);
    if (tomorrowData != null) {
      setState(() {
        tomorrowObj = jsonDecode(tomorrowData);
      });
    } else {
      setState(() {
        tomorrowObj = [];
      });
    }

    //upcoming's data
    var upcomingData = prefs.getString("upcomingObjshared");
    print(upcomingData);
    if (upcomingData != null) {
      setState(() {
        upcomingObj = jsonDecode(upcomingData);
      });
    } else {
      setState(() {
        upcomingObj = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  addNewTask(todayTomorrowUpcomingObj, num1) {
    var mediaQuery = MediaQuery.of(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Add New Task..'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: [
                    Container(
                        width: mediaQuery.size.width * 0.45,
                        height: mediaQuery.size.height * 0.065,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 3,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        child: TextField(
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          onChanged: (text) {
                            setState(() {
                              newTaskName = text;
                            });
                          },
                          style: TextStyle(
                              fontSize: mediaQuery.size.width * 0.045,
                              color: Colors.black),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: 'Enter Task name',
                            hintStyle: TextStyle(
                                fontSize: mediaQuery.size.width * 0.04),
                            counterText: '',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 0, top: 0),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            actions: [
              Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      child: const Text("Add"),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        if (newTaskName != "") {
                          todayTomorrowUpcomingObj
                              .add({'eventName': newTaskName});
                          newTaskName = "";
                          if (num1 == 1) {
                            setState(() {
                              todayObj = todayTomorrowUpcomingObj;
                            });
                            await prefs.setString(
                                "todayObjshared", jsonEncode(todayObj));
                          }
                          if (num1 == 2) {
                            setState(() {
                              tomorrowObj = todayTomorrowUpcomingObj;
                            });
                            await prefs.setString(
                                "tomorrowObjshared", jsonEncode(tomorrowObj));
                          }
                          if (num1 == 3) {
                            setState(() {
                              upcomingObj = todayTomorrowUpcomingObj;
                            });
                            await prefs.setString(
                                "upcomingObjshared", jsonEncode(upcomingObj));
                          }
                        }
                        Navigator.pop(context);
                      }))
            ],
          );
        });
  }

  updateTask(todayTomorrowUpcomingObj, index, num1) {
    var mediaQuery = MediaQuery.of(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Update Task Name'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: [
                    Container(
                        width: mediaQuery.size.width * 0.45,
                        height: mediaQuery.size.height * 0.065,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 3,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        child: TextField(
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          onChanged: (text) {
                            setState(() {
                              updateTaskName = text;
                            });
                          },
                          style: TextStyle(
                              fontSize: mediaQuery.size.width * 0.045,
                              color: Colors.black),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: 'Enter Task name',
                            hintStyle: TextStyle(
                                fontSize: mediaQuery.size.width * 0.04),
                            counterText: '',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 0, top: 0),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            actions: [
              Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      child: Text("Update"),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        if (updateTaskName != "") {
                          todayTomorrowUpcomingObj[index]['eventName'] =
                              updateTaskName;
                          updateTaskName = "";

                          if (num1 == 1) {
                            setState(() {
                              todayObj = todayTomorrowUpcomingObj;
                            });
                            await prefs.setString(
                                "todayObjshared", jsonEncode(todayObj));
                          }
                          if (num1 == 2) {
                            setState(() {
                              tomorrowObj = todayTomorrowUpcomingObj;
                            });
                            await prefs.setString(
                                "tomorrowObjshared", jsonEncode(tomorrowObj));
                          }
                          if (num1 == 3) {
                            setState(() {
                              upcomingObj = todayTomorrowUpcomingObj;
                            });
                            await prefs.setString(
                                "upcomingObjshared", jsonEncode(upcomingObj));
                          }
                        }
                        Navigator.pop(context);
                      }))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: false, // set it to false
        body: SafeArea(
            child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: mediaQuery.size.width * 0.05,
                    ),
                    Text(
                      "To Do List",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: mediaQuery.size.width * 0.05,
                          color: Colors.blueAccent),
                    ),

// Today
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Today's Tasks: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        IconButton(
                          iconSize: 30,
                          icon: const Icon(
                            Icons.add,
                          ),
                          onPressed: () async {
                            addNewTask(todayObj, 1);
                          },
                        ),
                      ],
                    ),
                    Center(
                        child: Container(
                            margin: EdgeInsets.only(
                                bottom: mediaQuery.size.width * 0.05),
                            padding: EdgeInsets.only(
                                top: mediaQuery.size.width * 0.01),
                            width: mediaQuery.size.width * 0.8,
                            height: mediaQuery.size.height * 0.18,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 3.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(0, 2),
                                  )
                                ],
                                color: Colors.blueAccent.withOpacity(0.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: ListView.builder(
                                itemCount: todayObj.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                      padding: EdgeInsets.only(
                                          right: mediaQuery.size.width * 0.15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(todayObj[index]['eventName']
                                              .toString()),
                                          IconButton(
                                            iconSize: 20,
                                            icon: const Icon(
                                              Icons.edit_document,
                                            ),
                                            onPressed: () {
                                              updateTask(todayObj, index, 1);
                                            },
                                          ),
                                          IconButton(
                                            iconSize: 20,
                                            icon: const Icon(
                                              Icons.delete_forever_outlined,
                                            ),
                                            onPressed: () async {
                                              todayObj.remove(todayObj[index]);
                                              setState(
                                                () {
                                                  todayObj = todayObj;
                                                },
                                              );
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              await prefs.setString(
                                                  "todayObjshared",
                                                  jsonEncode(todayObj));
                                            },
                                          ),
                                        ],
                                      ));
                                }))),

// Tomorrow
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Tomorrow's Tasks: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        IconButton(
                          iconSize: 30,
                          icon: const Icon(
                            Icons.add,
                          ),
                          onPressed: () async {
                            addNewTask(tomorrowObj, 2);
                          },
                        ),
                      ],
                    ),
                    Center(
                        child: Container(
                            margin: EdgeInsets.only(
                                bottom: mediaQuery.size.width * 0.05),
                            padding: EdgeInsets.only(
                                top: mediaQuery.size.width * 0.01),
                            width: mediaQuery.size.width * 0.8,
                            height: mediaQuery.size.height * 0.18,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 3.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(0, 2),
                                  )
                                ],
                                color: Colors.orangeAccent.withOpacity(0.7),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: ListView.builder(
                                itemCount: tomorrowObj.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                      padding: EdgeInsets.only(
                                          right: mediaQuery.size.width * 0.15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(tomorrowObj[index]['eventName']
                                              .toString()),
                                          IconButton(
                                            iconSize: 20,
                                            icon: const Icon(
                                              Icons.edit_document,
                                            ),
                                            onPressed: () {
                                              updateTask(tomorrowObj, index, 2);
                                            },
                                          ),
                                          IconButton(
                                            iconSize: 20,
                                            icon: const Icon(
                                              Icons.delete_forever_outlined,
                                            ),
                                            onPressed: () async {
                                              tomorrowObj
                                                  .remove(tomorrowObj[index]);
                                              setState(
                                                () {
                                                  tomorrowObj = tomorrowObj;
                                                },
                                              );
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              await prefs.setString(
                                                  "tomorrowObjshared",
                                                  jsonEncode(tomorrowObj));
                                            },
                                          ),
                                        ],
                                      ));
                                }))),

// upcoming
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Upcoming Tasks: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        IconButton(
                          iconSize: 30,
                          icon: const Icon(
                            Icons.add,
                          ),
                          onPressed: () async {
                            addNewTask(upcomingObj, 3);
                          },
                        ),
                      ],
                    ),
                    Center(
                        child: Container(
                            padding: EdgeInsets.only(
                                top: mediaQuery.size.width * 0.01),
                            width: mediaQuery.size.width * 0.8,
                            height: mediaQuery.size.height * 0.18,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 3.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(0, 2),
                                  )
                                ],
                                color: Colors.purple.withOpacity(0.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: ListView.builder(
                                itemCount: upcomingObj.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                      padding: EdgeInsets.only(
                                          right: mediaQuery.size.width * 0.15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(upcomingObj[index]['eventName']
                                              .toString()),
                                          IconButton(
                                            iconSize: 20,
                                            icon: const Icon(
                                              Icons.edit_document,
                                            ),
                                            onPressed: () {
                                              updateTask(upcomingObj, index, 3);
                                            },
                                          ),
                                          IconButton(
                                            iconSize: 20,
                                            icon: const Icon(
                                              Icons.delete_forever_outlined,
                                            ),
                                            onPressed: () async {
                                              upcomingObj
                                                  .remove(upcomingObj[index]);
                                              setState(
                                                () {
                                                  upcomingObj = upcomingObj;
                                                },
                                              );
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              await prefs.setString(
                                                  "upcomingObjshared",
                                                  jsonEncode(upcomingObj));
                                            },
                                          ),
                                        ],
                                      ));
                                }))),
                  ],
                ))));
  }
}
