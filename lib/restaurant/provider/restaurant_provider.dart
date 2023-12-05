import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//캐시로 관리해주는것들은 다 노티파이어 프로바이더를 쓸거임
final restaurantProvider =
//레스토랑 스테이트노피아이어를 반환해줌
    StateNotifierProvider<RestaurantStateNotifier, List<RestaurantModel>>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);

    //레스토랑 레파지토리
    final notifier = RestaurantStateNotifier(repository: repository);

    return notifier;
  },
);

class RestaurantStateNotifier extends StateNotifier<List<RestaurantModel>> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository,
  }) : super([]) {
    //바디안에 넣어주면 레스토랑 스테이트 노티파이어가 실행이될 떄 바로 페이지네이트가 실행됨
    paginate();
  }

  paginate() async {
    final resp = await repository.paginate();
//리스트로 된 레스토랑 모델을 스테이트에 저장할 수 있게 됨
    state = resp.data;
  }
}
