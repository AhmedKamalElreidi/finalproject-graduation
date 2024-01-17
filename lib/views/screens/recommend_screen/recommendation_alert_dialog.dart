part of 'recommend_imports.dart';

void recommendAlertDialog(
    {BuildContext context,
    DeviceInfo deviceInfo,
    IconData icon,
    Color color,
    String message}) {
  CustomDialog.showAlertDialog(context, "",
      actions: [
        TextButton(
          child: CustomText(
            text: 'Okay',
            textColor: Colors.indigo,
          ),
          onPressed: () {
            NavigationServices.back();
            NavigationServices.back();
          },
        ),
      ],
      content: Container(
        height: deviceInfo.localHeight * .2,
        width: deviceInfo.localWidth * .7,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: 80,
              ),
              CustomText(
                text: message,
                fontSize: 22,
                textColor: color,
              ),
            ],
          ),
        ),
      ));
}
