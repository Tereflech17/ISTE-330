import java.sql.*;


public class MySqlDatabase {
   
   private Connection conn = null;
   
   // Connect to travel database on our computer, MySQL
   private final String uri = "jdbc:mysql://localhost/travel?autoReconnect=true&useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
   private final String driver ="com.mysql.cj.jdbc.Driver";
   private final String user = "root";
   private final String password = "student";
   
   
   
   /**
     The connect method loads the 
     driver and connects to the database
     @return: boolean 
   */
   public boolean connect(){
      try
      {  
         //load the driver
         Class.forName(driver);
         
         //connect to the database
         conn = DriverManager.getConnection(uri, user, password);
         return true;
         
      }
      catch(ClassNotFoundException cnfe)
      {
         cnfe.printStackTrace();
      }
      catch(SQLException sqle)
      {
         sqle.printStackTrace();
      }
      
         return false; 
   
   }// end of connect method 
   
   
    /**
     The close method loads the 
     close connection to the database
     @return: boolean 
   */
  
   public boolean close(){
      
      try
      {
         if(conn != null) conn.close();
         return true;
      
      }
      catch(SQLException sqle)
      {
         sqle.printStackTrace();
      }
      
      catch(Exception e)
      {
         e.printStackTrace();
      }
      
       return false;
       
   }// end of close method


}// end class MySqlDatabase