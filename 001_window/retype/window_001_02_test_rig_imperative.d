// test_rig_imperative.d

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

void main(string[] args)
{
	Main.init(args);
	MainWindow testRigWindow = new MainWindow("Test Rig");
	testRigWindow.addOnDestroy(delegate void(Widget w) { quitApp();} );
	
	writeln("Hello, GtkD Imperative World!");
	
	// Show the window and its contents
	testRigWindow.showAll();
	
	// give control over to gtkD
	Main.run();
	
} // main()


void quitApp()
{
	// This exists in case we want to do anything
	// before exiting... such as warning the user
	// to save work.
	writeln("Bye");
	Main.quit();
	
} // quitApp()
