part of 'resell_products_screen_imports.dart';

class ResellProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xd8f1eeee),
      appBar: MyCustomAppBar(
        title: 'Resell units',
        showLeading: false,
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 5,
        shadowColor: Colors.amber,
      ),
       floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Visibility(
        visible: context.watch<ProductsBloc>().state is! ProductsLoadingState,
        child: Container(
          height: MediaQuery.of(context).size.height*.093,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: CupertinoButton(

            child: CustomText(
              text: 'Add Item',
            ),
            color: Colors.red,
            onPressed: () {
              context.read<ProductsBloc>().add(LoadAllCompounds());
              NavigationServices.navigateTo(AddUnitRoute,
                  arguments: Arguments(addingType: UnitType.ResellUnit));
            },
          ),
        ),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoadingState)
            return Center(child: CircularProgressIndicator.adaptive());
          else if (state is ProductsLoaded)
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: ResellBody(
                resellsUnit: state.productList,
              ),
            );
          else
            return Center(child: Text("Error occurs"));
        },
      ),
    );
  }
}
