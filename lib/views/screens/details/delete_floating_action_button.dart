part of'detail_screen_imports.dart';
class DeleteFloatingActionButton extends StatelessWidget {
  final UnitsModel unit;

  ///Delete button if clicked will delete the unit
  /// if and only if the current user who upload it
   DeleteFloatingActionButton(this.unit,);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        Icons.delete,
        size: 28,
      ),
      heroTag: 'remove',
      tooltip: 'remove',
      onPressed: () {
        context.read<ProductsBloc>().add(DeleteProduct(unit,UnitType.ResellUnit));
        CustomDialog.showAlertDialog(
          context,
          '',
          content: FittedBox(
            fit: BoxFit.scaleDown,
            child: Container(
              child: BlocBuilder<ProductsBloc, ProductsState>(

                // ignore: missing_return
                builder: (context, state) {

                  if (state is ProductsLoadingState)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  else if (state is ProductDeleted) {
                    return Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.cloud_done_rounded,
                            color: Colors.green,
                            size: 55,
                          ),
                          CustomText(text: "Done", textColor: Colors.green)
                        ],
                      ),
                    );
                  } else if (state is ErrorState) {
                    return Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 40,
                          ),
                          Text("Error occur")
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          actions: [
            TextButton(
              child: CustomText(
                text: 'okay',
                textColor: Colors.deepPurpleAccent,
              ),
              onPressed: () {
                context.read<ProductsBloc>().add(LoadResellUnits());
                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
