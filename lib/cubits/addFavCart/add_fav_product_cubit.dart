import 'package:bloc/bloc.dart';
import 'package:task1/constants/models/models.dart';

part 'add_fav_product_state.dart';

class AddFavCartCubit extends Cubit<AddFavCartState> {
  AddFavCartCubit() : super(AddFavCartInitial());

  List<Models> favCart = [];

  addFavCart(Models models) {
    favCart.add(models);
    emit(AddFavCartSuccess());
  }

  void removeProduct(int index) {
    favCart.removeAt(index);
    emit(AddFavCartSuccess());
  }
}
