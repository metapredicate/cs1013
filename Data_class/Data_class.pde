import de.bezier.data.sql.*;

SQLite db;

void setup()
{
    size( 100, 100 );

    db = new SQLite( this, "Sort.db" );  // open database file

    if ( db.connect() )
    {
        db.query( "SELECT * FROM Date" );
        
        while (db.next())
        {
          
        }
    }
}