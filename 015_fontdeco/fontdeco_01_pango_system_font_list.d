// This source code is in the public domain.

// Test Rig Foundation for Learning GtkD Coding

import std.stdio;

// Pango: List System Fonts

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import pango.PgCairoFontMap;
import pango.PgFontMap;
import pango.PgFontFamily;

import singleton.S_FontList;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Pango: List System Fonts";
	AppBox appBox;
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		
		appBox = new AppBox();
		add(appBox);
		
		showAll();

	} // this() CONSTRUCTOR
	
		
	void quitApp(Widget widget)
	{
		writeln("Bye.");
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class AppBox : Box
{
	S_FontList s_FontList;
	// add child object definitions here
	
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		// instantiate child objects here
		s_FontList = s_FontList.get();
		s_FontList.listFonts();
		
		// packStart(<child object>, false, false, 0); // LEFT justify
		// packEnd(<child object>, false, false, 0); // RIGHT justify
		
	} // this()

} // class AppBox
