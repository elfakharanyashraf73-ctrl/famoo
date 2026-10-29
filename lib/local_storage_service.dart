
import 'package:hive_flutter/hive_flutter.dart';

// class LocalStorage {
//   Box settingbox = Hive.box('settings');
//   Box itemsbox = Hive.box('items');
//   Future<void> saveitems() async {

//     await itemsbox.put('itemslist', clothesItems);
//   }

//   Future<void> savesetings() async {
//     await settingbox.put('settingsmap', settings);
//   }

//   Future<void> loaditems() async {
  
//     clothesItems = itemsbox.get('itemslist') ?? [];


//   }

//   Future<void> loadsetings() async {
//     settings =
//         settingbox.get('settingsmap') ??
//         {'darkMode': false, 'addlogo': true, 'choid': 0};
//   }
// }

/// سيرفس عام للحفظ والتحميل - مش بيفرض شكل معين لكلاساتك.
/// استخدمه Singleton: LocalStorageService.instance
class LocalStorageService {
  LocalStorageService._internal();
  static final LocalStorageService instance = LocalStorageService._internal();

  static const String _settingsBoxName = 'settingsBox';
  static const String _itemsBoxName = 'itemsBox';
  static const String _settingsKey = 'settingsMap';
  static const String _itemsKey = 'itemsList';

  late Box _settingsBox;
  late Box _itemsBox;

  /// ناديها مرة واحدة في main() قبل runApp
  Future<void> init() async {
    await Hive.initFlutter();
    _settingsBox = await Hive.openBox(_settingsBoxName);
    _itemsBox = await Hive.openBox(_itemsBoxName);
  }

  // ---------------- Settings ----------------
  // شكلها زي ما هي عندك في المين: Map<String, dynamic>

  /// نادها وقت الحفظ، ابعتلها الماب بتاعتك زي ما هي
  Future<void> saveSettings(Map<String, dynamic> settings) async {
    await _settingsBox.put(_settingsKey, settings);
    print('setting saved');
  }

  /// بترجع الماب المحفوظة، لو مفيش حاجة بترجع ماب فاضية
  Map<String, dynamic> loadSettings() {
    final raw = _settingsBox.get(_settingsKey);
    if (raw == null) return {'darkMode': false, 'addlogo': true};
    print('setting loaded');
    return Map<String, dynamic>.from(raw as Map);
  }

  // ---------------- Items ----------------
  // شغالة مع أي List<T> عندك، انت بس بتديها إزاي تحول العنصر لـ Map وإزاي ترجعه تاني

  /// نادها وقت الحفظ:
  /// LocalStorageService.instance.saveItems(myItemsList, (item) => item.toMap());
  /// لو الكلاس عندك اسمها toJson استخدمها بدل toMap برضه شغالة
  Future<void> saveItems<T>(
    List<T> items,
    Map<String, dynamic> Function(T item) toMap,
  ) async {
    final listOfMaps = items.map((e) => toMap(e)).toList();
    await _itemsBox.put(_itemsKey, listOfMaps);
        print('Items saved------------------------------------------------------------');
  }

  /// نادها وقت التحميل:
  /// final items = LocalStorageService.instance.loadItems(Item.fromMap);
  List<T> loadItems<T>(T Function(Map<String, dynamic> map) fromMap) {
    final raw = _itemsBox.get(_itemsKey);
    if (raw == null) return [];
    final listOfMaps = List<Map>.from(raw as List);
    print('Items loaded------------------------------------------------------------');
    return listOfMaps
        .map((m) => fromMap(Map<String, dynamic>.from(m)))
        .toList();
  }

  /// اختياري: مسح الايتمز كلها
  Future<void> clearItems() async {
    await _itemsBox.delete(_itemsKey);
  }
}
