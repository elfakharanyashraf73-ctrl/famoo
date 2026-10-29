import 'package:famoo/main.dart';


Widget get dash => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 13),
  child: Divider(thickness: 1),
);

class Setpage extends StatefulWidget {
  const Setpage({super.key});

  @override
  State<Setpage> createState() => _SetpageState();
}

class _SetpageState extends State<Setpage> {
  @override
  Widget build(BuildContext context) {
    final isdark = Provider.of<ThemeProvider>(context).isdark;
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "   Theme",
              style: Theme.of(context).textTheme.labelMedium,
              // textAlign: TextAlign.left,
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: (!isdark)? Color(0xffffffff):Color(0xff0a0a0a),
              ),

              child: Column(
                children: [
                  SwitchListTile(
                    title: Text("Dark Mode"),
                    value: settings['darkMode'],
                    onChanged: (value) async {
                      Provider.of<ThemeProvider>(context,listen: false ).toggleTheme();
                      setState(() {
                        settings['darkMode'] = value;
                      });
                      await LocalStorageService.instance.saveSettings(settings);
                    },
                  ),
                  dash,
                  SwitchListTile(
                    title: Text("Add Logo"),
                    value: settings['addlogo'],
                    onChanged: (value) async {
                      setState(() {
                        settings['addlogo'] = value;
                      });
                      await LocalStorageService.instance.saveSettings(settings);
                    },
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "   Data Cntroler",
                  style: Theme.of(context).textTheme.labelMedium,
                  // textAlign: TextAlign.left,
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 10),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: (!isdark)? Color(0xffffffff):Color(0xff0a0a0a),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Show data',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: SizedBox(
                                  width: 500,
                                  height: 500,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Text(
                                          'Data',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.labelLarge,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),

                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(13),
                                          child: ListView(
                                            children: [
                                              Text(
                                                'Items:',
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.labelMedium,
                                              ),
                                              const SizedBox(height: 10),
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: clothesItems.length,
                                                itemBuilder: (BuildContext context, i) {
                                                  Item item = clothesItems[i];
                                                  String date =
                                                      "${item.date.year}-${item.date.month}-${item.date.day}";
                                                  return Column(
                                                    children: [
                                                      SelectableText(
                                                        '''{name:${item.name},
                                                        type:${item.type},
                                                        date:$date,
                                                        phone number:${item.fonenumber},
                                                        id:${item.id},
                                                        isfav:${item.isfav},
                                                        note:${item.note},
                                                        image:${item.img?.path ?? 'null'}}
                                                        ''',
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 20,
                                                            ),
                                                        child: Divider(
                                                          thickness: 1.7,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                              const SizedBox(height: 20),
                                              Text(
                                                'Settings:',
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.labelMedium,
                                              ),
                                              const SizedBox(height: 10),
                                              Text('$settings'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      dash,
                      ListTile(
                        title: Text('Download Items data'),
                        onTap: () {
                          List list = [];
                          for (int i = 0; i < clothesItems.length; i++) {
                            Item item = clothesItems[i];
                            Map map = item.clothesItem.toMap();
                            String date =
                                "${item.date.year}-${item.date.month}-${item.date.day}";
                            list.add({
                              'name': item.name,
                              'type': item.type,
                              'date': date,
                              'phone number': item.fonenumber,
                              'id': item.id,
                              'isfav': item.isfav,
                              'note': item.note,
                              'image': item.img?.path ?? 'null',
                              'Measurements': map,
                            });
                          }
                          // Map<int,dynamic> map = {
                          //   for (int i = 0; i < list.length; i++)
                          //     i + 1: list[i],
                          // };
                          savefile(list);
                        },
                      ),
                      dash,
                      ListTile(
                        title: Text(
                          "Rest ID numbers",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.5,
                          ),
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
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Close'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      setState(() {
                                        resetIds(clothesItems);
                                      });
                                      await LocalStorageService.instance
                                          .saveItems(
                                            clothesItems,
                                            (item) => item.toMap(),
                                          );
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Rest',
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Op extends StatelessWidget {
  const Op({
    super.key,
    required this.onTap,
    required this.title,
    this.subtitle,
  });
  final GestureTapCallback onTap;
  final Widget title;
  final Widget? subtitle;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: AlignmentGeometry.centerStart,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 17),
        height: 45,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            SizedBox(height: 1),
            ?(subtitle == null) ? null : subtitle,
          ],
        ),
      ),
    );
  }
}
