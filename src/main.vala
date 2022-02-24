using Gtk;
using Mysql;
//using Mysharedlibrary;

//int count=0;

// Declare interface elements we want to manipulate
//Gtk.Label lbl_count;
//Gtk.Label lbl_hello;
//Gtk.CheckButton check_button;
//Gtk.Entry text_input;

/* Change the label
public void on_button2_clicked (Button source) {
	source.label = "Thanks!";
}

public void on_btn_testing_inputs_clicked(Button source)
{
	stdout.printf("INPUTS: textbox [%s] check_button [%s]\n",
		text_input.get_text(),
		check_button.get_active()?"true":"false");
}

// When button is clicked, query the database and output a value to the label.
public void on_btn_hello_clicked (Button source) {
	count++;
	lbl_count.set("label",count.to_string());
	//lbl_hello.set("label",getName());
}
*/

int main (string[] args)
{
    /*
    // Case 1: Shared Library.
    // Working 2/24/2022
    // Built this section with Gtk and Mysql libraries: (may not need all the libraries...)
    // valac -v --pkg mysql --pkg gtk+-3.0 --pkg gmodule-2.0 MySharedLibrary.vapi main.vala -X -L/usr/lib64/mysql -X -lmysqlclient -X ./mysharedlibrary.so -X -I. -o main

    stdout.printf("\nTesting shlib");
    stdout.printf("\n\t2 + 3 is %d", sum(2, 3));
    stdout.printf("\n\t8 squared is %d\n", square(8));
    return 0;
    */
    
    /*
    // Case 2: Text File Viewer
    // using statements above require all the libraries to be compiled to satisfy.
    // Working 2/24/2022
    // valac -v --pkg mysql --pkg gtk+-3.0 --pkg gmodule-2.0 TextFileViewer.vala MySharedLibrary.vapi main.vala -X -L/usr/lib64/mysql -X -lmysqlclient -X ./mysharedlibrary.so -X -I. -o main
    Gtk.init (ref args);

    var window = new TextFileViewer();
    window.destroy.connect (Gtk.main_quit);
    window.show_all ();
    Gtk.main ();
    return 0;
    */

    // Attempting to load UI from a Glade xml file.
    // This doesn't work anymore	
    /*
    try
    {
        var builder = new Builder ();
        builder.add_from_file ("window_main.glade");
        builder.connect_signals (null);

        // Wireup references to the interface controls.
        var window = builder.get_object ("window") as Window;
        lbl_count = builder.get_object("lbl_count") as Label;
        lbl_hello = builder.get_object("lbl_hello") as Label;
		check_button = builder.get_object("check_button") as CheckButton;
		text_input = builder.get_object("text_input") as Entry;

        window.destroy.connect (Gtk.main_quit);
        window.show_all ();
        Gtk.main ();
    }
    catch (Error e)
    {
        stderr.printf ("Could not load UI: %s\n", e.message);
        return 1;
    }
    */
    
    // Working 2/24/2022
    // valac -v --pkg mysql --pkg gtk+-3.0 --pkg gmodule-2.0 main.vala -X -L/usr/lib64/mysql -X -lmysqlclient -o main
    stdout.printf("Should be Bob...\ngetName()=[%s]\n",getName());
    return 0;
}

/**
 * Tests the database functionality.
*/
string getName()
{
    int rc = 0;
    string result="";

    ClientFlag cflag    = 0;
    string     host     = "127.0.0.1";
    string     user     = "root";
    string     password = "8rLRxS70!@";
    string     database = "rest_api_demo";
    int        port     = 3306;
    string     socket   = null;

    Database mysql = new Mysql.Database ();

    var isConnected = mysql.real_connect(host, user, password, database, port, socket, cflag);

    if ( !isConnected ) {
        rc = 1;
        stdout.printf("ERROR %u: Connection failed: %s\n", mysql.errno(), mysql.error());
    }

    stdout.printf("Connected to MySQL server version: %s (%lu)\n"
                , mysql.get_server_info()
                , (ulong) mysql.get_server_version());

    string sql = "SELECT * FROM users limit 1;";
    rc = mysql.query(sql);
    if ( rc != 0 ) {
        stdout.printf("ERROR %u: Query failed: %s\n", mysql.errno(), mysql.error());
    }

    Result ResultSet = mysql.use_result();

    string[] MyRow;

    while ( (MyRow = ResultSet.fetch_row()) != null ) {
	    result=MyRow[1];
    }
    return result;   
}
