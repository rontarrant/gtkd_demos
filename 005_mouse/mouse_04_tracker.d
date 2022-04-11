// This source code is in the public domain.

// hook up the onMotion signal and have it report its position within the window

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;
import gdk.Event;

// Note: EventType flags are found in gtk.c.types

void main(string[] args)
{
	// initialization & creation
	Main.init(args);

	TestRigWindow testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Mouse Motion";
	
	this()
	{
		super(title);
		addOnDestroy(delegate void(Widget w) { quitApp(); } );
		
		// make the callback sensitive to mouse movement
		addOnMotionNotify(&onMotion);
		
		showAll();
		
	} // this()


	void quitApp()
	{
		string byeBye = "Good-bye";

		writeln(byeBye);
		
		Main.quit();

	} // quitApp()


	public bool onMotion(Event event, Widget widget)
	{
		// make sure we're not reacting to the wrong event
		if(event.type == EventType.MOTION_NOTIFY)
		{
			writeln("x = ", event.motion.x, " y = ", event.motion.y);
		}

		return(true);
		
	} // onMotion()

} // class TestRigWindow
