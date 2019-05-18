import java.sql.*;

public class SQLServerDatabase{
   
   private Connection conn = null;
   
   // Connect to Jobs database on Theodore server, MS Sql db
   private final String uri = "jdbc:sqlserver://theodore.ist.rit.edu;databaseName=Jobs";
   private final String driver ="com.microsoft.sqlserver.jdbc.SQLServerDriver";
   private final String user = "330User";
   private final String password = "330Password";
   
 
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
         //check to see if the database was connected before
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

}// end SQLServerDatabase