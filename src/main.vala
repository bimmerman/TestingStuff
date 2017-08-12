using Gtk;
using Mysql;

int count=0;

// Declare interface elements we want to manipulate
Gtk.Widget lbl_count;
Gtk.Widget lbl_hello;

// Change the label
public void on_button2_clicked (Button source) {
	source.label = "Thanks!";
}

// When button is clicked, query the database and output a value to the label.
public void on_btn_hello_clicked (Button source) {
	count++;
	lbl_count.set("label",count.to_string());

 	int rc = 0;

	ClientFlag cflag    = 0;
	string     host     = "127.0.0.1";
	string     user     = "brad";
    string     password = "8rLRxS70";
    string     database = "test";
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

    string sql = "SELECT * FROM licence_manager.application;";
    rc = mysql.query(sql);
    if ( rc != 0 ) {
        stdout.printf("ERROR %u: Query failed: %s\n", mysql.errno(), mysql.error());
    }

    Result ResultSet = mysql.use_result();

    string[] MyRow;

    while ( (MyRow = ResultSet.fetch_row()) != null ) {
	    lbl_hello.set("label",MyRow[1]);
        stdout.printf("id: %s\nname: %s\ndefault_request_action: %s\napplication_guid: %s\n", MyRow[0], MyRow[1], MyRow[2], MyRow[3]);
    }
}

int main (string[] args)
{
	// to build this: valac --pkg mysql main.vala -X -L/usr/lib64/mysql -X -lmysqlclient
	// not sure what this does >>> valac -c --pkg mysql main.vala

	// Gtk and Mysql libraries
	// valac -v --pkg mysql --pkg gtk+-3.0 --pkg gmodule-2.0 main.vala -X -L/usr/lib64/mysql -X -lmysqlclient

    Gtk.init (ref args);

	// Compilation on command line needs to include the file when its seperated.
	// valac --pkg gtk+-3.0 --pkg gmodule-2.0 main.vala TextFileViewer.vala
    // var window = new TextFileViewer();
    // window.destroy.connect (Gtk.main_quit);
    // window.show_all ();
    // Gtk.main ();

	// Attempting to load UI from a Glade xml file.
	// This doesn't work from Builder but needs to be compiled on command line:
	// [bhoffort@brad src]$ valac --pkg gtk+-3.0 --pkg gmodule-2.0 main.vala
	// ./main
    try
    {
        var builder = new Builder ();
        builder.add_from_file ("window_main.glade");
        builder.connect_signals (null);

        // Wireup references to the interface controls.
        var window = builder.get_object ("window") as Window;
        lbl_count = builder.get_object("lbl_count") as Widget;
        lbl_hello = builder.get_object("lbl_hello") as Widget;

        window.destroy.connect (Gtk.main_quit);
        window.show_all ();
        Gtk.main ();
    }
    catch (Error e)
    {
        stderr.printf ("Could not load UI: %s\n", e.message);
        return 1;
    }

    return 0;
}
