/*
    treeview-list.vala - Vala TreeView list example

    Build with:
    valac --pkg gtk+-3.0 --pkg posix treeview-list.vala -o tv && ./tv
    Working 2/24/2022
*/

static int main (string[] args) {
    Gtk.init (ref args);
    var app = new App ();
    app.start ();
    Gtk.main ();
    return 0;
}

public class App: Object {

    Gtk.Window window;
    Gtk.TreeView treeview;
    Gtk.ListStore liststore;
    Gtk.Label msg_label;

    struct Person {
        int id;
        string name;
        string city;
        string country;

        public string to_string () {
            return @"$(id), $(name), $(city), $(country)";
        }
    }

    Person[] data = {
        Person() {id=1, name="Joe Bloggs", city="London", country="England"},
        Person() {id=2, name="Bill Smith", city="Auckland", country="New Zealand"},
        Person() {id=3, name="Joan Miller", city="Boston", country="USA"},
        Person() {id=4, name="Jan Miller", city="Bston", country="USA"},
        Person() {id=5, name="Jon Miller", city="Boton", country="USA"},
        Person() {id=6, name="Jo Miller", city="Boson", country="USA"},
        Person() {id=7, name="Joa Miller", city="Bostn", country="USA"},
        Person() {id=8, name="Joan iller", city="Bosto", country="USA"},
        Person() {id=9, name="Joan Mller", city="ston", country="USA"},
        Person() {id=10, name="Joan Mler", city="ton", country="USA"}
    };

    construct {
        var builder = new Gtk.Builder();
        try {
            builder.add_from_file("treeview-list.ui");
        }
        catch (Error e) {
            stderr.printf (@"$(e.message)\n");
            Posix.exit(1);
        }
        builder.connect_signals (this);
        this.window = builder.get_object("window") as Gtk.Window;
        this.msg_label = builder.get_object("msg-label") as Gtk.Label;
        this.treeview = builder.get_object ("treeview") as Gtk.TreeView;
        // Load list data.
        this.liststore = builder.get_object ("liststore") as Gtk.ListStore;
        this.liststore.clear ();
        foreach (Person p in this.data) {
            Gtk.TreeIter iter;
            this.liststore.append (out iter);
            this.liststore.set (iter, 0, p.id, 1, p.name, 2, p.city, 3, p.country);
        }
        // Monitor list double-clicks.
        this.treeview.row_activated.connect (on_row_activated);
        // Monitor list selection changes.
        this.treeview.get_selection().changed.connect (on_selection);
        this.window.destroy.connect (Gtk.main_quit);
    }

    public void start () {
        this.window.show_all ();
    }


    private static Person get_selection (Gtk.TreeModel model, Gtk.TreeIter iter) {
        var p = Person();
        model.get (iter, 0, out p.id, 1, out p.name, 2, out p.city, 3, out p.country);
        return p;
    }

    /* List item double-click handler. */
    private void on_row_activated (Gtk.TreeView treeview , Gtk.TreePath path, Gtk.TreeViewColumn column) {
        Gtk.TreeIter iter;
        if (treeview.model.get_iter (out iter, path)) {
            Person p = get_selection (treeview.model, iter);
            this.msg_label.label = @"Double-clicked: $(p)";

            // Edit interface or row is editable perhaps?
        }
    }

    /* List item selection handler. */
    private void on_selection (Gtk.TreeSelection selection) {
        Gtk.TreeModel model;
        Gtk.TreeIter iter;
        if (selection.get_selected (out model, out iter)) {
            Person p = get_selection (model, iter);
            this.msg_label.label = @"Selected: $(p)";
        }
    }

	// private void personNameCell_Edited (object o, Gtk.EditedArgs args)
	// {
	//     Gtk.TreeIter iter;
 //    	treeview.model.get_iter (out iter, new Gtk.TreePath (args.Path));
	//     Person p = get_selection (treeview.model, iter);
	//     p.name = args.NewText;
	// }
}
