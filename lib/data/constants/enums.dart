
enum DetailsNavigationType { Unit, Compound }
///loading type used in products bloc to Discrimination
/// between loading type because the same function load several data
enum LoadingType {
  LoadUnitsByCompoundID,
  LoadResellUnits,
  LoadProductById,
  LoadAllUnits
}
enum UnitType { NormalUnit, ResellUnit }
