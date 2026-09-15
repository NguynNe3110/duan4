// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:domain/domain.dart' as _i494;
import 'package:domain/src/usecase/clear_current_user_data_use_case.dart'
    as _i266;
import 'package:domain/src/usecase/fake_login_use_case.dart' as _i245;
import 'package:domain/src/usecase/fashion_usecase/address/create_address_use_case.dart'
    as _i429;
import 'package:domain/src/usecase/fashion_usecase/address/delete_address_use_case.dart'
    as _i647;
import 'package:domain/src/usecase/fashion_usecase/address/get_addresses_use_case.dart'
    as _i578;
import 'package:domain/src/usecase/fashion_usecase/address/update_address_use_case.dart'
    as _i156;
import 'package:domain/src/usecase/fashion_usecase/cart_item/add_to_cart_use_case.dart'
    as _i466;
import 'package:domain/src/usecase/fashion_usecase/cart_item/delete_cart_item_use_case.dart'
    as _i829;
import 'package:domain/src/usecase/fashion_usecase/cart_item/get_cart_items_use_case.dart'
    as _i49;
import 'package:domain/src/usecase/fashion_usecase/cart_item/update_cart_item_quantity_use_case.dart'
    as _i11;
import 'package:domain/src/usecase/fashion_usecase/category/get_categories_use_case.dart'
    as _i896;
import 'package:domain/src/usecase/fashion_usecase/category/get_category_by_id_use_case.dart'
    as _i151;
import 'package:domain/src/usecase/fashion_usecase/checkout/checkout_selected_items_use_case.dart'
    as _i11;
import 'package:domain/src/usecase/fashion_usecase/favorite/get_favorites_use_case.dart'
    as _i200;
import 'package:domain/src/usecase/fashion_usecase/favorite/toggle_favorite_use_case.dart'
    as _i523;
import 'package:domain/src/usecase/fashion_usecase/order/get_order_by_id_use_case.dart'
    as _i479;
import 'package:domain/src/usecase/fashion_usecase/order/get_order_history_use_case.dart'
    as _i1027;
import 'package:domain/src/usecase/fashion_usecase/order/get_orders_use_case.dart'
    as _i155;
import 'package:domain/src/usecase/fashion_usecase/order_item/get_order_items_use_case.dart'
    as _i150;
import 'package:domain/src/usecase/fashion_usecase/product/get_featured_products_usecase.dart'
    as _i756;
import 'package:domain/src/usecase/fashion_usecase/product/get_product_by_id_usecase.dart'
    as _i747;
import 'package:domain/src/usecase/fashion_usecase/product/get_products_by_category_usecase.dart'
    as _i224;
import 'package:domain/src/usecase/fashion_usecase/product/get_products_usecase.dart'
    as _i961;
import 'package:domain/src/usecase/fashion_usecase/product_image/get_product_images_use_case.dart'
    as _i120;
import 'package:domain/src/usecase/fashion_usecase/profile/get_me_use_case.dart'
    as _i249;
import 'package:domain/src/usecase/fashion_usecase/profile/get_profile_use_case.dart'
    as _i529;
import 'package:domain/src/usecase/fashion_usecase/profile/update_profile_use_case.dart'
    as _i329;
import 'package:domain/src/usecase/fashion_usecase/review/create_review_use_case.dart'
    as _i1051;
import 'package:domain/src/usecase/fashion_usecase/review/delete_review_use_case.dart'
    as _i757;
import 'package:domain/src/usecase/fashion_usecase/review/get_reviews_use_case.dart'
    as _i655;
import 'package:domain/src/usecase/fashion_usecase/search/add_search_history_use_case.dart'
    as _i715;
import 'package:domain/src/usecase/forgot_password_use_case.dart' as _i785;
import 'package:domain/src/usecase/get_initial_app_data_use_case.dart' as _i428;
import 'package:domain/src/usecase/get_initial_home_data_use_case.dart'
    as _i160;
import 'package:domain/src/usecase/get_users_use_case.dart' as _i1037;
import 'package:domain/src/usecase/is_logged_in_use_case.dart' as _i8;
import 'package:domain/src/usecase/load_initial_resource_use_case.dart'
    as _i482;
