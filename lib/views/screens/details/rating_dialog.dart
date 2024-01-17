part of 'detail_screen_imports.dart';

void showRatingDialog(BuildContext context,
    {Function okPressed, String compoundID}) {
  showDialog(
      context: context,
      builder: (context) {
        return ResponsiveBuilder(
          builder: (context, deviceInfo) =>
              BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
            if (state is ProductUpdated || state is ErrorState) {
              String message;
              if (state is ProductUpdated) {
                message = 'Rate sent';
              } else if (state is ErrorState) {
                message = 'error, try later';
              }
              return Center(
                child: Container(
                  width: deviceInfo.localWidth * .9,
                  height: deviceInfo.localHeight * .4,
                  child: AlertDialog(
                    title: Center(
                      child: CustomText(
                        text: '',
                        textColor: Colors.black,
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: CustomText(
                          text: 'Okay',
                          textColor: Colors.green.shade400,
                        ),
                        onPressed: okPressed ?? NavigationServices.back,
                      ),
                    ],
                    content: Container(
                        width: deviceInfo.localWidth,
                        height: deviceInfo.localHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              state is ProductUpdated
                                  ? Icons.check_circle
                                  : Icons.error,
                              color: state is ProductUpdated
                                  ? Colors.green
                                  : Colors.red,
                              size: 50,
                            ),
                            CustomText(
                              text: message,
                              textColor: Colors.black,
                            )
                          ],
                        )),
                  ),
                ),
              );
            } else
              return Center(
                  child: Card(
                child: Container(
                  height: deviceInfo.localHeight * .2,
                  width: deviceInfo.localWidth * .7,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                        Color.fromRGBO(
                            Random().nextInt(230) + 20,
                            Random().nextInt(230) + 20,
                            Random().nextInt(230) + 20,
                            .80),
                      )),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text('Loading...'),
                      ),
                    ],
                  ),
                ),
              ));
          }),
        );
      });
}
