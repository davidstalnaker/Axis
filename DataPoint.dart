class DataPoint {
  num x, y;
  
  DataPoint(this.x, this.y);
  
  DataPoint operator +(DataPoint other) => new DataPoint(this.x + other.x, this.y + other.y);
  DataPoint operator -(DataPoint other) => new DataPoint(this.x - other.x, this.y - other.y);
  DataPoint operator *(DataPoint other) => new DataPoint(this.x * other.x, this.y * other.y);
  DataPoint operator /(DataPoint other) => new DataPoint(this.x / other.x, this.y / other.y);
}