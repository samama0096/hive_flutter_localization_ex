import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sms/classes/app_localization.dart';
import 'package:sms/hiveTest/notes.dart';

class homev extends StatefulWidget {
  homev({Key key}) : super(key: key);

  @override
  _homevState createState() => _homevState();
}

class _homevState extends State<homev> {
  @override
  void initState() {
    super.initState();
    savedNotes();
  }

  var box;
  Notes empNote =
      new Notes(name: "null", title: "null", desc: "Nothing to show here!");
  List<Notes> notes_list = [];
  void savedNotes() async {
    box = await Hive.openBox<Notes>('notes');

    setState(() {
      notes_list = box.values.toList();
    });
  }

  void delete(int index) async {
    final box = await Hive.openBox<Notes>('notes');
    box.deleteAt(index);
    setState(() => {notes_list.removeAt(index)});
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_label
   

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow[700],
        onPressed: () {
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => addN()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        centerTitle: true,
        title: Text(ApplicationLocalizations.of(context).translate("My Notes")),
      ),
      body: ListView.builder(
          itemCount: notes_list.length,
          itemBuilder: (context, index) {
            Notes note = notes_list[index];
            var _name = note.name;
            var _title = note.title;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0)), //this right here
                          child: Container(
                            color: Colors.grey[300],
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${note.desc}",
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  width: size.width * 0.7,
                  height: size.height * 0.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: IconButton(
                            splashColor: Colors.green,
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => det(
                                            note: note,
                                            index: index,
                                          )));
                            }),
                        trailing: IconButton(
                            splashColor: Colors.red,
                            icon: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              delete(index);
                            }),
                        title: Text(
                          _title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        subtitle: Text(
                          "$_name",
                          style: TextStyle(color: Colors.yellow[700]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class addN extends StatefulWidget {
  addN({Key key}) : super(key: key);

  @override
  _addNState createState() => _addNState();
}

class _addNState extends State<addN> {
  TextEditingController name = new TextEditingController();
  TextEditingController title = new TextEditingController();
  TextEditingController desc = new TextEditingController();
  String nametxt;
  String titletxt;
  String userNotetxt;

  void addNotes(Notes note) async {
    var box = await Hive.openBox<Notes>('notes');
    box.add(note);
    box.close();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              ApplicationLocalizations.of(context).translate("New Note"),
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: ListView(children: [
            Container(
              width: s.width * 0.9,
              margin: EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 35,
                    width: s.width * 0.7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[300]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: ApplicationLocalizations.of(context)
                                .translate("Name"),
                            hintStyle: TextStyle(color: Colors.black45)),
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                        controller: name,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 35,
                    width: s.width * 0.7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[300]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: ApplicationLocalizations.of(context)
                                .translate("Title"),
                            hintStyle: TextStyle(color: Colors.black45)),
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                        controller: title,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    height: 100,
                    width: s.width * 0.7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[300]),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: ApplicationLocalizations.of(context)
                                  .translate("Your Thoughts"),
                              hintStyle: TextStyle(color: Colors.black45)),
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                          controller: desc,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  GestureDetector(
                    child: Container(
                      height: 30,
                      width: s.width * 0.6,
                      decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                            ApplicationLocalizations.of(context)
                                .translate("Save"),
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                    onTap: () async {
                      setState(() {
                        nametxt = name.text;
                        titletxt = title.text;
                        userNotetxt = desc.text;
                      });
                      if (nametxt.isNotEmpty &&
                          titletxt.isNotEmpty &&
                          userNotetxt.isNotEmpty) {
                        Notes addnote = new Notes(
                            name: nametxt, title: titletxt, desc: userNotetxt);
                        addNotes(addnote);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => homev()),
                            (r) => false);
                      }
                    },
                  )
                ],
              ),
            ),
          ])),
    );
  }
}

class det extends StatefulWidget {
  final Notes note;
  final int index;
  det({this.note, this.index});

  @override
  _detState createState() => _detState();
}

class _detState extends State<det> {
  TextEditingController name = new TextEditingController();
  TextEditingController title = new TextEditingController();
  TextEditingController desc = new TextEditingController();
  String nametxt;
  String titletxt;
  String userNotetxt;

  // ignore: non_constant_identifier_names
  void Update(int index, Notes note) async {
    var box = await Hive.openBox<Notes>('notes');
    box.putAt(index, note);
    box.close();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              ApplicationLocalizations.of(context).translate("New Note"),
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: ListView(children: [
            Container(
              width: s.width * 0.9,
              margin: EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 35,
                    width: s.width * 0.7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[300]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      child: TextFormField(
                        initialValue: widget.note.name,
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                        controller: name,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 35,
                    width: s.width * 0.7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[300]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: TextFormField(
                        initialValue: widget.note.title,
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                        controller: title,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    height: 100,
                    width: s.width * 0.7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[300]),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: TextFormField(
                          initialValue: widget.note.desc,
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                          controller: desc,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  GestureDetector(
                    child: Container(
                      height: 30,
                      width: s.width * 0.6,
                      decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                            ApplicationLocalizations.of(context)
                                .translate("Update"),
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                    onTap: () async {
                      setState(() {
                        nametxt = name.text;
                        titletxt = title.text;
                        userNotetxt = desc.text;
                      });

                      if (nametxt.isNotEmpty &&
                          titletxt.isNotEmpty &&
                          userNotetxt.isNotEmpty) {
                        Notes update = new Notes(
                            name: nametxt, title: titletxt, desc: userNotetxt);
                        Update(widget.index, update);

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => homev()),
                            (r) => false);
                      }
                    },
                  )
                ],
              ),
            ),
          ])),
    );
  }
}
