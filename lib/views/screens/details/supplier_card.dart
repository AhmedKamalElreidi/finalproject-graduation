part of 'detail_screen_imports.dart';

class SupplierCard extends StatelessWidget {
  final UnitsModel unit;
  final DeviceInfo deviceInfo;

  const SupplierCard({Key key, @required this.unit, @required this.deviceInfo})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    return Container(
      height: size.height/4,
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: CustomText(
            padding: EdgeInsets.all(20),
            text: 'Contact with seller',
            textColor: MaterialData.kPrimaryColor,
            fontWeight: FontWeight.bold,
          )),
          Expanded(
            child: contactTile(context,
                iconData: Icons.mail,
                textColor: Colors.blue,
                text: unit.supplierEmail,
                onTap: () => UrlsCubit.sendAnEmail(
                      context,
                      unit.supplierEmail,
                      unit.title,
                    )),
          ),
          Expanded(
            child: contactTile(
              context,
              iconData: Icons.phone,
              textColor: Colors.blue,
              text: unit.supplierPhone,
              onTap: () => UrlsCubit.makingPhoneCall(context,
                  phoneNumber: unit.supplierPhone),
            ),
          ),
        ],
      ),
    );
  }

  Widget contactTile(BuildContext context,
      {IconData iconData, Color textColor, Function onTap, String text}) {
    return ListTile(
      minLeadingWidth: 0,
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      leading: Icon(
        iconData,
        color: textColor,
      ),
      title: CustomText(
        text: text ?? 'not avail now',
        textColor: textColor,
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
      onTap: () => onTap(),
    );
  }
}
