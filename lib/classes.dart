import 'dart:convert';
import 'dart:typed_data';

import 'package:famoo/Main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

void resetIds(List<Item> items) {
  int idnum = settings['choid'];

  for (int i = 0; i < items.length; i++) {
    idnum = i;

    items[i].id = "C#${idnum.toString().padLeft(5, '0')}";
  }
}

abstract class ClotheType {
  Map<String, dynamic> toMap();

  // static ClotheType fromMap(map);
}

class Dress extends ClotheType {
  Dress({
    required this.bustCirc,
    required this.waistCirc,
    required this.hipCirc,
    required this.frontLength,
    required this.backLength,
    required this.bustHeight,
    required this.bustDistance,
    required this.hipHeight,
    required this.shoulderWidth,
    required this.backWidth,
    required this.sleevesLength,
    required this.wristCirc,
    required this.muscleCirc,
    required this.kneeLength,
    required this.dressLength,
    required this.height,
  });

  double bustCirc;
  double waistCirc;
  double hipCirc;
  double frontLength;
  double backLength;
  double bustHeight;
  double bustDistance;
  double hipHeight;
  double shoulderWidth;
  double backWidth;
  double sleevesLength;
  double wristCirc;
  double muscleCirc;
  double kneeLength;
  double dressLength;
  double height;

  @override
  Map<String, dynamic> toMap() => {
    "Bust circ": bustCirc,
    "Waist circ": waistCirc,
    "Hip circ": hipCirc,
    "Front length": frontLength,
    "Back length": backLength,
    "Bust height": bustHeight,
    "Bust distance": bustDistance,
    "Hip height": hipHeight,
    "Shoulder width": shoulderWidth,
    "Back width": backWidth,
    "Sleeves length": sleevesLength,
    "Wrist circ": wristCirc,
    "Muscle circ": muscleCirc,
    "Knee length": kneeLength,
    "Dress length": dressLength,
    "Height": height,
  };

  static Dress fromMap(Map<String, dynamic> map) => Dress(
    bustCirc: map['Bust circ'],
    waistCirc: map['Waist circ'],
    hipCirc: map['Hip circ'],
    frontLength: map['Front length'],
    backLength: map['Back length'],
    bustHeight: map['Bust height'],
    bustDistance: map['Bust distance'],
    hipHeight: map['Hip height'],
    shoulderWidth: map['Shoulder width'],
    backWidth: map['Back width'],
    sleevesLength: map['Sleeves length'],
    wristCirc: map['Wrist circ'],
    muscleCirc: map['Muscle circ'],
    kneeLength: map['Knee length'],
    dressLength: map['Dress length'],
    height: map['Height'],
  );
}

class Jacket extends ClotheType {
  Jacket({
    required this.bustCirc,
    required this.waistCirc,
    required this.hipCirc,
    required this.frontLength,
    required this.backLength,
    required this.bustHeight,
    required this.bustDistance,
    required this.hipHeight,
    required this.shoulderWidth,
    required this.backWidth,
    required this.sleevesLength,
    required this.wristCirc,
    required this.muscleCirc,
    required this.jacketLength,
    required this.height,
  });

  double bustCirc;
  double waistCirc;
  double hipCirc;
  double frontLength;
  double backLength;
  double bustHeight;
  double bustDistance;
  double hipHeight;
  double shoulderWidth;
  double backWidth;
  double sleevesLength;
  double wristCirc;
  double muscleCirc;
  double jacketLength;
  double height;

  @override
  Map<String, dynamic> toMap() => {
    "Bust circ": bustCirc,
    "Waist circ": waistCirc,
    "Hip circ": hipCirc,
    "Front length": frontLength,
    "Back length": backLength,
    "Bust height": bustHeight,
    "Bust distance": bustDistance,
    "Hip height": hipHeight,
    "Shoulder width": shoulderWidth,
    "Back width": backWidth,
    "Sleeves length": sleevesLength,
    "Wrist circ": wristCirc,
    "Muscle circ": muscleCirc,
    "Jacket length": jacketLength,
    "Height": height,
  };

  static Jacket fromMap(Map<String, dynamic> map) => Jacket(
    bustCirc: map['Bust circ'],
    waistCirc: map['Waist circ'],
    hipCirc: map['Hip circ'],
    frontLength: map['Front length'],
    backLength: map['Back length'],
    bustHeight: map['Bust height'],
    bustDistance: map['Bust distance'],
    hipHeight: map['Hip height'],
    shoulderWidth: map['Shoulder width'],
    backWidth: map['Back width'],
    sleevesLength: map['Sleeves length'],
    wristCirc: map['Wrist circ'],
    muscleCirc: map['Muscle circ'],
    jacketLength: map['Jacket length'],
    height: map['Height'],
  );
}

