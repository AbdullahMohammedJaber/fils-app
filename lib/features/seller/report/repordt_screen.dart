import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/managment/home/home_seller_cubit.dart';
import 'package:fils/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphic/graphic.dart';

class RepordtScreen extends StatelessWidget {
  const RepordtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeSellerCubit, HomeSellerState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SizedBox(
            height: 320,
            child: Chart(
              data: context.read<HomeSellerCubit>().reportList,
              variables: {
                'name': Variable(accessor: (Map map) => map['name'] as String),
                'value': Variable(accessor: (Map map) => map['value'] as num),
                'color': Variable(accessor: (Map map) => map['color'] as Color),
              },
              marks: [
                IntervalMark(
                  position: Varset('name') * Varset('value'),
                  color: ColorEncode(variable: 'color'),
                  size: SizeEncode(value: 28),
                ),
              ],
              axes: [
                Defaults.horizontalAxis
                  ..label = LabelStyle(
                    rotation: -0.6,
                    textStyle: const TextStyle(fontSize: 11),
                  ),
                Defaults.verticalAxis,
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomBarChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final double height;

  const CustomBarChart({super.key, required this.data, this.height = 260});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('No data'));
    }

    final maxValue = data
        .map((e) => (int.parse(e['value'].toString())).toDouble())
        .fold<double>(0, (prev, elem) => elem > prev ? elem : prev);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: ItemTitleBar(title: "Reports".tr(), canBack: true),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:
                  data.map((item) {
                    final value =
                        (int.parse(item['value'].toString())).toDouble();
                    final percent = maxValue == 0 ? 0.0 : (value / maxValue);

                    return Expanded(
                      child: _BarItem(
                        label: item['name'],
                        value: value,
                        percent: percent,
                        color: item['color'],
                      ),
                    );
                  }).toList(),
            ),
          ),
          Divider(),
          SizedBox(height: heigth * 0.05),

          _Legend(data: data),
          SizedBox(height: heigth * 0.01),
        ],
      ),
    );
  }
}

class _BarItem extends StatelessWidget {
  final String label;
  final double value;
  final double percent;
  final Color color;

  const _BarItem({
    required this.label,
    required this.value,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final safePercent = percent.isNaN || percent.isInfinite ? 0.0 : percent;
    final displayHeight = max(safePercent * 180, 8);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(value.toStringAsFixed(0), style: const TextStyle(fontSize: 11)),
        const SizedBox(height: 4),
        AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
          height: displayHeight.toDouble(),
          width: 18,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        SizedBox(height: heigth * 0.01),
        
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const _Legend({required this.data});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 6,
      children:
          data.map((item) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: item['color'],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(item['name'].toString().tr(), style: const TextStyle(fontSize: 11)),
              ],
            );
          }).toList(),
    );
  }
}
