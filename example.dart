#import('dart:html');
#import('Chart.dart');

void main() {
  var chart = new Chart(400, 800, document.query('#chart'));
  chart.drawLineGraph(new DataSet.fromList([[0,0], [1,5], [2,3], [3,7], [4,5]]));
}