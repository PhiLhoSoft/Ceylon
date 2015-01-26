import ceylon.collection { LinkedList, ArrayList }

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
	variable LinkedList<String> lls = LinkedList([ "Foo", "Bar", "Baz" ]);
	value transforming = mutating;
	transforming(n, lls);
	print("Changing value: ``n`` and list: ``lls``");

	class Parent(shared String name) { string => name; }
	class Child(String name) extends Parent(name) {}
	variable LinkedList<Parent> llp = LinkedList([ Parent("Foo"), Parent("Bar"), Parent("Baz") ]);
	llp.add(Child("Moo"));
	print(llp);

	String? possible = "Yeah";
	enabling(possible); // The assert inside doesn't validate here
	String sure = "Hey " + (possible else "Bah");
	print(sure);

	List<String> nl = [ "foo", "bar" ];
	print(nl.size);
	ArrayList<String> | LinkedList<String> dualList = ArrayList { elements = { "Foo", "Bar" }; };
	print(dualList.size);
	print("Size of ArrayList | LinkedList: ``dualList.size``");
	Boolean isAL = dualList is ArrayList<String>;
	if (is ArrayList<String> dualList)
	{
		Integer capacity = dualList.capacity;
		print("ArrayList? ``isAL`` -> capacity: ``capacity``");
	}
	class Neg(Integer n) satisfies Invertible<Neg>
	{
		shared actual Neg negated => Neg(-n);

		shared actual Neg plus(Neg other) => Neg(other.n + n);

		string => n.string;
	}
	Neg(Neg) f;
	f=(Neg p)=>-p;
	Neg neg = Neg(42);
	print("Negation: ``-neg`` / Addition: ``neg + neg`` / Subtraction: ``neg - -neg``");

	Integer ni = 42;
	Float nf = -52.0;
	print("``ni.sign`` / ``nf.sign``");
	Integer | Float nif = -314;
	assert(is Integer nif);
	print("Sign of Integer | Float: ``nif.sign``");

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
