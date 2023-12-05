import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/restaurant/model/restaurant_detail_model.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers; // dio 라이브러리의 Headers를 사용하겠다고 명시
import 'package:retrofit/retrofit.dart'; // retrofit 라이브러리의 Headers를 사용하겠다고 명시
part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  // http://$ip/restaurant
  //외부에서 생성해서 디오를 넣어줄거임,공통되는 부분은 베이스유알엘로
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // http://$ip/restaurant/
  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  //제네릭에 어떤 타입을 적냐에 따라
  Future<CursorPagination<RestaurantModel>> paginate();

//어떤 모델로 맵핑이 되는지만 보면됨,
  //함수는 저게 만들어줌 , 실제로 응답을 받는 형태와 완전히 똑같은 형태의 클래스를 반환값으로 넣어줘야됨
  //그러면 자동으로 제이슨값이 맵핑이 돼가지고 클래스의인스턴스가 됨
  // http://$ip/restaurant/:id
  @GET('/{id}')
  @Headers({
    'accessToken': 'true',
  })

  //외부에서오는 요청이니까 퓨처는 꼭 있어야됨
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
