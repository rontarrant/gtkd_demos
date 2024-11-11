// This source code is in the public domain.

// using a TextTag to format text.

import std.stdio;
import std.uni;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;
import gtk.ScrolledWindow;
import gtk.TextView;    // these
import gtk.TextBuffer;
import gtk.TextIter;
import gtk.TextTag;

void main( string[] args )
{
    TestRigWindow testRigWindow;

    Main.init( args );

    testRigWindow = new TestRigWindow();

    Main.run();

}    // main()


class TestRigWindow : MainWindow
{
    string title = "Textview - Simple";
    AppBox appBox;

    this()
    {
        super( title );
        addOnDestroy( &quitApp );
        setSizeRequest( 300, 200 );

        appBox = new AppBox();
        add( appBox );

        showAll();

    }    // this()


    void quitApp( Widget widget )
    {
        string exitMessage = "Bye.";

        writeln( exitMessage );

        Main.quit();

    }    // quitApp()

}    // class TestRigWindow


class AppBox : Box
{
    bool expand = true, fill = true;
    uint globalPadding = 10, localPadding = 5;
    ScrolledTextWindow scrolledTextWindow;

    this()
    {
        super( Orientation.VERTICAL, globalPadding );

        scrolledTextWindow = new ScrolledTextWindow();

        packStart( scrolledTextWindow, expand, fill, localPadding );    // TOP justify

    }    // this()

}    // class AppBox


class ScrolledTextWindow : ScrolledWindow
{
    MyTextView myTextView;

    this()
    {
        super();

        myTextView = new MyTextView();
        add( myTextView );

    }    // this()

}    // class ScrolledTextWindow


class MyTextView : TextView
{
    TextBuffer textBuffer;
    string content = "Now is the winter of our discount tents.\nMany a good boy deserves flavour.";    // the text we'll be formatting.

    this()
    {
        super();
        textBuffer = getBuffer();
        textBuffer.setText( content.toUpper );
        TextIter bufferStart, bufferEnd;
        TextBufferRange textBufferRange;


        // create tags
        // GTK's color names are the same as X11's.
        textBuffer.createTag( "sceneTag", "foreground", "darkblue" );
        textBuffer.createTag( "actionTag" );
        textBuffer.getStartIter( bufferStart );
        textBuffer.getEndIter( bufferEnd );

        // To begin, set the range to include the entire TextBuffer.
        textBufferRange = new TextBufferRange( bufferStart, bufferEnd );

        // Decorate the text using the sceneTag.
        textBuffer.applyTagByName( "sceneTag", textBufferRange.getStart(), textBufferRange.getEnd() );
    }    // this()


}    // class MyTextView


class TextBufferRange
{
    TextIter start;
    TextIter end;

    this( TextIter rangeStart, TextIter rangeEnd )
    {
        start = rangeStart;
        end = rangeEnd;

        writeln( "start: ", start.getOffset(), ", end: ", end.getOffset() );

    }    // this()


    TextIter getStart()
    {
        return( start );

    }    // getStartIter()

    TextIter getEnd()
    {
        return( end );

    }    // getEndIter()

}    // class TextBufferRange
