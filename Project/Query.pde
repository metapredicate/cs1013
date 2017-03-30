import de.bezier.data.sql.*;
class Query
{
  String search;
  String type;
  SQLite db;
  BarChart chart;
  Query(String search, String type, SQLite data)
  {
    this.search = search;
    this.type = type;
    this.db=data;
    if (db.connect())
    {
      db.query( "SELECT name as \"Name\" FROM SQLITE_MASTER where type=\"table\"" );
    }
    while (db.next())
    {
      println( db.getString("Name") );
    }
  }
  void draw() {
    if(chart!=null){
      chart.draw();
      println(8383);
    }
  
  }

  float [] getTop(int numberToReturn) {
    db.query( "SELECT * FROM registry WHERE "+type+" = '"+search+"' ORDER BY Price DESC LIMIT "+numberToReturn );
    float [] temp = new float[numberToReturn];
    for (int i=0; i<numberToReturn; i++)
    {
      if (db.next()) {
        temp[i] = parseFloat(db.getInt("Price"));
      } 
    }
    float[] yAxix = {1,2,3,4,5,6,7,8,9,10};
    chart = new BarChart(200,200,600,360,yAxix,temp);
    return temp;
  } 
  float [] getBottomTen() {
    db.query( "SELECT * FROM registry ORDER BY Price ASC LIMIT 10" );
    float [] temp = new float[10];
    for (int i=0; i<10; i++)
    {
      if (db.next()) {
        temp[i] = parseFloat(db.getInt("Price"));
      }
    }
    return temp;
  } 
  float getAverage() {
    int average=0;
    db.query("SELECT AVG(Price) From registry WHERE "+type+" = '"+search+"'");
    if (db.next())
      average = db.getInt(1);
    return float(average);
  }
  float [] averageOverTime() {
    float[] average = new float[10];
    for (int i=0; i<20; i++) {
      db.query("SELECT AVG(Price) From registry WHERE "+type+" = '"+search+"' AND Date>='"+(1995+i)+"-01-01 00:00' and Date< '"+(1996+i)+"-01-01 00:00'");
      if (db.next()) {
        average[i] = db.getFloat(1);
        println(average+" "+(1995+i));
      }
    }
    return (average);
  }
  float getMin() {
    float min =0;
    db.query("SELECT MIN(Price) From registry WHERE "+type+" = '"+search+"'");
    if (db.next())
      min = db.getInt(1);
    return min;
  }
  float getMax() {
    float max =0;
    db.query("SELECT MAX(Price) From registry WHERE "+type+" = '"+search+"'");
    if (db.next())
      max = db.getInt(1);
    return max;
  }

  float getRange() {
    float range = getMax()-getMin();
    println(range+" range");
    return range;
  }
  String info() {
    return null;
  }
}