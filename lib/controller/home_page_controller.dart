import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemons_riverpod/models/page_data.dart';
import 'package:pokemons_riverpod/models/pokemon.dart';
import 'package:pokemons_riverpod/services/http_service.dart';

class HomepageController extends StateNotifier<HomePageData> {
  final GetIt _getIt = GetIt.instance;

  late HTTPService _httpService;

  HomepageController(super._state) {
    _httpService = _getIt.get<HTTPService>();
    _setup();
  }

  Future<void> _setup() async {
    loadData();
  }

  Future<void> loadData() async {
    if (state.data == null) {
      Response? res = await _httpService.get(
        'https://pokeapi.co/api/v2/pokemon?limit=20&offset=0',
      );
      if (res != null && res.data != null) {
        PokemonListData data = PokemonListData.fromJson(res.data);
        state = state.copyWith(data: data);
      }
      print(res?.data);
    } else {
      print('An error occured');
    }
  }
}
