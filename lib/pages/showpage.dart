import 'dart:io';


import 'package:famoo/pages/editpage.dart';

import 'package:famoo/main.dart';
// import 'package:famoo/pages/pages.dart';
import 'package:famoo/pages/pdfpage.dart';

class Showpage extends StatefulWidget {
  const Showpage({super.key, required this.item});
  final Item item;
  @override
  State<Showpage> createState() => _ShowpageState();
}

class _ShowpageState extends State<Showpage> {
  Item get itemm=>widget.item;
  Map<String, dynamic> get data => itemm.clothesItem.toMap();

  @override
  void initState() {
    super.initState();
    setState(() {});
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
            ).pop();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "${itemm.name} Card",
                overflow: TextOverflow.fade,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  itemm.isfav = !itemm.isfav;
                });
              },
              icon: (!isdark)
                  ? (itemm.isfav)
                        ? Icon(
                            Icons.star,
                            color: const Color(0xFFFFFFFF),
                            size: 30,
                          )
                        : Icon(Icons.star_border, size: 30)
                  : (itemm.isfav)
                  ? Icon(Icons.star,  size: 30)
                  : Icon(Icons.star_border, size: 30),
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            color: Color(0xffC5A050),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.picture_as_pdf,color: (isdark) ?Colors.black:Colors.white),
                    Text("  PDF", style: TextStyle(fontSize: 14,color: (isdark) ?Colors.black:Colors.white)),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          PdfPage(item: itemm, data: data),
                    ),
                  );
                },
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.edit,color: (isdark) ?Colors.black:Colors.white,),
                    Text("  Edit", style: TextStyle(fontSize: 14,color: (isdark) ?Colors.black:Colors.white)),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          Editpage(item: itemm, data: data),
                    ),
                  );
                },
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Color(0xffff0000)),
                    Text(
                      "  Delete",
                      style: TextStyle(fontSize: 14, color: Color(0xffff0000)),
                    ),
                  ],
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          'Are you sure you want to delete this Item?',
                        ),

                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Close'),
                          ),
                          TextButton(
                            onPressed: () async {
                              clothesItems.removeWhere(
                                (item) => item.id == itemm.id,
                              );
                              await LocalStorageService.instance.saveItems(
                                clothesItems,
                                (item) => item.toMap(),
                              );
                              Navigator.of(context).pop();
                              
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),

      body: ListView(
        children: [
          SizedBox(height: 7,),
          Text(
            """      Clint Data""",
            style: Theme.of(context).textTheme.labelMedium,
            // textAlign: TextAlign.left,
          ),
          Container(
            margin: EdgeInsets.only(right: 20, left: 20, top: 2, bottom: 20),
            padding: EdgeInsets.all(10),
            child: Table(
              border: TableBorder.symmetric(
                inside: BorderSide(color: Color(0xFFe6dbcd), width: 1),
                outside: BorderSide(color: Color(0xff2f2f2f), width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color:(isdark)? Colors.black:Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  children: [
                    TableCell(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffc4a059),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                          ),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SelectableText(
                            "Name",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Pinky',
                              fontSize: 16,
                              color: (isdark)? Colors.black:Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SelectableText(
                          itemm.name,
                          textAlign: TextAlign.center,

                          style: (isdark)? TextStyle(
                            fontFamily: 'Pinky',
                            fontSize: 16,
                            color: Color(0xFFF5F0E6),
                          ):TextStyle(
                            fontFamily: 'Pinky',
                            fontSize: 16,
                            color: Color(0xff2b2a28),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  decoration: BoxDecoration(
                    color:(isdark)?Color(0xFF464646) : Color(0xfffdfbf6),
                    
                  ),
                  children: [
                    TableCell(
                      child: Container(
                      
                          color: Color(0xffc4a059),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SelectableText(
                            "Phone number",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Pinky',
                              fontSize: 16,
                              color: (isdark)? Colors.black:Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SelectableText(
                          itemm.fonenumber,
                          textAlign: TextAlign.center,
                          style: (isdark)? TextStyle(
                            fontFamily: 'Pinky',
                            fontSize: 16,
                            color: Color(0xFFF5F0E6),
                          ):TextStyle(
                            fontFamily: 'Pinky',
                            fontSize: 16,
                            color: Color(0xff2b2a28),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                  TableRow(
                  decoration: BoxDecoration(
                    color:(isdark)? Colors.black:Colors.white,
                    borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)
                    ),
                  ),
                  children: [
                    TableCell(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffc4a059),
                          borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          ),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SelectableText(
                            "Dead line",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Pinky',
                              fontSize: 16,
                              color: (isdark)? Colors.black:Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SelectableText(
                          "${itemm.date.year}-${itemm.date.month}-${itemm.date.day}",
                          textAlign: TextAlign.center,

                          style: (isdark)? TextStyle(
                            fontFamily: 'Pinky',
                            fontSize: 16,
                            color: Color(0xFFF5F0E6),
                          ):TextStyle(
                            fontFamily: 'Pinky',
                            fontSize: 16,
                            color: Color(0xff2b2a28),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            """      Measurements""",
            style: Theme.of(context).textTheme.labelMedium,
            // textAlign: TextAlign.left,
          ),
          Container(
            margin: EdgeInsets.only(right: 20, left: 20, top: 2, bottom: 20),
            padding: EdgeInsets.all(10),
            child: Table(
              border: TableBorder.symmetric(
                inside: BorderSide(color: Color(0xFFe6dbcd), width: 1),
                outside: BorderSide(color: Color(0xff2f2f2f), width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Color(0xffc4a059),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "CM",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: (isdark)? Colors.black:Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Measurements",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: (isdark)? Colors.black:Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                ...List.generate(data.length, (i) {
                  var entry = data.entries.elementAt(i);
                  String key = entry.key;
                  String value = entry.value.toString();



                  return TableRow(
                    decoration: BoxDecoration(
                      color: (isdark)?  i.isEven ? Colors.black  : Color(0xFF464646) : i.isEven ? Color(0xffffffff) : Color(0xfffdfbf6),
                      borderRadius: i != 15
                          ? null
                          : BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                    ),
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SelectableText(
                            key,
                            style: (isdark)? TextStyle(
                            fontFamily: 'Pinky',
                            fontSize: 16,
                            color: Color(0xFFF5F0E6),
                          ):TextStyle(
                            fontFamily: 'Pinky',
                            fontSize: 16,
                            color: Color(0xff2b2a28),
                          ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SelectableText(
                            value,
                            style: (isdark)? TextStyle(
                            fontFamily: 'Pinky',
                            fontSize: 16,
                            color: Color(0xFFF5F0E6),
                          ):TextStyle(
                            fontFamily: 'Pinky',
                            fontSize: 16,
                            color: Color(0xff2b2a28),
                          ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          // if (itemm.note != null)
          //   Text(
          //     "      Note ${(itemm.img != null) ? "/ Image" : ''}",
          //     style: Theme.of(context).textTheme.labelMedium,
          //   ),
          if (itemm.note!.isNotEmpty)
            Container(
              margin: EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 20),
              padding: EdgeInsets.all(10),
              child: Table(
                border: TableBorder.symmetric(
                  inside: BorderSide(color: Color(0xFFe6dbcd), width: 1),
                  outside: BorderSide(color: Color(0xff2f2f2f), width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Color(0xffc4a059),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                    ),
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Notes",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: (isdark)? Colors.black:Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    decoration: BoxDecoration(
                      color:(isdark)? Colors.black: Color(0xfffdfbf6),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(12),
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          itemm.note.toString(),
                          style: TextStyle(
                            fontFamily: 'Pinky',
                            fontSize: 16,
                            color: (isdark)? Colors.white: Color(0xff2b2a28),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          if (itemm.img != null)
            Container(
              margin: EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 20),
              padding: EdgeInsets.all(10),
              child: Table(
                border: TableBorder.symmetric(
                  inside: BorderSide(color: Color(0xFFe6dbcd), width: 1),
                  outside: BorderSide(color: Color(0xff2f2f2f), width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Color(0xffc4a059),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                    ),
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Image",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: (isdark)? Colors.black:Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    decoration: BoxDecoration(
                      color:(isdark)? Colors.black: Color(0xfffdfbf6),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(12),
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(File(itemm.img!.path)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
