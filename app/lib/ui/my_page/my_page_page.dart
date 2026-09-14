import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../app.dart';

@RoutePage(name: 'MyPageRoute')
class MyPagePage extends StatefulWidget {
  const MyPagePage({super.key});

  @override
  State<StatefulWidget> createState() => _MyPagePageState();
}

class _MyPagePageState extends BasePageState<MyPagePage, MyPageBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const MyPagePageInitiated());
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      backgroundColor: const Color(0xFFFAFAF7),
      appBar: CommonAppBar(
        text: 'Tài khoản',
        titleTextStyle: AppTextStyles.s14w400Primary().copyWith(
          fontSize: Dimens.d20.responsive(),
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
        leadingIcon: LeadingIcon.none,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz, size: Dimens.d24.responsive()),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<MyPageBloc, MyPageState>(
          buildWhen: (prev, curr) =>
              prev.profile != curr.profile || prev.isShimmerLoading != curr.isShimmerLoading,
          builder: (context, state) {
            if (state.isShimmerLoading && state.profile == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildProfileHeader(state),
                  _buildStats(),
                  _buildMenuSection(),
                  _buildSettingsSection(),
                  _buildVersionInfo(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileHeader(MyPageState state) {
    final profile = state.profile;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.d20.responsive(),
        vertical: Dimens.d12.responsive(),
      ),
      child: Column(
        children: [
          // Avatar
          Stack(
            children: [
              CircleAvatar(
                radius: Dimens.d42.responsive(),
                backgroundColor: const Color(0xFFE8CBB8),
                backgroundImage:
                    profile?.avatarUrl != null ? NetworkImage(profile!.avatarUrl!) : null,
                child: profile?.avatarUrl == null
                    ? Icon(Icons.person, size: Dimens.d40.responsive(), color: Colors.white)
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: Dimens.d26.responsive(),
                  height: Dimens.d26.responsive(),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111110),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Icon(Icons.add, size: Dimens.d14.responsive(), color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimens.d12.responsive()),
          // Name
          Text(
            profile?.fullName ?? '',
            style: AppTextStyles.s14w400Primary().copyWith(
              fontFamily: 'Instrument Serif',
              fontSize: Dimens.d24.responsive(),
            ),
          ),
          SizedBox(height: Dimens.d2.responsive()),
          // Email placeholder — ProfileEntity chưa có email
          Text(
            profile?.phoneNumber ?? '',
            style: AppTextStyles.s14w400Secondary().copyWith(
              fontSize: Dimens.d12.responsive(),
              color: const Color(0xFF6B6862),
            ),
          ),
          SizedBox(height: Dimens.d10.responsive()),
          // Membership badge
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.d12.responsive(),
              vertical: Dimens.d4.responsive(),
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF3EDE4),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, size: Dimens.d10.responsive(), color: const Color(0xFF7A5C3C)),
                SizedBox(width: Dimens.d6.responsive()),
                Text(
                  'Thành viên Gold · 2.450 điểm',
                  style: AppTextStyles.s14w400Primary().copyWith(
                    fontSize: Dimens.d10.responsive(),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF7A5C3C),
                    letterSpacing: 0.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    final stats = [
      {'n': '24', 'l': 'Đơn hàng'},
      {'n': '12', 'l': 'Yêu thích'},
      {'n': '3', 'l': 'Voucher'},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.d20.responsive()),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Dimens.d14.responsive()),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F1EC),
          borderRadius: BorderRadius.circular(Dimens.d12.responsive()),
        ),
        child: Row(
          children: stats.asMap().entries.map((entry) {
            final i = entry.key;
            final s = entry.value;
            return Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: i < stats.length - 1
                      ? const Border(right: BorderSide(color: Color(0xFFDDD8CE)))
                      : null,
                ),
                child: Column(
                  children: [
                    Text(
                      s['n']!,
                      style: AppTextStyles.s14w400Primary().copyWith(
                        fontFamily: 'Instrument Serif',
                        fontSize: Dimens.d22.responsive(),
                      ),
                    ),
                    SizedBox(height: Dimens.d2.responsive()),
                    Text(
                      s['l']!,
                      style: AppTextStyles.s14w400Secondary().copyWith(
                        fontSize: Dimens.d10.responsive(),
                        color: const Color(0xFF6B6862),
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMenuSection() {
    final menuItems = [
      _MenuItem(Icons.shopping_bag_outlined, 'Đơn hàng của tôi', badge: '2 đang giao'),
      _MenuItem(Icons.favorite_border, 'Sản phẩm yêu thích', badge: '4'),
      _MenuItem(Icons.location_on_outlined, 'Địa chỉ giao hàng'),
      _MenuItem(Icons.credit_card_outlined, 'Phương thức thanh toán'),
      _MenuItem(Icons.notifications_none, 'Thông báo'),
    ];

    return Padding(
      padding: EdgeInsets.fromLTRB(
        Dimens.d20.responsive(),
        Dimens.d24.responsive(),
        Dimens.d20.responsive(),
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('TÀI KHOẢN'),
          SizedBox(height: Dimens.d8.responsive()),
          ...menuItems.map((item) => _buildMenuItem(item)),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    final settingsItems = [
      _MenuItem(Icons.person_outline, 'Thông tin cá nhân'),
      _MenuItem(Icons.help_outline, 'Trợ giúp & Hỗ trợ'),
    ];

    return Padding(
      padding: EdgeInsets.fromLTRB(
        Dimens.d20.responsive(),
        Dimens.d20.responsive(),
        Dimens.d20.responsive(),
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('CÀI ĐẶT'),
          SizedBox(height: Dimens.d8.responsive()),
          ...settingsItems.map((item) => _buildMenuItem(item)),
          // Logout
          InkWell(
            onTap: () => bloc.add(const LogoutButtonPressed()),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: Dimens.d14.responsive()),
              child: Text(
                'Đăng xuất',
                style: AppTextStyles.s14w400Primary().copyWith(
                  fontSize: Dimens.d13.responsive(),
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFC2410C),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionInfo() {
    return Padding(
      padding: EdgeInsets.only(top: Dimens.d20.responsive(), bottom: Dimens.d30.responsive()),
      child: Text(
        'NORD · v2.6.1',
        style: AppTextStyles.s14w400Secondary().copyWith(
          fontSize: Dimens.d10.responsive(),
          color: const Color(0xFFA5A199),
          letterSpacing: 1.0,
          fontFamily: 'JetBrains Mono',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.s14w400Secondary().copyWith(
        fontSize: Dimens.d9.responsive(),
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
        color: const Color(0xFF6B6862),
      ),
    );
  }

  Widget _buildMenuItem(_MenuItem item) {
    return InkWell(
      onTap: item.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Dimens.d14.responsive()),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE8E5DE))),
        ),
        child: Row(
          children: [
            Icon(item.icon, size: Dimens.d18.responsive(), color: const Color(0xFF3C3B38)),
            SizedBox(width: Dimens.d14.responsive()),
            Expanded(
              child: Text(
                item.label,
                style: AppTextStyles.s14w400Primary().copyWith(
                  fontSize: Dimens.d13.responsive(),
                ),
              ),
            ),
            if (item.badge != null)
              Text(
                item.badge!,
                style: AppTextStyles.s14w400Secondary().copyWith(
                  fontSize: Dimens.d11.responsive(),
                  color: const Color(0xFF6B6862),
                ),
              ),
            SizedBox(width: Dimens.d4.responsive()),
            Icon(Icons.chevron_right, size: Dimens.d14.responsive(), color: const Color(0xFFA5A199)),
          ],
        ),
      ),
    );
  }
}

class _MenuItem {
  const _MenuItem(this.icon, this.label, {this.badge, this.onTap});
  final IconData icon;
  final String label;
  final String? badge;
  final VoidCallback? onTap;
}
