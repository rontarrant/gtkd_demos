// This source code is in the public domain.

// HeaderBar demo - changing the layout

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.HeaderBar;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "HeaderBar - Change Layout";
	MyHeaderBar  myHeaderBar;
	AppBox appBox;
	string iconName = "images/road_crew.png";
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		
		myHeaderBar = new MyHeaderBar();
		setTitlebar(myHeaderBar);
		setIconFromFile(iconName);

		appBox = new AppBox();
		add(appBox);
		
		showAll();

	} // this()
	
		
	void quitApp(Widget widget)
	{
		string exitMessage = "Bye.";
		
		writeln(exitMessage);
		
		Main.quit();
		
	} // quitApp()

} // class TestRigWindow


class MyHeaderBar : HeaderBar
{
	bool decorationsOn = true;
	string title = "HeaderBar Demo";
	string subtitle = "complete with a full array of titlebar buttons";
	
	this()
	{
		super();
		setShowCloseButton(decorationsOn); // turns on all buttons: close, max, min
		setDecorationLayout("close:minimize,maximize,icon"); // no spaces between button IDs
		setTitle(title);
		setSubtitle(subtitle);
		
	} // this()
	
} // class MyHeaderBar


class AppBox : Box
{
	bool expand = false, fill = false;
	uint globalPadding = 10, localPadding = 5;
	// add child object and variable definitions here
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		// instantiate child objects here
		
		// packStart(<child object>, expand, fill, localPadding); // LEFT justify
		// packEnd(<child object>, expand, fill, localPadding); // RIGHT justify
		
	} // this()

} // class AppBox
