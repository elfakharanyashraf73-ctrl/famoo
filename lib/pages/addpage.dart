
import 'package:image_picker/image_picker.dart';
import 'package:famoo/main.dart';
import 'package:famoo/pages/pages.dart';
import 'package:intl/intl.dart';

class Addpage extends StatefulWidget {
  const Addpage({super.key, required this.type});
  final String type;
  @override
  State<Addpage> createState() => _AddpageState();
}

class _AddpageState extends State<Addpage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool fav = false;

  Map r = {
    "name": "",
    "phone number": "",
    "note": null,
    "date": null,
    "img": null,
  };
  bool t = false;
  TextEditingController textEditingController = TextEditingController();
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

  // ImagePicker imgpicker = ImagePicker();
  // Future uploadimg() async {
  //   FilePickerResult? pickedimg = await FilePicker.pickFiles(
  //     dialogTitle: 'image picer',
  //     type: FileType.image,
  //     allowMultiple: false
  //   );
  //   if (pickedimg != null) {
  //     setState(() {
  //       r['img'] = XFile(pickedimg.files.first.path!);
  //       t = true;
  //     });
  //   } else {}
  // }

  //------------------imagepic--------------------------
  Map<String, double> get data {
    switch (widget.type) {
      case "dress":
        return dress;

      case "jacket":
        return jacket;

      case "pants":
        return pants;

      default:
        return {};
    }
  }

  ClotheType get showdata {
    switch (widget.type) {
      case 'dress':
        return Dress(
          bustCirc: dress['Bust circ']!,
          waistCirc: dress['Waist circ']!,
          hipCirc: dress['Hip circ']!,
          frontLength: dress['Front length']!,
          backLength: dress['Back length']!,
          bustHeight: dress['Bust height']!,
          bustDistance: dress['Bust distance']!,
          hipHeight: dress['Hip height']!,
          shoulderWidth: dress['Shoulder width']!,
          backWidth: dress['Back width']!,
          sleevesLength: dress['Sleeves length']!,
          wristCirc: dress['Wrist circ']!,
          muscleCirc: dress['Muscle circ']!,
          kneeLength: dress['Knee length']!,
          dressLength: dress['Dress length']!,
          height: dress['Height']!,
        );
      case 'jacket':
        return Jacket(
          bustCirc: jacket['Bust circ']!,
          waistCirc: jacket['Waist circ']!,
          hipCirc: jacket['Hip circ']!,
          frontLength: jacket['Front length']!,
          backLength: jacket['Back length']!,
          bustHeight: jacket['Bust height']!,
          bustDistance: jacket['Bust distance']!,
          hipHeight: jacket['Hip height']!,
          shoulderWidth: jacket['Shoulder width']!,
          backWidth: jacket['Back width']!,
          sleevesLength: jacket['Sleeves length']!,
          wristCirc: jacket['Wrist circ']!,
          muscleCirc: jacket['Muscle circ']!,
          jacketLength: jacket['Jacket length']!,
          height: jacket['Height']!,
        );
      case 'pants':
        return Pants(
          waistCirc: pants['Waist circ']!,
          hipCirc: pants['Hip circ']!,
          hipHeight: pants['Hip height']!,
          crotchHeight: pants['Crotch height']!,
          kneeLength: pants['Knee length']!,
          pantsLength: pants['Pants length']!,
          height: pants['Height']!,
        );
      default:
        return Pants(
          waistCirc: 0,
          hipCirc: 0,
          hipHeight: 0,
          crotchHeight: 0,
          kneeLength: 0,
          pantsLength: 0,
          height: 0,
        );
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
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
                  ? Icon(Icons.star,  size: 30)
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
                        controller: textEditingController,
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
                            textEditingController.text = DateFormat(
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
                            data[data.keys.elementAt(index)] = double.parse(
                              value!,
                            );
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
                                          : (isdark) ?Color(0xffb8a597):Colors.black,
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
                            // switch (widget.type) {
                            //   case 'dress':
                            clothesItems.add(
                              Item(
                                id: "C#$getid",
                                img: r['img'],
                                name: r['name'],
                                date: r['date'],
                                note: r['note'],
                                type: widget.type,
                                isfav: fav,
                                fonenumber: r["phone number"],
                                clothesItem: showdata,
                              ),
                            );

                            print(
                              '${r['note']}==========================================================================================',
                            );

                            sortItems(clothesItems);

                            await LocalStorageService.instance.saveItems(
                              clothesItems,
                              (item) => item.toMap(),
                            );

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => Pages()),
                            );
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
