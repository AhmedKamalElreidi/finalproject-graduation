part of 'detail_screen_imports.dart';

class UnitsDetailsBody extends StatelessWidget {
  final UnitsModel unit;

  UnitsDetailsBody(
    this.unit,
  );
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (_, deviceInfo) => Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(20),
        child: Column(children: [
          Visibility(
            visible: unit.location.lat != null && unit.location.long != null,
            child: ListTile(
              enabled: true,
              contentPadding: EdgeInsets.zero,
              trailing: IconShadowWidget(Icon(
                Icons.near_me_rounded,
                color: Colors.blue.shade700,
                size: 28,
              )),
              title: Text(
                'Show in Google Maps',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue.shade900,
                    shadows: [
                      Shadow(color: Colors.blue.shade700, blurRadius: 5)
                    ]),
              ),
              selected: true,
              onTap: () => UrlsCubit.launchMaps(double.parse(unit.location.lat),
                  double.parse(unit.location.long)),
            ),
          ),
          Divider(
            thickness: .3,
            color: Colors.grey,
          ),
          customTile("Amenities", unit.amenities.join(', ') ?? 'not avail'),
          customTile('Bedrooms', unit.bedRooms.toString()),
          customTile('Bathrooms', unit.bathRooms.toString()),
          customTile('Area', unit.area),
          customTile('Furnished', unit.furnishes ? 'Yes' : 'No'),
          customTile('Level', unit.level.toString()),
          customTile('Type', unit.type),
          Visibility(
              visible: unit.compoundName != null &&
                  unit.compoundName.toLowerCase() != 'none',
              child: customTile('Compound', unit.compoundName)),
          customTile('Description', unit.description??'not avail'),

          Card(child: SupplierCard(unit: unit, deviceInfo: deviceInfo))
        ]),
      ),
    );
  }

  Widget customTile(String title, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: CustomText(
                text: title,

                fontSize: 18,
                textColor: Colors.black54,
              ),
            ),
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.centerRight,
                child: CustomText(
                  text: value ?? 'not avail',
                  fontSize: 16,
                  textAlign: TextAlign.right,
                  textColor: Colors.black,
                  maxLines: 9,
                ),
              ),
            ),
          ],
        ),
        Divider(
          thickness: .3,
          color: Colors.grey,
        )
      ],
    );
  }
}
