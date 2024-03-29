using Gtk;

// valac -v --pkg gtk+-3.0 --pkg gmodule-2.0 ListSample.vala -o main
// Working 2/24/2022

int main (string[] args)
{
    Gtk.init (ref args);

    var window = new ListSample();
    window.destroy.connect (Gtk.main_quit);
    window.show_all ();
    Gtk.main ();
    return 0;
}

public class ListSample : Gtk.Window {

    private Gtk.ListStore list_store;
    private TreeView tree_view;

    private enum Columns {
        TOGGLE,
        TEXT,
        N_COLUMNS
    }

    public ListSample () {
        this.title = "List Sample";
        this.destroy.connect (Gtk.main_quit);
        set_size_request (200, 200);

        list_store = new Gtk.ListStore (Columns.N_COLUMNS, typeof (bool), typeof (string));
        tree_view = new TreeView.with_model (list_store);

        var toggle = new CellRendererToggle ();
        toggle.toggled.connect ((toggle, path) => {
            var tree_path = new TreePath.from_string (path);
            TreeIter iter;
            list_store.get_iter (out iter, tree_path);
            list_store.set (iter, Columns.TOGGLE, !toggle.active);
        });

        var column = new TreeViewColumn ();
        column.pack_start (toggle, false);
        column.add_attribute (toggle, "active", Columns.TOGGLE);
        tree_view.append_column (column);

        var text = new CellRendererText ();

        column = new TreeViewColumn ();
        column.pack_start (text, true);
        column.add_attribute (text, "text", Columns.TEXT);
        tree_view.append_column (column);

        tree_view.set_headers_visible (false);

        TreeIter iter;
        list_store.append (out iter);
        list_store.set (iter, Columns.TOGGLE, true, Columns.TEXT, "item 1");
        list_store.append (out iter);
        list_store.set (iter, Columns.TOGGLE, false, Columns.TEXT, "item 2");

        add (tree_view);
    }
}
 
