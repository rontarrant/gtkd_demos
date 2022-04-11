// OOP test rig

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
	
	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Test Rig";
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		
		sayHi();
		
		showAll();
		
	} // this()
	
	void quitApp(Widget widget)
	{
		string exitMessage = "Bye.";
		
		writeln(exitMessage);
		
		Main.quit();
		
	} // quitApp()
	
	void sayHi()
	{
		string message = "Hello, GtkD OOP World";
		
		writeln(message);
		
	} // sayHi()
	
} // TestRigWindow class
