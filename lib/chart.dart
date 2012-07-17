#library('chart');

#import('dart:html');

#source('dataset.dart');
#source('datapoint.dart');

class Chart {
  num height, width;
  Element parent;
  SVGElement svg;
  
  Chart(this.height, this.width, this.parent) {
    svg = new SVGElement.tag('svg');
    svg.attributes['xmlns'] = 'http://www.w3.org/2000/svg';
    svg.attributes['height'] = '${height}px';
    svg.attributes['width'] = '${width}px';
    parent.nodes.add(svg);
  }
  
  void drawLineGraph(DataSet points) {
    svg.nodes.clear();
    points = points.scale(new DataPoint(10, 10), new DataPoint(width - 10, height - 10));
    var graph = new SVGElement.tag('path');
    var pathPoints = new StringBuffer('M ');
    pathPoints.add(Strings.join(points.data.map((p) => '${p.x} ${height - p.y}'), ' L '));
    graph.attributes = {'fill': 'none', 'stroke': '#aaaaaa', 'd': pathPoints, 'stroke-width': '8', 
                        'stroke-linejoin': 'round', 'stroke-linecap':'round'};
    svg.nodes.add(graph);
    for (var p in points.data) {
      var circle = new SVGElement.tag('circle');
      circle.attributes = {'fill': '#aaaaaa', 'cx': '${p.x}', 'cy': '${height - p.y}', 'r': '8'};
      circle.on.mouseOver.add((e) {
        print(p.x);
        print(p.y);
      });
      svg.nodes.add(circle);
    }
  }
}

