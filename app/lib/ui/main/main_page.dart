import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../app.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends BasePageState<MainPage, MainBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return AutoTabsScaffold(
      routes: (navigator as AppNavigatorImpl).tabRoutes,
      bottomNavigationBuilder: (_, tabsRouter) {
        (navigator as AppNavigatorImpl).tabsRouter = tabsRouter;

        return SafeArea(
          bottom: true,
          child: Container(
            margin: EdgeInsets.all(Dimens.d16.responsive()),
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.d12.responsive(),
              vertical: Dimens.d8.responsive(),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimens.d40.responsive()),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: BottomTab.values.map((tab) {
                final isSelected = tabsRouter.activeIndex == tab.index;

                return GestureDetector(
                  onTap: () {
                    if (isSelected) {
                      (navigator as AppNavigatorImpl).popUntilRootOfCurrentBottomTab();
                    }
                    tabsRouter.setActiveIndex(tab.index);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.symmetric(
                      horizontal: isSelected ? Dimens.d16.responsive() : Dimens.d12.responsive(),
                      vertical: Dimens.d8.responsive(),
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFF0F9F6) : Colors.transparent,
                      borderRadius: BorderRadius.circular(Dimens.d30.responsive()),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildIcon(tab, isSelected),
                        if (isSelected) ...[
                          SizedBox(width: Dimens.d8.responsive()),
                          Text(
                            tab.title,
                            style: AppTextStyles.s14w400Primary().copyWith(
                              color: const Color(0xFF7EB6A7),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildIcon(BottomTab tab, bool isSelected) {
    final iconColor = isSelected ? const Color(0xFF7EB6A7) : const Color(0xFFA5A199);
    final iconData = (isSelected ? tab.activeIcon : tab.icon).icon;

    Widget iconWidget = Icon(
      iconData,
      color: iconColor,
      size: Dimens.d24.responsive(),
    );

    // Dummy badge for cart
    if (tab == BottomTab.cart) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          iconWidget,
          Positioned(
            right: -4,
            top: -4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Color(0xFFE57373),
                shape: BoxShape.circle,
              ),
              child: Text(
                '6',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimens.d10.responsive(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return iconWidget;
  }
}
