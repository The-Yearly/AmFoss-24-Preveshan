import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:sqflite/sqflite.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  List items = [];
  List ids = [];
  dynamic m = 0;
  var db;
  Future<void> readfav() async {
    db = await openDatabase("hero.db", version: 2, onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE fav(id INTEGER PRIMARY KEY)",
      );
    });
    List<Map> b = await db.rawQuery("select id from fav");
    ids.clear();
    for (var g in b) {
      ids.add(g["id"]);
    }
    print(ids);
  }

  Future<void> readJson() async {
    final String responce =
        await rootBundle.loadString("assets/superhero.json");
    final data = await json.decode(responce);
    setState(() {
      items = data;
    });

    _runFilter(m);
  }

  @override
  List _filtered = [];
  void initState() {
    _filtered = items;
    super.initState();
    readJson();
    readfav();
  }

  void _runFilter(dynamic v) async {
    List<dynamic> results = [];
    await readfav();
    if (v == 0) {
      results = items;
    } else if (v == 1) {
      results = items
          .where((user) => user["biography"]["alignment"] == "good")
          .toList();
    } else if (v == 2) {
      results = items
          .where((user) => user["biography"]["alignment"] == "bad")
          .toList();
    } else if (v == 3) {
      results = items
          .where((user) => user["biography"]["alignment"] == "neutral")
          .toList();
    } else if (v == 4) {
      results = items.where((user) => ids.contains(user["id"])).toList();
    } else {
      results = items
          .where((user) => user["name"].toLowerCase().contains(v.toLowerCase()))
          .toList();
    }
    setState(() {
      _filtered = results;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      endDrawer: Drawer(
        width: 200,
        backgroundColor: Color.fromARGB(255, 19, 18, 21),
        child: ListView(
          children: [
            Align(
                alignment: Alignment(-0.2, 0),
                child: Text(
                  "Lost Files",
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "JMH Typewriter",
                      fontSize: 30),
                )),
            Container(
              width: 200,
              height: 80,
              child: InkWell(
                onTap: () {
                  m = 1;
                  _runFilter(m);
                },
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(-0.8, 0),
                      child: Image(
                        image: AssetImage('assets/images/mask.png'),
                        width: 50,
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.3, 0),
                      child: Text(
                        "Hero's",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "JMH Typewriter",
                            fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: 200,
              height: 80,
              child: InkWell(
                onTap: () {
                  m = 2;
                  _runFilter(m);
                },
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(-1, -0.9),
                      child: Image(
                        image: AssetImage('assets/images/loki.png'),
                        width: 60,
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.5, 0),
                      child: Text(
                        "Villan's",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "JMH Typewriter",
                            fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: 200,
              height: 80,
              child: InkWell(
                onTap: () {
                  m = 3;
                  _runFilter(m);
                },
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(-0.8, -0.4),
                      child: Image(
                        image: AssetImage('assets/images/deadpool.png'),
                        width: 50,
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.6, 0),
                      child: Text(
                        "Anti-Hero's",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "JMH Typewriter",
                            fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
                width: 200,
                height: 80,
                child: InkWell(
                  onTap: () {
                    m = 0;
                    _runFilter(m);
                  },
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment(-0.8, -0.4),
                        child: Image(
                          image: AssetImage('assets/images/all.png'),
                          width: 50,
                        ),
                      ),
                      Align(
                        alignment: Alignment(0, 0),
                        child: Text(
                          "All",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "JMH Typewriter",
                              fontSize: 20),
                        ),
                      )
                    ],
                  ),
                )),
            Container(
                width: 200,
                height: 80,
                child: InkWell(
                  onTap: () {
                    m = 4;
                    _runFilter(m);
                  },
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment(-0.8, -0.2),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Align(
                        alignment: Alignment(0.3, 0),
                        child: Text(
                          "Favourite",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "JMH Typewriter",
                              fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 19, 18, 21),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        leading: Image(
          image: AssetImage('assets/images/mask.png'),
        ),
        title: Stack(children: [
          Text(
            "Hero Dex",
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w900),
          ),
          Align(
            alignment: Alignment(1.2, -1),
            child: Container(
                width: 120,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: TextField(
                    onChanged: (value) {
                      m = value;
                      _runFilter(m);
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.search),
                    ))),
          ),
        ]),
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: List.generate(_filtered.length, (index) {
          return GestureDetector(
            onTap: () async {
              await readfav();
              print(ids);
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => profile(
                    img: _filtered[index]["images"]["md"],
                    pf: jsonEncode(_filtered[index]),
                    id: ids,
                  ),
                ),
              ).whenComplete(readfav);
              setState(() {
                _runFilter(m);
              });
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(1, 20, 1, 20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 19, 18, 21),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              height: 230,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(-0.9, -0.9),
                    child: Text(
                      "#Case Id : " + _filtered[index]["id"].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "JMH Typewriter",
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.9, -0.4),
                    child: Text(
                      "Name : " + _filtered[index]["name"],
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "JMH Typewriter",
                      ),
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.9, -0.1),
                    child: Text(
                      "Race : " +
                          (_filtered[index]["appearance"]["race"] != null
                              ? _filtered[index]["appearance"]["race"]
                              : "Race Unknown"),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "JMH Typewriter",
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.9, 0.2),
                    child: Text(
                      "Gender : " + _filtered[index]["appearance"]["gender"],
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "JMH Typewriter",
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Align(
                    alignment: Alignment(-0.9, 0.5),
                    child: Text(
                      "Status: " +
                          (_filtered[index]["biography"]["alignment"] == "good"
                              ? 'Hero'
                              : _filtered[index]["biography"]["alignment"] ==
                                      "neutral"
                                  ? 'Anti-Hero'
                                  : 'Villain'),
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "JMH Typewriter",
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Align(
                    alignment: Alignment(
                      -0.9,
                      0.9,
                    ),
                    child: Icon(Icons.favorite,
                        color: (ids.contains(_filtered[index]["id"])
                            ? Colors.red
                            : Colors.white)),
                  ),
                  Hero(
                    tag: _filtered[index]["images"]["md"],
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Image.network(
                          _filtered[index]["images"]["md"],
                          width: 160,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    ));
  }
}

class profile extends StatefulWidget {
  final String img;
  final String pf;
  var id;
  profile({Key? key, required this.img, required this.pf, required this.id})
      : super(key: key);
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  late Map<String, dynamic> pfp;
  @override
  var ids = [];
  Future<void> readdb() async {
    ids.clear();
    var db = await openDatabase("hero.db");
    List<Map> b = await db.rawQuery("select id from fav");
    print("in");
    print(b);
    for (var g in b) {
      ids.add(g["id"]);
    }
  }

  void initState() {
    super.initState();
    pfp = jsonDecode(widget.pf);
    ids = widget.id;
    print("i");
    print(ids);
  }

  Future<void> a() async {
    var db = await openDatabase("hero.db");
    List<Map> b = await db.rawQuery("select id from fav");
    ids.clear();
    for (var g in b) {
      ids.add(g["id"]);
    }
    print(ids);
    if (ids.contains(pfp["id"]) == false) {
      await db.rawInsert("insert into fav(id) values(?)", [pfp["id"]]);
      setState(() {
        ids.add(pfp["id"]);
      });
    } else {
      await db.rawDelete("delete from fav where id=?", [pfp["id"]]);
      setState(() {
        ids.remove(pfp["id"]);
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(1, 20, 1, 20),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 19, 18, 21),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 3)),
                ]),
            height: 400,
            child: Hero(
                tag: widget.img,
                child: Center(child: Image.network(pfp["images"]["lg"]))),
          ),
          Container(
            height: 300,
            child: ListView(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 340,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 19, 18, 21),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Rap Sheet",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "JMH Typewriter",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.9, -0.4),
                        child: Text(
                          "Name : " + pfp["name"],
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "JMH Typewriter",
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.9, -0.1),
                        child: Text(
                          "Full Name: " +
                              (pfp["biography"]["fullName"] != ""
                                  ? pfp["biography"]["fullName"]
                                  : pfp["name"]),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "JMH Typewriter",
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.8, 0.2),
                        child: Text(
                          "Alter Ego's : " + pfp["biography"]["alterEgos"],
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "JMH Typewriter",
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.9, 0.5),
                        child: Text(
                          "Base: " +
                              (pfp["work"]["base"] != "-"
                                  ? pfp["work"]["base"]
                                  : "Unknown"),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "JMH Typewriter",
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.9, 0.8),
                        child: Text(
                          "Status: " +
                              (pfp["biography"]["alignment"] == "good"
                                  ? 'Hero'
                                  : pfp["biography"]["alignment"] == "neutral"
                                      ? 'Anti-Hero'
                                      : 'Villain'),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "JMH Typewriter",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(5)),
                Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 19, 18, 21),
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Stats",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "JMH Typewriter",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment(-0.8, -0.6),
                      child: Text(
                        "Intelligence ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "JMH Typewriter",
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.83, -0.59),
                      child: Text(
                        pfp["powerstats"]["intelligence"].toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.9, -0.62),
                      child: Container(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          value: pfp["powerstats"]["intelligence"] * 0.01,
                          color: (pfp["powerstats"]["intelligence"] > 80
                              ? Colors.green
                              : pfp["powerstats"]["intelligence"] > 50
                                  ? Colors.lightGreen
                                  : pfp["powerstats"]["intelligence"] > 30
                                      ? Colors.yellow
                                      : pfp["powerstats"]["intelligence"] > 15
                                          ? Colors.amber
                                          : Colors.red),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(-0.8, -0.3),
                      child: Text(
                        "Strength ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "JMH Typewriter",
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.83, -0.3),
                      child: Text(
                        pfp["powerstats"]["strength"].toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.9, -0.32),
                      child: Container(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          value: pfp["powerstats"]["strength"] * 0.01,
                          color: (pfp["powerstats"]["strength"] > 80
                              ? Colors.green
                              : pfp["powerstats"]["strength"] > 50
                                  ? Colors.lightGreen
                                  : pfp["powerstats"]["strength"] > 30
                                      ? Colors.yellow
                                      : pfp["powerstats"]["strength"] > 15
                                          ? Colors.amber
                                          : Colors.red),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(-0.8, 0.31),
                      child: Text(
                        "Durablity ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "JMH Typewriter",
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.83, 0.31),
                      child: Text(
                        pfp["powerstats"]["durability"].toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.9, 0.31),
                      child: Container(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          value: pfp["powerstats"]["durability"] * 0.01,
                          color: (pfp["powerstats"]["durability"] > 80
                              ? Colors.green
                              : pfp["powerstats"]["durability"] > 50
                                  ? Colors.lightGreen
                                  : pfp["powerstats"]["durability"] > 30
                                      ? Colors.yellow
                                      : pfp["powerstats"]["durability"] > 15
                                          ? Colors.amber
                                          : Colors.red),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(-0.8, -0.01),
                      child: Text(
                        "Speed ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "JMH Typewriter",
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.83, -0.02),
                      child: Text(
                        pfp["powerstats"]["speed"].toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.9, -0.02),
                      child: Container(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          value: pfp["powerstats"]["speed"] * 0.01,
                          color: (pfp["powerstats"]["speed"] > 80
                              ? Colors.green
                              : pfp["powerstats"]["speed"] > 50
                                  ? Colors.lightGreen
                                  : pfp["powerstats"]["speed"] > 30
                                      ? Colors.yellow
                                      : pfp["powerstats"]["speed"] > 15
                                          ? Colors.amber
                                          : Colors.red),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(-0.8, 0.61),
                      child: Text(
                        "Power",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "JMH Typewriter",
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.83, 0.6),
                      child: Text(
                        pfp["powerstats"]["power"].toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.9, 0.62),
                      child: Container(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            value: pfp["powerstats"]["power"] * 0.01,
                            color: (pfp["powerstats"]["power"] > 80
                                ? Colors.green
                                : pfp["powerstats"]["power"] > 50
                                    ? Colors.lightGreen
                                    : pfp["powerstats"]["power"] > 30
                                        ? Colors.yellow
                                        : pfp["powerstats"]["speed"] > 15
                                            ? Colors.amber
                                            : Colors.red),
                            backgroundColor: Colors.white,
                          )),
                    ),
                    Align(
                      alignment: Alignment(-0.8, 0.91),
                      child: Text(
                        "Combat",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "JMH Typewriter",
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.83, 0.89),
                      child: Text(
                        pfp["powerstats"]["combat"].toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.9, 0.92),
                      child: Container(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            value: pfp["powerstats"]["combat"] * 0.01,
                            color: (pfp["powerstats"]["combat"] > 80
                                ? Colors.green
                                : pfp["powerstats"]["combat"] > 50
                                    ? Colors.lightGreen
                                    : pfp["powerstats"]["combat"] > 30
                                        ? Colors.yellow
                                        : pfp["powerstats"]["speed"] > 15
                                            ? Colors.amber
                                            : Colors.red),
                            backgroundColor: Colors.white,
                          )),
                    )
                  ]),
                ),
                Padding(padding: EdgeInsets.all(5)),
                Container(
                  width: 340,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 19, 18, 21),
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Appearance",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "JMH Typewriter",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.9, -0.7),
                        child: Text(
                          "Race : " +
                              (pfp["appearance"]["race"] != null
                                  ? pfp["appearance"]["race"]
                                  : "Race Unknown"),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "JMH Typewriter",
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.9, -0.4),
                        child: Text(
                          "Gender : " + (pfp["appearance"]["gender"]),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "JMH Typewriter",
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.9, -0.1),
                        child: Text(
                          "Height  : " +
                              (pfp["appearance"]["height"][0] != "-"
                                  ? pfp["appearance"]["height"][0]
                                  : "Unknown") +
                              '" or ' +
                              (pfp["appearance"]["height"][1] != "0 cm"
                                  ? pfp["appearance"]["height"][1]
                                  : "Unknown"),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "JMH Typewriter",
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.9, 0.2),
                        child: Text(
                          "Weight  : " +
                              (pfp["appearance"]["weight"][0] != "- lb"
                                  ? pfp["appearance"]["weight"][0]
                                  : "Unknown") +
                              ' or ' +
                              (pfp["appearance"]["weight"][1] != "0 kg"
                                  ? pfp["appearance"]["weight"][1]
                                  : "Unknown"),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "JMH Typewriter",
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.9, 0.5),
                        child: Text(
                          "Eye Color  : " +
                              (pfp["appearance"]["eyeColor"] != "-"
                                  ? pfp["appearance"]["eyeColor"]
                                  : "Unknown"),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "JMH Typewriter",
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.9, 0.8),
                        child: Text(
                          "Hair Color  : " +
                              (pfp["appearance"]["hairColor"] != "-"
                                  ? pfp["appearance"]["hairColor"]
                                  : "Unknown"),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "JMH Typewriter",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(5)),
                Container(
                  width: 340,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 19, 18, 21),
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Trivia",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "JMH Typewriter",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.5, -0.5),
                        child: Text(
                          "First Appearance : " +
                              (pfp["biography"]["firstAppearance"] != "-"
                                  ? pfp["biography"]["firstAppearance"]
                                  : "Race Unknown"),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "JMH Typewriter",
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.9, -0.1),
                        child: Text(
                          "Publisher : " +
                              (pfp["biography"]["publisher"] != null
                                  ? pfp["biography"]["publisher"]
                                  : "Unkonwn"),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "JMH Typewriter",
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.9, 0.2),
                        child: Text(
                          "Place of Birth  : " +
                              (pfp["biography"]["placeOfBirth"] != "-"
                                  ? pfp["biography"]["placeOfBirth"]
                                  : "Unknown"),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "JMH Typewriter",
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.9, 0.5),
                        child: Text(
                          "Publisher  : " + pfp["biography"]["publisher"],
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "JMH Typewriter",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(5)),
                Container(
                  width: 340,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 19, 18, 21),
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Family",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "JMH Typewriter",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.5, -0.5),
                        child: Text(
                          (pfp["connections"]["relatives"] != "-"
                              ? pfp["connections"]["relatives"]
                              : "Unknown"),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "JMH Typewriter",
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(5)),
                Container(
                  width: 340,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 19, 18, 21),
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Groups",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "JMH Typewriter",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.5, -0.5),
                        child: Text(
                          (pfp["connections"]["groupAffiliation"] != "-"
                              ? pfp["connections"]["groupAffiliation"]
                              : "Unknown"),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "JMH Typewriter",
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                        ),
                      ),
                      Align(
                        alignment: Alignment(-0.5, 0.4),
                        child: Text(
                          (pfp["work"]["occupation"] != "-"
                              ? pfp["work"]["occupation"]
                              : "Unknown"),
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "JMH Typewriter",
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(5)),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          await a();
        },
        child: Icon(
          (ids.contains(pfp["id"])
              ? Icons.favorite
              : Icons.favorite_border_outlined),
          color: Colors.black,
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: MyApp()));
}
