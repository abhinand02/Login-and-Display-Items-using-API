import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../Model/Products.dart';
import '../../Services/products_service.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<GetProducts>((event, emit)async {
     final data= await ProductServices.getProduct();
      emit(HomeState(allProducts:data));
    });
  }
}
