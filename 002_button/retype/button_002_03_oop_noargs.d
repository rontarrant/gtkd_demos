// example of:
// - a plain button
// - coded in OOP
// - with no arguments to the callback

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
    string title = "Plain Button";

    this()
    {
        super( title );
        addOnDestroy( &quitApp );

        MyButton button = new MyButton();

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
    string label = "Click This";

    this()
    {
        super( label );
        addOnClicked( &buttonAction );

    }    // this()

    void buttonAction( Button b )
    {
        string message = "An action was taken.";

        writeln( message );

    }    // buttonAction()

}    // MyButton class
