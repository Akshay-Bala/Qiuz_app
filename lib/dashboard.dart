import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class DashboardScreen extends StatelessWidget {
  final int totalQuestions;
  final int answered;
  final int unanswered;

  DashboardScreen({
    required this.totalQuestions,
    required this.answered,
    required this.unanswered,
  });

  @override
  Widget build(BuildContext context) {
    double answeredPercentage =
        totalQuestions > 0 ? (answered / totalQuestions) * 100 : 0;

    double unansweredPercentage =
        totalQuestions > 0 ? (unanswered / totalQuestions) * 100 : 0;

    Map<String, double> dataMap = {
      'Answered': answeredPercentage,
      'Unanswered': unansweredPercentage,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Questions: $totalQuestions',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            SizedBox(height: 10),
            Text(
              'Answered Questions: $answered',
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
            Text(
              'Unanswered Questions: $unanswered',
              style: TextStyle(fontSize: 20, color: Colors.orange),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(8),
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: Colors.black26,
                      offset: Offset(2, 2))
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Quiz Performance',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  PieChart(
                    dataMap: dataMap,
                    chartType: ChartType.ring,
                    chartRadius: MediaQuery.of(context).size.width / 2.5,
                    colorList: [Colors.green, Colors.red],
                    legendOptions: LegendOptions(
                      showLegends: true,
                      legendPosition: LegendPosition.right,
                      legendTextStyle: TextStyle(fontSize: 14),
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      decimalPlaces: 1,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  'Log out',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
