import 'package:famoo/main.dart';
import 'package:famoo/pages/addpage.dart';
// import 'package:tamoo/main.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.img, required this.type});
  final String img;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 75,
      width: 75,
      decoration: BoxDecoration(
        color: Color(0xFFF5E6C8),
        border: Border.all(color: Color(0xFFC5A059)),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            spreadRadius: 5,
            // offset: Offset(10, 10),
            blurRadius: 10,
            color: (!settings['darkMode'])?Color(0x50C5A059) :Color(0x1AC5A059),
                   
               
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addpage(type: type)),
          );
        },
        child: ImageIcon(
          AssetImage(img),
          size: 20,
          color: Color(0xFF141414),
        ),
      ),
    );
  }
}

class Cho extends StatefulWidget {
  const Cho({super.key});

  @override
  State<Cho> createState() => _ChoState();
}

class _ChoState extends State<Cho> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 20),
              Text(
                "Choose an item",
                style: Theme.of(context).textTheme.labelLarge,
              ),

              IconButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                icon: Icon(Icons.close),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Button(img: "assets/images/dress.png", type: "dress"),
              Button(img: "assets/images/coat.png", type: "jacket"),
              Button(img: "assets/images/pants.png", type: "pants"),
            ],
          ),
        ],
      ),
    );
  }
}
