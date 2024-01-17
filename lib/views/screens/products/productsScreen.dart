part of 'products_imports.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        elevation: 7,
        shadowColor: Colors.blue.shade600,
        title: "Units",
        textColor: Colors.blue.shade900,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
        if (state is ProductsLoadingState)
          return Center(
              child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation(Colors.blue.shade700),
          ));
        else if (state is ProductsLoaded) {
          {
            state.productList.sort(
              (a, b) => b.rate.compareTo(a.rate),
            );

            return ProductsListBody(state.productList);
          }
        } else {
          if (state is ErrorState) print(state.error.toString());

          return Center(
            child: Text('Error occurred'),
          );
        }
      }),
    );
  }
}
