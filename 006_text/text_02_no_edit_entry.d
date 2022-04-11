// This source code is in the public domain.

// Entry widget with Editable turned on and off

import std.stdio;

import gtk.Main;
import gtk.MainWindow;
import gtk.Entry;
import gtk.Button;
import gtk.Widget;
import gtk.Box;
import gtk.CheckButton;
import gtk.ToggleButton;                // *** NOTE *** needed for toggle signal

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string titleText = "Entry Editable/Non-editable";
	EntryBox entryBox;
		
	this()
	{
		super(titleText);
		addOnDestroy(&endProgram);
		
		entryBox = new EntryBox();
		add(entryBox);

		showAll();
				
	} // this()
	
	
	void endProgram(Widget w)
	{
		writeln("The text entry box holds: ", entryBox.entry.getText());
		
	} // endProgram()
	
} // class TestRigWindow


class EntryBox : Box
{
	int globalPadding = 5;
	Entry entry;
	CheckButton checkButton;
	string checkText = "Editable";
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		entry = new Entry();
		entry.setEditable(false);
		
		checkButton = new CheckButton(checkText);
		checkButton.addOnToggled(&entryEditable);
		checkButton.setActive(false);
				
		add(entry);
		add(checkButton);
		
	} // this()
	
	
	void entryEditable(ToggleButton button)
	{
		entry.setEditable(button.getActive());
		
		if(button.getActive() == true)
		{
			writeln(checkText);
		}
		else
		{
			writeln("Not ", checkText);
		}
		
	} // entryEditable()

} // class EntryBox
