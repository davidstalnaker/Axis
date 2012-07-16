#import('dart:html');
#import('Chart.dart');

void main() {
  var chart = new Chart(400, 800, document.query('#chart'));
  chart.drawLineGraph([new DataPoint(0,0), new DataPoint(1,5), new DataPoint(2,3), new DataPoint(3,7), new DataPoint(4,5)]);
}