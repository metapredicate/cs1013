import de.bezier.data.sql.*;

SQLite db;

void setup()
{
  db = new SQLite( this, "landdata.db" );  // open database file
  if (db.connect())
  {
    db.query( "SELECT name as \"Name\" FROM SQLITE_MASTER where type=\"table\"" );
  }

  //db.execute("CREATE TABLE TopPrices (Prices Integer)");
  //db.execute("CREATE TABLE Counties (County TEXT)");
  //db.execute("DELETE FROM TopPrices");
  db.execute("DELETE FROM Counties ");

  //db.query( "SELECT * FROM registry ORDER BY Price DESC LIMIT 10" );
  //int maxValue=0;
  //int  temp[] = new int[10] ;
  //for (int i=0; i<10; i++)
  //{
  //  if (db.next()) {
  //    temp[i] = db.getInt("Price");
  //    if (temp[i]>maxValue) 
  //    {
  //      maxValue = temp[i];
  //    }
  //  }
  //}
  //db.query( "SELECT * FROM TopPrices");
  //for (int i=0; i<10; i++)
  //{
  //  db.execute("INSERT INTO TopPrices ('Prices') Values ("+temp[i]+")");
  //}

  db.query("SELECT DISTINCT County FROM registry ");
  ArrayList<String> tempList = new ArrayList<String>();
  for (int i=0; i<10; i++)
  {
    if (db.next()) {

      tempList.add(db.getString("County"));
      println(tempList.get(i));
    }
  }
  db.query( "SELECT County FROM Counties");
  for (int i=0; i<tempList.size(); i++)
  {    
    db.execute("INSERT INTO Counties(County) VALUES ('"+tempList.get(i)+"')");
  }

  db.execute("CREATE TABLE AverageCountyPrice (Price Integer, County TEXT)");
  boolean finished = false;
  int average [] = new int[10];

  for (int i=0; i<tempList.size(); i++)
  {    
    while (!finished) {
      db.query("SELECT Price From registry WHERE County = '"+tempList.get(i)+"'");
    }
  }

  println("finished");
}