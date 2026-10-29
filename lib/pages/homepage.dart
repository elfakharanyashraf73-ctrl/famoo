
import 'package:famoo/main.dart';
import 'package:famoo/pages/showpage.dart';
import 'package:famoo/widegts/cho.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int index = 0;
  String query = '';
  // double scrol = 0;
  // ScrollController _scrollController = ScrollController();
  FocusNode searchFocus = FocusNode();
  void u() => searchFocus.unfocus();

  List get itemsToShow {
    final q = query.toLowerCase();

    if (q.isEmpty) {
      return clothesItems;
    }

    return clothesItems.where((item) {
      return item.id.toString().contains(q) ||
          item.name.toLowerCase().contains(q) ||
          item.type.toLowerCase().contains(q) ||
          item.fonenumber.toLowerCase().contains(q);
    }).toList();
  }

  String getRemainingDays(DateTime targetDate) {
    final now = DateTime.now();

    final cleanNow = DateTime(now.year, now.month, now.day);
    final cleanTarget = DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
    );

    final difference = cleanTarget.difference(cleanNow).inDays;
    
    if (difference == 0) {
      return 'today';
    } else if (difference < 0) {
      return 'is done';
    } else {
      return '$difference day left';
    }
  }

  @override
  void initState() {
    super.initState();
    sortItems(clothesItems);
    // if (_scrollController.hasClients) {
    //   scrol = _scrollController.initialScrollOffset;
    // }

    setState(() {});
  }

  @override
  void dispose() {
    // if (_scrollController.hasClients) {
    //   scrol = _scrollController.offset;
    // }
    // print(scrol);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isdark = Provider.of<ThemeProvider>(context).isdark;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(backgroundColor: !isdark ? Color(0xffffffff):Color(0xff0e0e0e), child: Cho());
            },
          );
        },
        child: Icon(Icons.add),
      ),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Aya Size Chart',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          sortItems(clothesItems);
          setState(() {});
        },
        child: ListView(
          // controller: _scrollController,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: TextField(
                focusNode: searchFocus,
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },
                decoration: InputDecoration(
                  fillColor: (!isdark)? Color(0xffffffff):Color(0xff0a0a0a),
                  filled: true,
                  hintText: 'Search',
                  prefixIconColor: Color(0xFFC5A059),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      // loading=loading.not;
                      if (searchFocus.hasFocus) {
                        searchFocus.unfocus();
                      } else {
                        searchFocus.requestFocus();
                      }
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFC5A059)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFC5A059)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            if (settings['addlogo'] == true)
              ImageIcon(
                AssetImage("assets/images/aya.png"),
                size: 200,
                color: Color(0xFFC5A059),
              ),
            Container(
              alignment: Alignment.center,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: (!isdark)? Color(0xffffffff):Color(0xff0a0a0a),
                border: Border.all(color: Color(0xFFb8a597)),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x1AC5A059),
                    offset: Offset(7, 10),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                "Total Cards: ${itemsToShow.length}",
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(thickness: 1.3),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: itemsToShow.length,
              itemBuilder: (context, index) {
                final Item item = itemsToShow[index];

                final String deadtime = getRemainingDays(item.date);

                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Showpage(item: item),
                      ),
                    );
                  },
                  child: Container(
                    height: 120,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: (!isdark)? Color(0xffffffff):Color(0xff0a0a0a),
                      border: Border.all(color: const Color(0xFFE8D5B7)),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1AC5A059),
                          offset: Offset(7, 10),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${item.name} Card",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),

                                if (item.isfav)
                                  Icon(Icons.star, color: Colors.yellow[700]),
                              ],
                            ),

                            const SizedBox(height: 8),

                            Text(
                              item.type,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),

                            const SizedBox(height: 5),

                            Text(
                              item.id,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),

                        const Spacer(),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFB8933F),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                deadtime,
                                style: const TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            Text(
                              "${item.date.year}-${item.date.month}-${item.date.day}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
