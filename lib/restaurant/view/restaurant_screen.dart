import 'package:actual/common/const/data.dart';
import 'package:actual/common/dio/dio.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/repository/restaurant_repository.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);
//레스토랑 모델이 티임
  Future<List<RestaurantModel>> paginateRestaurant() async {
    final dio = Dio();

    dio.interceptors.add(
      CustomInterceptor(storage: storage),
    );

    dio.interceptors.add(CustomInterceptor(storage: storage));

    //커서페이지 네이션에 있는 데이터
    final resp =
        await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant')
            .paginate();

    //리스트로 가져온 데이터
    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FutureBuilder<List<RestaurantModel>>(
              future: paginateRestaurant(),
              builder:
                  (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) {
                    final pItem = snapshot.data![index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => RestaurantDetailScreen(
                                    id: pItem.id,
                                  )),
                        );
                      },
                      child: RestaurantCard(
                        image: Image.network(
                          pItem.thumbUrl,
                          fit: BoxFit.cover,
                        ),
                        // image: Image.asset(
                        //   'asset/img/food/ddeok_bok_gi.jpg',
                        //   fit: BoxFit.cover,
                        // ),
                        name: pItem.name,
                        tags: pItem.tags,
                        ratingsCount: pItem.ratingsCount,
                        deliveryTime: pItem.deliveryTime,
                        deliveryFee: pItem.deliveryFee,
                        ratings: pItem.ratings,
                      ),
                    );
                  },
                  separatorBuilder: (_, index) {
                    return SizedBox(height: 16.0);
                  },
                );
              },
            )),
      ),
    );
  }
}
