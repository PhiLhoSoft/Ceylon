import ceylon.collection { LinkedList }

shared void experiments()
{
	/* Foo /* And more /* (Nested comments) */ */ Bar */

	void mutating(variable Integer n, variable LinkedList<String> ll) { n += 4; ll.set(1, "Yo"); }
	void enabling(String? maybe)
	{
		assert(exists maybe);
		print(maybe);
	}

	variable Integer n = 5;
	variable LinkedList<String> l = LinkedList([ "Foo", "Bar", "Baz" ]);
	value transforming = mutating;
	transforming(n, l);
	print(n);
	print(l);

	String? possible = "Yeah";
	enabling(possible); // The assert inside doesn't validate here
	String sure = "Hey " + (possible else "Bah");
	print(sure);

	// Can we have an interface member not shared?
	interface HiddingStuff
	{
		// Variables (and values) must be shared because they *must* be refined (defined, actually).
		// They cannot be assigned values (no constants in interfaces).
		shared formal variable Integer c;
		shared formal String name;
		// A member can be private and not formal, actually
		void incr() { c++; }
		shared Integer counter() { incr(); return c; }
	}
	class Stuff() satisfies HiddingStuff
	{
		shared actual variable Integer c = 0;
		shared actual String name = "S-";

		string => name + counter().string;
	}
	Stuff s = Stuff();
	print("``s`` ``s`` ``s`` ``s``");

	class ℤℇÅℜ()
	{
		shared void ℏⅇℒℲ() => print("Silly");
	}
	ℤℇÅℜ().ℏⅇℒℲ();

	assert(1_000_000_000_000 == 1T);

	String double(String p) => p + " / " + p;
	value evaluated = "Some `` double("zou ``double("zip")`` bang") `` String";
	print(evaluated);

	class FlowBased()
	{
		variable String? notDefinedYet = null;

		shared void doStuff()
		{
			notDefinedYet = "Now it is defined";
			doMoreStuff();
		}

		void doMoreStuff()
		{
			if (exists ndy = notDefinedYet)
			{
				print(ndy + "!");
			}
		}
	}
	FlowBased().doStuff();
}