import 'package:domain/src/usecase/load_more_users_use_case.dart' as _i905;
import 'package:domain/src/usecase/login_use_case.dart' as _i847;
import 'package:domain/src/usecase/logout_use_case.dart' as _i839;
import 'package:domain/src/usecase/register_account_use_case.dart' as _i266;
import 'package:domain/src/usecase/reset_password_use_case.dart' as _i528;
import 'package:domain/src/usecase/save_is_dark_mode_use_case.dart' as _i301;
import 'package:domain/src/usecase/save_is_first_launch_app_use_case.dart'
    as _i319;
import 'package:domain/src/usecase/save_language_code_use_case.dart' as _i95;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i1027.GetOrderHistoryUseCase>(
      () => _i1027.GetOrderHistoryUseCase(),
    );
    gh.factory<_i715.AddSearchHistoryUseCase>(
      () => _i715.AddSearchHistoryUseCase(),
    );
    gh.factory<_i155.GetOrdersUseCase>(
      () => _i155.GetOrdersUseCase(gh<_i494.OrderRepository>()),
    );
    gh.factory<_i479.GetOrderByIdUseCase>(
      () => _i479.GetOrderByIdUseCase(gh<_i494.OrderRepository>()),
    );
    gh.factory<_i1051.CreateReviewUseCase>(
      () => _i1051.CreateReviewUseCase(gh<_i494.ReviewRepository>()),
    );
    gh.factory<_i757.DeleteReviewUseCase>(
      () => _i757.DeleteReviewUseCase(gh<_i494.ReviewRepository>()),
    );
    gh.factory<_i655.GetReviewsUseCase>(
      () => _i655.GetReviewsUseCase(gh<_i494.ReviewRepository>()),
    );
    gh.factory<_i49.GetCartItemsUseCase>(
      () => _i49.GetCartItemsUseCase(
        gh<_i494.CartItemRepository>(),
        gh<_i494.ProductRepository>(),
      ),
    );
    gh.factory<_i839.LogoutUseCase>(
      () =>
          _i839.LogoutUseCase(gh<_i494.Repository>(), gh<_i494.AppNavigator>()),
    );
    gh.factory<_i150.GetOrderItemsUseCase>(
      () => _i150.GetOrderItemsUseCase(gh<_i494.OrderItemRepository>()),
    );
    gh.factory<_i245.FakeLoginUseCase>(
      () => _i245.FakeLoginUseCase(
        gh<_i494.AppNavigator>(),
        gh<_i494.Repository>(),
      ),
    );
    gh.factory<_i578.GetAddressesUseCase>(
      () => _i578.GetAddressesUseCase(gh<_i494.AddressRepository>()),
    );
    gh.factory<_i429.CreateAddressUseCase>(
      () => _i429.CreateAddressUseCase(gh<_i494.AddressRepository>()),
    );
    gh.factory<_i647.DeleteAddressUseCase>(
      () => _i647.DeleteAddressUseCase(gh<_i494.AddressRepository>()),
    );
    gh.factory<_i156.UpdateAddressUseCase>(
      () => _i156.UpdateAddressUseCase(gh<_i494.AddressRepository>()),
    );
    gh.factory<_i11.CheckoutSelectedItemsUseCase>(
      () => _i11.CheckoutSelectedItemsUseCase(
        gh<_i494.CartItemRepository>(),
        gh<_i494.OrderRepository>(),
      ),
    );
    gh.factory<_i200.GetFavoritesUseCase>(
      () => _i200.GetFavoritesUseCase(gh<_i494.FavoriteRepository>()),
    );
    gh.factory<_i523.ToggleFavoriteUseCase>(
      () => _i523.ToggleFavoriteUseCase(gh<_i494.FavoriteRepository>()),
    );
    gh.factory<_i120.GetProductImagesUseCase>(
      () => _i120.GetProductImagesUseCase(gh<_i494.ProductImageRepository>()),
    );
    gh.factory<_i756.GetFeaturedProductsUseCase>(
      () => _i756.GetFeaturedProductsUseCase(gh<_i494.ProductRepository>()),
    );
    gh.factory<_i224.GetProductsByCategoryUseCase>(
      () => _i224.GetProductsByCategoryUseCase(gh<_i494.ProductRepository>()),
    );
    gh.factory<_i961.GetProductsUseCase>(
      () => _i961.GetProductsUseCase(gh<_i494.ProductRepository>()),
    );
    gh.factory<_i747.GetProductByIdUseCase>(
      () => _i747.GetProductByIdUseCase(gh<_i494.ProductRepository>()),
    );
    gh.factory<_i266.ClearCurrentUserDataUseCase>(
      () => _i266.ClearCurrentUserDataUseCase(gh<_i494.Repository>()),
    );
    gh.factory<_i785.ForgotPasswordUseCase>(
      () => _i785.ForgotPasswordUseCase(gh<_i494.Repository>()),
    );
    gh.factory<_i428.GetInitialAppDataUseCase>(
      () => _i428.GetInitialAppDataUseCase(gh<_i494.Repository>()),
    );
    gh.factory<_i160.GetInitialHomeDataUseCase>(
      () => _i160.GetInitialHomeDataUseCase(gh<_i494.Repository>()),
    );
    gh.factory<_i1037.GetUsersUseCase>(
      () => _i1037.GetUsersUseCase(gh<_i494.Repository>()),
    );
    gh.factory<_i8.IsLoggedInUseCase>(
      () => _i8.IsLoggedInUseCase(gh<_i494.Repository>()),
    );
    gh.factory<_i482.LoadInitialResourceUseCase>(
      () => _i482.LoadInitialResourceUseCase(gh<_i494.Repository>()),
    );
    gh.factory<_i905.LoadMoreUsersUseCase>(
      () => _i905.LoadMoreUsersUseCase(gh<_i494.Repository>()),
    );
    gh.factory<_i847.LoginUseCase>(
      () => _i847.LoginUseCase(gh<_i494.Repository>()),
    );
    gh.factory<_i266.RegisterAccountUseCase>(
      () => _i266.RegisterAccountUseCase(gh<_i494.Repository>()),
    );
    gh.factory<_i528.ResetPasswordUseCase>(
      () => _i528.ResetPasswordUseCase(gh<_i494.Repository>()),
    );
    gh.factory<_i301.SaveIsDarkModeUseCase>(
      () => _i301.SaveIsDarkModeUseCase(gh<_i494.Repository>()),
    );
    gh.factory<_i319.SaveIsFirstLaunchAppUseCase>(
      () => _i319.SaveIsFirstLaunchAppUseCase(gh<_i494.Repository>()),
    );
    gh.factory<_i95.SaveLanguageCodeUseCase>(
      () => _i95.SaveLanguageCodeUseCase(gh<_i494.Repository>()),
    );
    gh.factory<_i529.GetProfileUseCase>(
      () => _i529.GetProfileUseCase(gh<_i494.ProfileRepository>()),
    );
    gh.factory<_i329.UpdateProfileUseCase>(
      () => _i329.UpdateProfileUseCase(gh<_i494.ProfileRepository>()),
    );
    gh.factory<_i249.GetMeUseCase>(
      () => _i249.GetMeUseCase(gh<_i494.ProfileRepository>()),
    );
    gh.factory<_i829.DeleteCartItemUseCase>(
      () => _i829.DeleteCartItemUseCase(gh<_i494.CartItemRepository>()),
    );
    gh.factory<_i11.UpdateCartItemQuantityUseCase>(
      () => _i11.UpdateCartItemQuantityUseCase(gh<_i494.CartItemRepository>()),
    );
    gh.factory<_i466.AddToCartUseCase>(
      () => _i466.AddToCartUseCase(gh<_i494.CartItemRepository>()),
    );
    gh.factory<_i896.GetCategoriesUseCase>(
      () => _i896.GetCategoriesUseCase(gh<_i494.CategoryRepository>()),
    );
    gh.factory<_i151.GetCategoryByIdUseCase>(
      () => _i151.GetCategoryByIdUseCase(gh<_i494.CategoryRepository>()),
    );
    return this;
  }
}
