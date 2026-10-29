import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:famoo/main.dart';
import 'package:famoo/pages/pages.dart';
import 'package:intl/intl.dart';

class Editpage extends StatefulWidget {
  const Editpage({super.key, required this.item, required this.data});
  final Item item;
  final Map data;

  @override
  State<Editpage> createState() => _EditpageState();
}

class _EditpageState extends State<Editpage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool fav = false;
  Item get itemm => widget.item;
  Map get data => widget.data;
  List<TextEditingController> cns = [];
  Map r = {
    "name": "",
    "phone number": "",
    "note": null,
    "date": null,
    "img": null,
  };
  bool t = false;

  late Map<dynamic, dynamic> rcmap = {
    'dateController': TextEditingController(
      text: "${itemm.date.year}/${itemm.date.month}/${itemm.date.day}",
    ),
    'nameController': TextEditingController(text: itemm.name),
    'foneController': TextEditingController(text: itemm.fonenumber),
    'noteController': TextEditingController(text: itemm.note),
  };

  void go() {
    for (int i = 0; i < data.length; i++) {
      cns.add(TextEditingController(text: data.values.toList()[i].toString()));
    }
    fav = widget.item.isfav;
    r['date'] = widget.item.date;
    if (widget.item.img != null) {
      setState(() {
        r['img'] = widget.item.img;
        t = true;
      });
    } else {}
  }

  //------------------imagepic--------------------------
  ImagePicker imgpicker = ImagePicker();
  Future uploadimg() async {
    final pickedimg = await imgpicker.pickImage(source: ImageSource.gallery);
    if (pickedimg != null) {
      setState(() {
        r['img'] = XFile(pickedimg.path);
        t = true;
      });
    } else {}
  }

  //------------------imagepic--------------------------

  @override
  void initState() {
    go();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    fav = false;
  }

  @override
  Widget build(BuildContext context) {
    final isdark = Provider.of<ThemeProvider>(context).isdark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(
              context,
            ).pushReplacement(MaterialPageRoute(builder: (context) => Pages()));
          },
        ),
        title: Row(
          children: [
            Text('Add Clothes Item'),
            SizedBox(width: 80),
            IconButton(
              onPressed: () {
                setState(() {
                  fav = !fav;
                });
              },
              icon: (!isdark)
                  ? (fav)
                        ? Icon(
                            Icons.star,
                            color: const Color(0xFFFFFFFF),
                            size: 30,
                          )
                        : Icon(Icons.star_border, size: 30)
                  : (fav)
                  ? Icon(Icons.star, size: 30)
                  : Icon(Icons.star_border, size: 30),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 12),
                    Text(
                      """Clint Details                                          """,

                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    ...List.generate(
                      2,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: TextFormField(
                          controller: index == 0
                              ? rcmap['nameController']
                              : rcmap['foneController'],
                          keyboardType: index == 0
                              ? TextInputType.name
                              : TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter ${r.keys.toList()[index].toString().toCapitalCase()}';
                            } else if (index == 1 && value.length != 11) {
                              return 'Phone Number Not Correct';
                            }
                            return null;
                          },

                          decoration: InputDecoration(
                            labelText:
                                r.keys.toList()[index].toString().toCapitalCase(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              gapPadding: 4,
                            ),
                          ),
                          onSaved: (value) {
                            setState(() {
                              r[r.keys.elementAt(index)] = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Date",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            gapPadding: 4,
                          ),
                        ),
                        controller: rcmap['dateController'],
                        readOnly: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select a date";
                          }
                          return null;
                        },
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2100),
                          );

                          if (date != null) {
                            rcmap['dateController'].text = DateFormat(
                              'yyyy/MM/dd',
                            ).format(date);
                            r['date'] = date; // DateTime
                          }
                        },
                      ),
                    ),
                    Text(
                      """Measurements                                     """,

                      style: Theme.of(context).textTheme.labelMedium,
                    ),

                    ...List.generate(
                      data.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: TextFormField(
                          controller: cns[index],
                          keyboardType: TextInputType.number,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter ${data.keys.toList()[index]}'
                              : null,
                          decoration: InputDecoration(
                            labelText: data.keys.toList()[index],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              gapPadding: 4,
                            ),
                          ),
                          onSaved: (value) {
                            data[data.keys.toList()[index]] = double.parse(
                              value!,
                            );
                            // cns[index].text =value;
                          },
                        ),
                      ),
                    ),

                    Text(
                      """Notes / Images                                      """,

                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: rcmap['noteController'],
                              maxLength: 40,
                              minLines: 3,
                              maxLines: 3,
                              decoration: InputDecoration(
                                hintText: "Notes...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  gapPadding: 4,
                                ),
                              ),
                              onSaved: (value) {
                                setState(() {
                                  r['note'] = value!;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(7),
                              child: InkWell(
                                onLongPress: () {
                                  if (r['img'] != null) {
                                    setState(() {
                                      r['img'] = null;
                                      t = false;
                                    });
                                  }
                                },
                                onTap: () async {
                                  await uploadimg();
                                  if (!t && r['img'] != null) {
                                    setState(() {
                                      t = true;
                                    });
                                  } else {}
                                },
                                child: Container(
                                  margin: EdgeInsets.all(1.5),
                                  height: 106,
                                  width: 106,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: t
                                          ? Color(0xFFC5A059)
                                          :  (isdark) ?Color(0xffb8a597):Colors.black,
                                      width: t ? 2 : 0.6,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image, size: 30),
                                      Text(
                                        "Add Image",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 15),

                    InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          try {
                            setState(() {
                              widget.item.name = r['name'];
                              widget.item.fonenumber = r['phone number'];
                              widget.item.img = r['img'];
                              widget.item.isfav = fav;
                              widget.item.note = r['note'];
                              widget.item.date = r['date'];
                              // widget.item.clothesItem =
                              switch (widget.item.type) {
                                case 'dress':
                                  widget.item.clothesItem = Dress(
                                    bustCirc: data.values.toList()[0],
                                    waistCirc: data.values.toList()[1],
                                    hipCirc: data.values.toList()[2],
                                    frontLength: data.values.toList()[3],
                                    backLength: data.values.toList()[4],
                                    bustHeight: data.values.toList()[5],
                                    bustDistance: data.values.toList()[6],
                                    hipHeight: data.values.toList()[7],
                                    shoulderWidth: data.values.toList()[8],
                                    backWidth: data.values.toList()[9],
                                    sleevesLength: data.values.toList()[10],
                                    wristCirc: data.values.toList()[11],
                                    muscleCirc: data.values.toList()[12],
                                    kneeLength: data.values.toList()[13],
                                    dressLength: data.values.toList()[14],
                                    height: data.values.toList()[15],
                                  );
                                  break;

                                case 'jacket':
                                  widget.item.clothesItem = Jacket(
                                    bustCirc: data.values.toList()[0],
                                    waistCirc: data.values.toList()[1],
                                    hipCirc: data.values.toList()[2],
                                    frontLength: data.values.toList()[3],
                                    backLength: data.values.toList()[4],
                                    bustHeight: data.values.toList()[5],
                                    bustDistance: data.values.toList()[6],
                                    hipHeight: data.values.toList()[7],
                                    shoulderWidth: data.values.toList()[8],
                                    backWidth: data.values.toList()[9],
                                    sleevesLength: data.values.toList()[10],
                                    wristCirc: data.values.toList()[11],
                                    muscleCirc: data.values.toList()[12],
                                    jacketLength: data.values.toList()[13],
                                    height: data.values.toList()[14],
                                  );
                                  break;

                                case 'pants':
                                  widget.item.clothesItem = Pants(
                                    waistCirc: data.values.toList()[0],
                                    hipCirc: data.values.toList()[1],
                                    hipHeight: data.values.toList()[2],
                                    crotchHeight: data.values.toList()[3],
                                    kneeLength: data.values.toList()[4],
                                    pantsLength: data.values.toList()[5],
                                    height: data.values.toList()[6],
                                  );
                                  break;
                              }
                            });

                            sortItems(clothesItems);
                            await LocalStorageService.instance.saveItems(
                              clothesItems,
                              (item) => item.toMap(),
                            );

                            Navigator.of(context).pop();
                            //------------------------------------------------------
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: Text(
                                    '''Please enter valid numbers for all fields.

ERORR: $e''',
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          //------------------------------------------------------
                        }
                      },

                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFC5A059),
                          border: Border.all(
                            width: 1.5,
                            color: Color(0xFFE8D5B7),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x5aC5A059),
                              offset: Offset(2, 5),
                              blurRadius: 5,
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        alignment: Alignment.center,

                        height: 50,
                        width: 110,

                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
