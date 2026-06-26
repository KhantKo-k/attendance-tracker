import 'dart:async';

import 'package:app_starter_kit_bloc/core/di/service_locator.dart';
import 'package:app_starter_kit_bloc/core/error/exceptions.dart';
import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/core/error/global_error_handler.dart';
import 'package:app_starter_kit_bloc/core/navigation/app_router.dart';
import 'package:app_starter_kit_bloc/features/localization/presentation/extensions/localization_extension.dart';
import 'package:app_starter_kit_bloc/features/localization/presentation/widgets/language_selector.dart';
import 'package:app_starter_kit_bloc/features/product/presentation/bloc/products_bloc.dart';
import 'package:app_starter_kit_bloc/features/product/presentation/pages/widgets/product_card.dart';
import 'package:app_starter_kit_bloc/features/product/product_routes.dart';
import 'package:app_starter_kit_bloc/shared/theme/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  final _searchSubject = BehaviorSubject<String>();
  late final StreamSubscription _searchSubscription;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    _searchSubscription = _searchSubject
        .debounceTime(const Duration(milliseconds: 800))
        .distinct()
        .listen((query) {
          if (!mounted) return;
          if (query.isEmpty) {
            context.read<ProductsBloc>().add(const ProductsEvent.clearSearch());
          } else {
            context.read<ProductsBloc>().add(
              ProductsEvent.searchProducts(query),
            );
          }
        });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _searchSubject.close();
    _searchSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<ProductsBloc, ProductsState>(
      listenWhen: (previous, current) =>
          previous.failure != current.failure &&
          current.failure != null &&
          current.products.isNotEmpty,
      listener: (context, state) {
        if (state.failure != null) {
          _handleFailure(context, state.failure!);
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) => _buildScrollView(context, theme, state),
        ),
      ),
    );
  }

  Widget _buildScrollView(
    BuildContext context,
    ThemeData theme,
    ProductsState state,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ProductsBloc>().add(const ProductsEvent.refresh());
        return Future.value();
      },
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          _buildAppBar(theme, context.tr('productPage.products')),
          _buildSearchBar(theme, context.tr('productPage.search')),
          _buildBody(state),

          if (state.isLoadingMore)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _buildAppBar(ThemeData theme, String title) {
    return SliverAppBar(
      expandedHeight: 80,
      floating: true,
      pinned: true,
      snap: true,
      backgroundColor: theme.colorScheme.onSecondary,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
          letterSpacing: -0.5,
        ),
      ),
      centerTitle: false,
      actions: [const LanguageSelector()],
    );
  }

  SliverToBoxAdapter _buildSearchBar(ThemeData theme, String hintText) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            prefixIcon: Icon(Icons.search, color: theme.colorScheme.primary),
            suffixIcon: _buildSearchSuffix(theme),
            filled: true,
            fillColor: theme.colorScheme.surfaceContainer,
            border: _buildInputBorder(),
            enabledBorder: _buildInputBorder(color: theme.colorScheme.outline),
            focusedBorder: _buildInputBorder(
              color: theme.colorScheme.primary,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(ProductsState state) {
    if (state.isLoading && state.products.isEmpty) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.failure != null && state.products.isEmpty && !state.isLoading) {
      return SliverFillRemaining(
        child: _ErrorView(
          onRetry: () => context.read<ProductsBloc>().add(
            const ProductsEvent.fetchProducts(),
          ),
        ),
      );
    }

    if (state.products.isEmpty) {
      return const SliverFillRemaining(child: _EmptyView());
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      sliver: SliverList.separated(
        itemCount: state.products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: state.products[index],
            onTap: () => _navigateToDetail(state.products[index].id!),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 12),
      ),
    );
  }

  Widget _buildSearchSuffix(ThemeData theme) {
    return ValueListenableBuilder(
      valueListenable: _searchController,
      builder: (context, value, _) {
        return value.text.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.close, color: theme.colorScheme.onSurface),
                onPressed: () {
                  _searchController.clear();
                  _onSearchChanged("");
                },
              )
            : const SizedBox.shrink();
      },
    );
  }

  OutlineInputBorder _buildInputBorder({Color? color, double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: kBorderRadius,
      borderSide: color == null
          ? BorderSide.none
          : BorderSide(color: color, width: width),
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final bloc = context.read<ProductsBloc>();
    final state = bloc.state;

    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 300 &&
        !state.isLoadingMore &&
        state.hasMore &&
        !state.isLoading) {
      bloc.add(const ProductsEvent.loadMore());
    }
  }

  void _onSearchChanged(String query) {
    _searchSubject.add(query.trim());
  }

  void _handleFailure(BuildContext context, final Failure failure) {
    GlobalErrorHandler().handleError(context, failure);
  }

  void _navigateToDetail(int id) {
    serviceLocator.get<AppRouter>().goToProductDetails(context, id.toString());
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No products found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Could not load products',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
