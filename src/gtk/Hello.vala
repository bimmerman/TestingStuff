public class Hello : Gtk.Application {

  public Hello() {
    Object(
      application_id: "com.github.bimmerman.repo",
      flags: ApplicationFlags.FLAGS_NONE
    );
  }

  protected override void activate() {
    var window = new Gtk.ApplicationWindow(this);
    window.title = "hello, world";
    window.default_height = 300;
    window.default_width = 300;
    
    Gtk.Button button = new Gtk.Button();
    button.set_label("Click Me");
    button.clicked.connect(() => {
    stdout.printf("hello,world\n");
    });
    
    Gtk.Label label = new Gtk.Label("hello, world");
    
    Gtk.Grid grid = new Gtk.Grid();
    grid.attach(label, 0, 0);
    grid.attach(button, 0, 1);
    
    
    
    window.add(grid);
    
    window.show_all();
  }
}
