part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required List<Product>?  allProducts,
  }) = _Initial;

  factory HomeState.initial(){
   return const HomeState(allProducts: null);
  }
}
