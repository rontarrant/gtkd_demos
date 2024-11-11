// button_002_04_oop_arg.d

// Example of:
// - a plain button
// - coded in the OOP paradigm
// - passing an argument to the Button's callback

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Widget;
import gtk.Button;

import gdk.Event;

void main( string[] args )
{
    TestRigWindow testRigWindow;

    Main.init( args );

    testRigWindow = new TestRigWindow();

    Main.run();

}    // main()


class TestRigWindow : MainWindow
{
    string title = "Argument Passed to Callback";
    MyButton button;

    this()
    {
        super( title );
        addOnDestroy( &quitApp );

        button = new MyButton();
        add( button );

        showAll();

    }    // this()

    void quitApp( Widget w )
    {
        string exitMessage = "Bye.";

        writeln( exitMessage );

        Main.quit();

    }    // quitApp()

}    // TestRigWindow class


class MyButton : Button
{
    string labelText = "Click This";

    this()
    {
        string message = "Next time, don't bring the Wookie.";

        super( labelText );
        addOnClicked( delegate void( _ )
                      { buttonAction( message );
                      } );

    }    // this()

    void buttonAction( string message )
    {
        writeln( "The message is: ", message );

    }    // buttonAction()

}    // MyButton class
