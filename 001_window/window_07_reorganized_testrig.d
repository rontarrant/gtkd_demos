// This source code is in the public domain.

// Reorganized Test Rig

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
import gtk.Box;
import gtk.Widget;

void main( string[] args )
{
    TestRigWindow testRigWindow;

    Main.init( args );

    testRigWindow = new TestRigWindow();

    Main.run();

}    // main()


class TestRigWindow : MainWindow
{
    string title = "<Insert Title>";
    AppBox appBox;

    this()
    {
        super( title );
        addOnDestroy( &quitApp );

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
    bool expand = false, fill = false;
    uint globalPadding = 10, localPadding = 5;
    // add child object and variable definitions here

    this()
    {
        super( Orientation.VERTICAL, globalPadding );

        // instantiate child objects here

        // packStart(<child object>, expand, fill, localPadding); // LEFT justify
        // packEnd(<child object>, expand, fill, localPadding); // RIGHT justify

    }    // this()

}    // class AppBox