class Pants extends ClotheType {
  Pants({
    required this.waistCirc,
    required this.hipCirc,
    required this.hipHeight,
    required this.crotchHeight,
    required this.kneeLength,
    required this.pantsLength,
    required this.height,
  });

  double waistCirc;
  double hipCirc;
  double hipHeight;
  double crotchHeight;
  double kneeLength;
  double pantsLength;
  double height;

  @override
  Map<String, dynamic> toMap() => {
    "Waist circ": waistCirc,
    "Hip circ": hipCirc,
    "Hip height": hipHeight,
    "Crotch height": crotchHeight,
    "Knee length": kneeLength,
    "Pants length": pantsLength,
    "Height": height,
  };

  static Pants fromMap(Map<String, dynamic> map) => Pants(
    waistCirc: map['Waist circ'],
    hipCirc: map['Hip circ'],
    hipHeight: map['Hip height'],
    crotchHeight: map['Crotch height'],
    kneeLength: map['Knee length'],
    pantsLength: map['Pants length'],
    height: map['Height'],
  );
}

class Item {
  Item({
    required this.name,
    required this.date,
    required this.note,
    required this.type,
    required this.isfav,
    required this.fonenumber,
    required this.clothesItem,
    required this.img,
    required this.id,
  });

  String? note;
  String name;
  DateTime date;
  String type;
  bool isfav;
  XFile? img;
  String fonenumber;
  String id
  // = "C#$getid"
  ;
  ClotheType clothesItem;
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'note': note,
      'date': date.toIso8601String(), // التاريخ لازم يتحول String
      'type': type,
      'isfav': isfav,
      'fonenumber': fonenumber,
      'clothesitem': clothesItem.toMap(),
      'img': (img != null) ? img!.path : null,
    };
  }

  // -------- fromMap: من الـ Map للـ Object تاني (وقت التحميل) --------
  factory Item.fromMap(Map<String, dynamic> map) {
    late ClotheType isa;

    switch (map['type']) {
      case 'dress':
        isa = Dress.fromMap(Map<String, dynamic>.from(map['clothesitem']));
        break;

      case 'jacket':
        isa = Jacket.fromMap(Map<String, dynamic>.from(map['clothesitem']));
        break;

      case 'pants':
        isa = Pants.fromMap(Map<String, dynamic>.from(map['clothesitem']));
        break;

      default:
        throw Exception('Unknown clothes type: ${map['type']}');
    }
    return Item(
      id: map['id'],
      name: map['name'] as String,
      date: DateTime.parse(map['date'] as String),
      note: map['note'],
      type: map['type'],
      isfav: map['isfav'],
      fonenumber: map['fonenumber'],
      clothesItem: isa,
      img: (map['img'] != null) ? XFile(map['img']) : null,
    );
  }
}

void sortItems(List<Item> items) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  items.sort((a, b) {
    // دالة لتحديد الأولوية بناءً على فرق الأيام فقط
    int getPriority(DateTime date) {
      final normalizedDate = DateTime(date.year, date.month, date.day);

      final differenceDays = normalizedDate.difference(today).inDays;

      // 3. لو التاريخ فات (أقدم من اليوم) -> يروح في الآخر خالص
      if (differenceDays < 0) {
        return 3;
      }
      // 1. لو النهارده أو خلال أيام قريبة (لحد 5 أيام مثلاً) -> في الأول
      else if (differenceDays <= 5) {
        return 1;
      }
      // 2. لو تاريخ بعيد (أكتر من 5 أيام، زي 9 أيام وطالع) -> في النص
      else {
        return 2;
      }
    }

    int priorityA = getPriority(a.date);
    int priorityB = getPriority(b.date);

    // لو الأولويات مختلفة، نرتب حسب الوزن (1 ثم 2 ثم 3)
    if (priorityA != priorityB) {
      return priorityA.compareTo(priorityB);
    }

    // لو الاتنين نفس الأولوية، نرتبهم حسب التاريخ الأقرب فالأبعد
    return a.date.compareTo(b.date);
  });
}

Future<void> savefile(List map) async {
  String json =jsonEncode(map);
  Uint8List bytes = utf8.encode(json);
  FilePicker.saveFile(
    dialogTitle: 'Save JSON',
    fileName: 'items-data.json',
    type: FileType.custom,
    allowedExtensions: ['pdf'],
    bytes: bytes,
  );
}



