using Gtk;

// valac -v --pkg gtk+-3.0 --pkg gmodule-2.0 ButtonTest.vala -o main
// Working 2/24/2022

int main (string[] args)
{
    Gtk.init (ref args);

    var window = new ButtonTest();
    window.destroy.connect (Gtk.main_quit);
    window.show_all ();
    Gtk.main ();
    return 0;
}

public class ButtonTest: Window
{
	public ButtonTest()
	{
		this.title = "First GTK+ Program";
		this.border_width=10;
		this.window_position=WindowPosition.CENTER;
		this.set_default_size (350, 70);
		this.destroy.connect (Gtk.main_quit);

		/* You can add GTK+ widgets to your window here.
		 * See https://developer.gnome.org/ for help.
		 */
		var button = new Button.with_label("Click This");
		button.clicked.connect(()=>{
			button.label="Thanks";
		});

		this.add(button);

		try
		{
			this.icon = IconTheme.get_default ().load_icon ("my-app", 48, 0);
		}
		catch (Error e)
		{
			stderr.printf ("Could not load application icon: %s\n", e.message);
		}
	}
}

