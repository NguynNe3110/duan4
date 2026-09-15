import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app.dart';
import 'bloc/search.dart';

@RoutePage()
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends BasePageState<SearchPage, SearchBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const SearchPageInitiated());
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Tìm kiếm sản phẩm...',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (val) => bloc.add(SearchKeywordChanged(keyword: val)),
                ),
              ),
              if (state.isShimmerLoading)
                const CircularProgressIndicator(),
              Expanded(
                child: ListView.builder(
                  itemCount: state.searchResults.length,
                  itemBuilder: (context, index) {
                    final product = state.searchResults[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text('Giá: ${product.effectivePrice}'),
                      onTap: () => bloc.add(SearchProductClicked(productId: product.id)),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
