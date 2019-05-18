

public class PE_2{
   
   public static void main(String [] args){
   
      SQLServerDatabase mssqld = new SQLServerDatabase(); // create an instance of the SQL Server Database
      MySqlDatabase mysqld = new MySqlDatabase(); // create an instance of MySQL database
      
     System.out.println("Establishing a connection to the Databases Please wait!!!!!!!");
      

      //check to see if MS SQL database connection is open 
      if(mssqld.connect()){
         System.out.println("Connection to Sql Database Successful");
         
         //close the database
        if(mssqld.close()){
         
           System.out.println("Closing Sql Database Connection");
        }
        
        //print out this statement if database is unable to close
        else {
           System.out.println("Unable to Sql close database.");
        }
      
      }
        //print out this statement if database is unable to connect
      else {
      
           System.out.println("Unable to connect to Sql database");
      }
      
          //check to see if MySQL database connection is open
        if(mysqld.connect()){
            System.out.println("Connection to MySql Database Successful");
           
            //close the database
          if( mysqld.close()){
             
               System.out.println("Closing MySql Database Connection");
          }
           //print out this statement if database is unable to close
          else {
               System.out.println("Unable to close MySql database."); 
          }  
      }
         
           //print out this statement if database is unable to connect
       else{
         
      
        System.out.println("Unable to connect to MySql database");
        
      }
    

   } //end main


}//end class Main