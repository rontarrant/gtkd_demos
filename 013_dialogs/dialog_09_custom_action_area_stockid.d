// This source code is in the public domain.

// Custom Action Area with StockID

import std.stdio;

import gtk.MainWindow;
import gtk.Window;
import gtk.Main;
import gtk.Box;
import gtk.Button;
import gtk.Dialog;
import gtk.c.types;
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
	string title = "Custom Action Area with StockID";
	
	AppBox appBox;
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		
		appBox = new AppBox(this);
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
	DialogButton dialogButton;
	
	this(Window parentWindow)
	{
		super(Orientation.VERTICAL, 10);
		
		dialogButton = new DialogButton(parentWindow);
		
		packStart(dialogButton, false, false, 0);
		
	} // this()

} // class AppBox


class DialogButton : Button
{
	private:
	string labelText = "Open a Dialog";
	
	StockButtonDialog scratchDialog;
	Window _parentWindow;
	
	public:
	this(Window parentWindow)
	{
		super(labelText);
		addOnClicked(&doSomething);
		_parentWindow = parentWindow;
		
	} // this()
	
	
	void doSomething(Button b)
	{
		scratchDialog = new StockButtonDialog(_parentWindow);
		
	} // doSomething()

} // class: DialogButton


class StockButtonDialog : Dialog
{
	GtkDialogFlags flags = GtkDialogFlags.MODAL;
	MessageType messageType = MessageType.INFO;
	StockID[] stockIDs = [StockID.CONNECT, StockID.DISCONNECT];
	ResponseType[] responseTypes = [ResponseType.YES, ResponseType.NO];
	string titleText = "Connect or disconnect?";

	
	this(Window _parentWindow)
	{
		super(titleText, _parentWindow, flags, stockIDs, responseTypes);
		addOnResponse(&doSomething);
		run();
		destroy();
		
	} // this()

	
	void doSomething(int response, Dialog d)
	{
		switch(response)
		{
			case ResponseType.YES:
				writeln("Connecting...");
			break;
			
			case ResponseType.NO:
				writeln("Disconnecting...");
			break;
			
			default:
				writeln("Dialog closed.");
			break;
		}
		
	} // doSomething()
	
} // class StockButtonDialog
