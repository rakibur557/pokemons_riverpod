import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemons_riverpod/controller/home_page_controller.dart';
import 'package:pokemons_riverpod/models/page_data.dart';

final homePageControllerProvider =
    StateNotifierProvider<HomepageController, HomePageData>((ref) {
  return HomepageController(HomePageData.initial());
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late HomepageController _homepageController;
  late HomePageData _homePageData;

  @override
  Widget build(BuildContext context) {
    _homepageController = ref.watch(homePageControllerProvider.notifier);
    _homePageData = ref.watch(homePageControllerProvider);
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _allPokemonsList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _allPokemonsList(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'All Pokemons',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.60,
            child: ListView.builder(
              itemCount: _homePageData.data?.results?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(index.toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
