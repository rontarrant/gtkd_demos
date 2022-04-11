// This source code is in the public domain.

// To be rewritten to illustrate using TextTag's to format text.

import std.stdio;
import std.uni;
import std.conv;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.ScrolledWindow;
import gtk.TextView;
import gtk.TextBuffer;
import gtk.TextIter;
import gtk.TextTag;
import gtk.TextMark;
import gtk.c.types;

void main(string[] args)
{
	TestRigWindow testRigWindow;
	
	Main.init(args);

	testRigWindow = new TestRigWindow();
	
	Main.run();
	
} // main()


class TestRigWindow : MainWindow
{
	string title = "Textview - Simple";
	AppBox appBox;
	
	this()
	{
		super(title);
		addOnDestroy(&quitApp);
		setSizeRequest(300, 200);
		
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


class AppBox : Box
{
	bool expand = true, fill = true;
	uint globalPadding = 10, localPadding = 5;
	ScrolledTextWindow scrolledTextWindow;
	
	this()
	{
		super(Orientation.VERTICAL, globalPadding);
		
		scrolledTextWindow = new ScrolledTextWindow();
		
		packStart(scrolledTextWindow, expand, fill, localPadding); // TOP justify
		
	} // this()

} // class AppBox


class ScrolledTextWindow : ScrolledWindow
{
	MyTextView myTextView;
	
	this()
	{
		super();
		
		myTextView = new MyTextView();
		add(myTextView);
		
	} // this()
	
} // class ScrolledTextWindow


class MyTextView : TextView
{
	TextBuffer textBuffer;
	string content = "Now is the English of our discontent and in so many ways, it's just like it was before the end times got started.\n Never have I ever seen such a mess as we're dealing with now.\nMany a good boy deserves flavour.\nSouth of the Border\n";
	TextIter tagStart, tagEnd, placeholder;
	TagRange tagRange;
	TextMark[] marks;
	TextMark tempMark; // a dynamic array of TextMarks
	int markCounter = 1;
	
	this()
	{
		super();
		textBuffer = getBuffer();
		textBuffer.setText(content.toUpper); // Set all text to uppercase (we'll change this later.)
		
		// settings
		// Set the wrap mode so we know for sure that TextMarks are only happening
		// at hard line endings (Enter from the keyboard or \n in code).
		setWrapMode(GtkWrapMode.WORD);
		
		// create tags
		// GTK's color names are the same as X11's.
		textBuffer.createTag("sceneTag", "foreground", "darkblue", "pixels-above-lines", 24, "pixels-above-lines-set", true);
		textBuffer.createTag("actionTag", "pixels-above-lines", 12, "pixels-above-lines-set", true);
		
		// count paragraphs
		// get another iter for the beginning of the buffer
		textBuffer.getStartIter(placeholder);

		// step through the buffer while counting paragraphs and setting marks.
		do
		{
			// create a mark and set it to the beginning of the buffer
			tempMark = new TextMark("mark" ~ to!string(markCounter), true);
			markCounter++;
			textBuffer.addMark(tempMark, placeholder);
			
			// tag the text
			marks ~= tempMark;

			writeln("adding mark at: ", placeholder.getOffset(), " and its name is: ", tempMark.getName());
			
		} while(placeholder.forwardLine() != false); // end of buffer returns false
		
		// tag the final paragraph
		
		
		writeln("marks: ", marks, ", marks.length: ", marks.length);
		// set a mark at the end
		
		
		writeln("markCounter: ", markCounter, ", marks.length: ", marks.length);
		
		// Working except that it doesn't tag the last line in the file.
		for(ulong i = 1; i < marks.length; i++)
		{
			TextMark startMark = marks[i - 1];
			TextMark endMark = marks[i];
			writeln("i - 1: ", i - 1, ", i: ", i);

			textBuffer.getIterAtMark(tagStart, startMark);
			textBuffer.getIterAtMark(tagEnd, endMark);
			textBuffer.applyTagByName("sceneTag", tagStart, tagEnd);
		}
		
		
	} // this()


} // class MyTextView


class TextDecor
{
	TextMark start, end; // beginning and end of decorated text in the buffer
	string tagType;
	bool capsOn; // true if element is all-caps
	
	
} // class TextDecor


class TagRange
{
	TextIter start;
	TextIter end;
	
	this(TextIter rangeStart, TextIter rangeEnd)
	{
		start = rangeStart;
		end = rangeEnd;
		
		writeln("start: ", start.getOffset(), ", end: ", end.getOffset());
		
	} // this()
	
	
	TextIter getStart()
	{
		return(start);
		
	} // getStartIter()
	
	TextIter getEnd()
	{
		return(end);
		
	} // getEndIter()
	
} // class TagRange
