// This source code is in the public domain.

// Cairo: Draw a Curve

import std.stdio;
import std.conv;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gdk.Event;
import cairo.Context;
import gtk.DrawingArea;
import glib.Timeout;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Cairo: Cubic Bezier Follow Mouse";
	AppBox appBox;
	
	this()
	{
		super(title);
		setSizeRequest(640, 360);
		
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
	MyDrawingArea myDrawingArea;
	
	this()
	{
		super(Orientation.VERTICAL, 10);
		
		myDrawingArea = new MyDrawingArea();
		
		packStart(myDrawingArea, true, true, 0); // LEFT justify
		
	} // this()

} // class AppBox


class MyDrawingArea : DrawingArea
{
	Timeout _timeout;
	int fps = 1000 / 24; // 24 frames per second
	double xStart = 25, yStart = 128;
	double xEnd, yEnd;
	double controlPointY1 = 128, controlPointX2 = 25; // s/a yStart, xStart (respectively)
	double controlPointX1, controlPointY2; // will be set to yEnd, xEnd (respectively)

	this()
	{
		addOnDraw(&onDraw);
		addOnMotionNotify(&onMotion);
		
	} // this()


	public bool onMotion(Event event, Widget widget)
	{
		// make sure we're not reacting to the wrong event
		if(event.type == EventType.MOTION_NOTIFY)
		{
			// get the curve's end point
			xEnd = event.motion.x;
			yEnd = event.motion.y;
			
			// Recalculate the control points so we always have
			// a nice-looking double curve.
			controlPointX1 = xEnd;
			controlPointY1 = yStart;
			controlPointX2 = xStart;
			controlPointY2 = yEnd;
		}

		return(true);
		
	} // onMotion()

	
	bool onDraw(Scoped!Context context, Widget w)
	{
		if(_timeout is null)
		{
			_timeout = new Timeout(fps, &onFrameElapsed, false);
		}

		// set up and draw a cubic Bezier
		context.setLineWidth(3);
		context.setSourceRgb(0.3, 0.2, 0.1);
		context.moveTo(xStart, yStart);
		context.curveTo(controlPointX1, controlPointY1, controlPointX2, controlPointY2, xEnd, yEnd);
		context.stroke();

		return(true);
		
	} // onDraw()


	bool onFrameElapsed()
	{
		queueDraw();
		
		return(true);
		
	} // onFrameElapsed()
	
} // class MyDrawingArea
