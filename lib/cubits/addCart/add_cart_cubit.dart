import 'package:bloc/bloc.dart';
import 'package:task1/constants/models/models.dart';
part 'add_cart_state.dart';

class AddCartCubit extends Cubit<AddCartState> {
  AddCartCubit() : super(AddCartInitial());
  int counter = 0;
  int pro = 0;
  List<Models> products = [];

  addCart(Models models) {
    products.add(models);
    counter++;
    emit(AddCartSuccess());
  }

  incrementProduct() {
    pro++;
    emit(IncrementCartSuccess());
  }

  decrementProduct() {
    pro--;
    emit(DecrementCartSuccess());
  }
}
