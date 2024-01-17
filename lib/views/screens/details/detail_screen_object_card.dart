part of 'detail_screen_imports.dart';


class DetailsCard extends StatelessWidget {
  final String title, subTitle, objectName;
  ///details of compound or overview widget
  const DetailsCard({Key key, this.objectName, this.title, this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
      child: Column(
        children: [
          Container(
            // alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 15),
            child: CustomText(
              text: "$objectName",
              // textAlign: TextAlign.justify,
              textAlign: TextAlign.right,

              textStyle: TextStyle(
                  fontSize: 22,
                  height: 1.2,
                  fontFamily: 'poppins',
                  color: Colors.indigo.shade500,
                  wordSpacing: 2,
                  shadows: [
                    Shadow(color: Colors.indigo.shade500, blurRadius: 3)
                  ],
                  fontWeight: FontWeight.bold),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
                height: 32,
                child: text(title, color: Colors.indigo.shade500, size: 22)),
          ),
          text(subTitle)
        ],
      ),
    );
  }

  CustomText text(String title, {Color color, double size}) => CustomText(
        text: title ?? 'not avail',
        textAlign: TextAlign.justify,
        textStyle: TextStyle(
            color: color ?? Colors.black54,
            fontSize: size ?? 18,
            // wordSpacing: 2,
            height: 1.2,
            shadows: [
              Shadow(color: color ?? Colors.blue.shade900, blurRadius: 2)
            ]),
        maxLines: 30,
      );
}
