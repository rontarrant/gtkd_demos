// This source code is in the public domain.
/*
{
	"name": "window_01_base",
	"description": "A simple GStreamer video player",
	"authors": ["Your Name"],
	"copyright": "Copyright © 2024, Your Name",
	"license": "proprietary",
	"targetType": "executable",
	"libs": ["gstreamer-1.0", "gstreamer-base-1.0", "gobject-2.0", "glib-2.0"],
	"lflags": ["-L/usr/lib/x86_64-linux-gnu", "-lgstapp-1.0"],
	"dflags": [
		"-I/usr/include/gstreamer-1.0",
		"-I/usr/include/glib-2.0",
		"-I/usr/lib/x86_64-linux-gnu/glib-2.0/include"
	],
    "versions": ["GStreamer"]
}

*/
// OOP Test Rig Base

import std.stdio;

import gtk.MainWindow;
import gtk.Main;
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
    string title = "Test Rig";
    string byeBye = "Bye-bye";
    string message = "Hello, GtkD World.";

    this()
    {
        super( title );
        addOnDestroy( &quitApp );

        showAll();

        greeting();

    }    // this()


    void quitApp( Widget widget )
    {
        writeln( byeBye );

        Main.quit();

    }    // quitApp()


    void greeting()
    {
        writeln( message );

    }    // greeting()

}    // class TestRigWindow
