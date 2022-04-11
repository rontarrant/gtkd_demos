// This source code is in the public domain.

// an implementation of the observer class in D
import std.stdio;

void main()
{
	// initialize objects
	Subject subject = new Subject();
	Observer observer1 = new Observer("First Observer...", subject);
	Observer observer2 = new Observer("Second Observer..", subject);
	
	// change state
	foreach(int i; 0..4)
	{
		writeln("\nChanging state of Subject...");
		subject.change();
		observer1.reportState();
		observer2.reportState();
	}
	
} // main()


class Observer
{
	string idString;
	bool subjectState;
	
	this(string id, Subject subject)
	{
		idString = id;
		subject.addObserver(this);
		
	} // this()
	
	
	void reactToSubjectStateChange(bool newState)
	{
		subjectState = newState;
		
	} // reactToSubjectStateChange()
	
	
	void reportState()
	{
		writeln("Viewing from ", idString, ". The subject's state is now: ", subjectState);

	} // reportState()
	
} // class Observer


class Subject
{
	bool switcherState;
	Observer[] observers;
	
	this()
	{
		switcherState = false;
		
	} // this()


	void addObserver(Observer observer)
	{
		observers ~= observer;
		observer.reactToSubjectStateChange(switcherState);
		
	} // addObserver()
	
	
	void updateAll()
	{
		foreach(observer; observers)
		{
			observer.reactToSubjectStateChange(switcherState);
			
		}
		
	} // updateAll()
	
	
	void change()
	{
		if(switcherState == true)
		{
			switcherState = false;
		}
		else
		{
			switcherState = true;
		}
		
		updateAll();
		
	} // change()

} // class Subject
