import 'package:englens/src/ui/screens/home/progress_chart/progress_chart_screen_viewmode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
// import 'package:fl_chart/fl_chart.dart';

class ProgressChartScreen extends GetView<ProgressChartScreenViewmodel> {
  static const routeName = "/progressChartScreen";
  const ProgressChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _appBar() {
      return AppBar(title: Text("Chart"));
    }

    FlTitlesData _titlesData() {
      return FlTitlesData(
        // Tiêu đề trục dưới (X)
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) {
              return SideTitleWidget(
                // axisSide: meta.axisSide,
                space: 4.0,
                meta: meta,
                child: Text(
                  controller.learningRecords[value.toInt()].learnDate!,
                ),
              );
            },
          ),
        ),
      );
    }

    List<BarChartGroupData> _createBarGroups() {
      return List.generate(
        controller.learningRecords.length <= 7
            ? controller.learningRecords.length
            : 7,
        (index) => BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: controller.learningRecords[index].wordIds!.length.toDouble(),
              color: Colors.lightBlue,
              gradient: const LinearGradient(
                colors: [Colors.lightBlue, Colors.indigo],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              width: 20,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
            ),
          ],
        ),
      );
    }

    _body() {
      return BarChart(
        BarChartData(barGroups: _createBarGroups(), titlesData: _titlesData()),

        duration: Duration(milliseconds: 150), // Optional
        curve: Curves.linear, // Optional
      );
    }

    return Scaffold(appBar: _appBar(), body: _body());
  }
}
