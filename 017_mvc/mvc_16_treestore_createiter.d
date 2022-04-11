// This source code is in the public domain.

// MVC - a TreeStore example with a single parent and single child in the model,
// populated using createIter().

import std.stdio;
import std.string;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Box;
import gtk.ScrolledWindow;
import gtk.TreeView;
import gtk.TreeStore;
import gtk.TreeIter;
import gtk.TreeViewColumn;
import gtk.CellRendererText;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);
    
	testRigWindow = new TestRigWindow();
	 
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "TreeStore (createIter)";
	AppBox appBox;
	int minimumWidth, naturalWidth, minimumHeight, naturalHeight;
	
	this()
	{
		super(title);
		setSizeRequest(300, 200);
		
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
	MyScrolledWindow myScrolledWindow;
	
	this()
	{
		super(Orientation.VERTICAL, 10);

		myScrolledWindow = new MyScrolledWindow();
		packStart(myScrolledWindow, true, true, 0);
		
	} // this()

} // class AppBox


class MyScrolledWindow : ScrolledWindow
{
	DemoTreeView demoTreeView;
	
	this()
	{
		demoTreeView = new DemoTreeView();
		super();
		add(demoTreeView);
		
	} // this()
	
} // class MyScrolledWindow


class DemoTreeView : TreeView
{
	DemoTreeStore demoTreeStore;
	ParentColumn parentColumn;
	ChildColumn childColumn;
	
	this()
	{
		super();

		demoTreeStore = new DemoTreeStore();
		setModel(demoTreeStore);

		parentColumn = new ParentColumn();
		appendColumn(parentColumn);

		childColumn = new ChildColumn();
		appendColumn(childColumn);
		
	} // this()

} // class DemoTreeView


class ParentColumn : TreeViewColumn
{
	CellRendererText cellRendererText;
	string columnTitle = "Parent Column";
	string attributeType = "text";
	int columnNumber = 0; 
	
	this()
	{
		cellRendererText = new CellRendererText();
		super(columnTitle, cellRendererText, attributeType, columnNumber);
		
	} // this()
	
} // class ParentColumn


class ChildColumn : TreeViewColumn
{
	private:
	CellRendererText cellRendererText;
	string columnTitle = "Child Column";
	string attributeType = "text";
	int columnNumber = 1; 
	
	public:
	this()
	{
		cellRendererText = new CellRendererText();
		super(columnTitle, cellRendererText, attributeType, columnNumber);
		
	} // this()
	
} // class ChildColumn

 
class DemoTreeStore : TreeStore
{
	TreeIter parentIter, childIter;
	string parentRowString = "Parent";
	string childRowString = "Child";
	 
	this()
	{
		super([GType.STRING, GType.STRING]);

		parentIter = createIter(); // append an empty row to the top level and get an iter back
		setValue(parentIter, 0, parentRowString);

		childIter = createIter(parentIter); // passing in parentIter makes this a child row
		setValue(childIter, 1, childRowString);
		
	} // this()
	
} // class DemoTreeStore
