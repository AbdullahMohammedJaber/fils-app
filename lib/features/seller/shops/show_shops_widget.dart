import 'package:fils/core/data/response/shops/shops_response.dart';
import 'package:fils/managment/shops/shops_cubit.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectShopDropdown extends StatefulWidget {
  final List<Shop> items;
  final Function(Shop shop) onChanged;
  final VoidCallback? onAddNewShop;
  final String hint;

  const SelectShopDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.onAddNewShop,
    this.hint = "Select Shop",
  });

  @override
  State<SelectShopDropdown> createState() => _SelectShopDropdownState();
}

class _SelectShopDropdownState extends State<SelectShopDropdown>
    with SingleTickerProviderStateMixin {
  Shop? _selectedShop;
  bool _isOpen = false;

  late final AnimationController _controller;
  late final Animation<double> _iconAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _iconAnim = Tween<double>(begin: 0, end: 0.5).animate(_controller);
  }

  void _toggleDropdown() {
    setState(() {
      if (!_isOpen) {
        context.read<ShopsCubit>().getAllShops();
      }
      _isOpen = !_isOpen;
      _isOpen ? _controller.forward() : _controller.reverse();
    });
  }

  void _selectShop(Shop shop) {
    setState(() {
      _selectedShop = shop;
      _isOpen = false;
    });

    _controller.reverse();
    widget.onChanged(shop);
  }

  String _getSelectedText() {
    return _selectedShop?.name ?? widget.hint;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// Dropdown Button
        GestureDetector(
          onTap: _toggleDropdown,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: primaryColor.withOpacity(0.4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _getSelectedText(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color:
                          _selectedShop == null ? Colors.grey : Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                RotationTransition(
                  turns: _iconAnim,
                  child: const Icon(Icons.keyboard_arrow_down_rounded),
                ),
              ],
            ),
          ),
        ),

        /// Dropdown List
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: _isOpen
              ? Container(
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Shops list
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.items.length,
                        itemBuilder: (context, index) {
                          final shop = widget.items[index];
                          final isSelected =
                              _selectedShop?.id == shop.id;

                          return InkWell(
                            onTap: () => _selectShop(shop),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              color: isSelected
                                  ? primaryColor.withOpacity(0.12)
                                  : Colors.transparent,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      shop.name,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Icon(
                                      Icons.check_circle,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      const Divider(height: 1),

                      /// Add new shop button (Fixed)
                      InkWell(
                        onTap: () {
                          setState(() => _isOpen = false);
                          _controller.reverse();
                          widget.onAddNewShop?.call();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_business,
                                color: primaryColor,
                                size: 22,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Add New Shop',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
