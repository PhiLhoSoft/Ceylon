import ceylon.collection { LinkedList, ArrayList,
	MutableList }

shared Integer theNumber = 42;

shared void experiments()
{
	/* Foo /* And more /* (Nested comments) */ */ Bar */

	void mutating(variable Integer n, variable LinkedList<String> ll) { n += 4; ll.set(1, "Yo"); }
	void enabling(String? maybe)
	{
		assert(exists maybe);
		print(maybe);
	}

	Anything any = "Anything!";
	if (is String any)
	{
		print(any);
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
	hidingInInterface();

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

	hidingInInterface();

	fizzBuzz();

	demeter();
}

void hidingInInterface()
{
	print("## Hiding stuff in an interface ##");
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
}

void fizzBuzz()
{
	print("## FizzBuzz 1 ##");
	Iterable<String> fizzBuzz1(Integer count = 20)
	{
		return (1 .. count).map((Integer c) =>
			15.divides(c) then "FizzBuzz" else
			(3.divides(c) then "Fizz" else
			(5.divides(c) then "Buzz" else c.string)));
	}
	for (p in fizzBuzz1(50).partition(5)) { print(p); }

	print("## FizzBuzz 2 ##");
	Iterable<String> fizzBuzz2(Integer count = 20)
	{
		return (1 .. count).map(
			function (Integer c)
			{
				value f = 3.divides(c);
				value b = 5.divides(c);
				return
					"``f then "Fizz" else ""``
					 ``b then "Buzz" else ""``
					 ``!f && !b then c else ""``"
					.replace("\n", ""); // Because I break down the string for readability
				/*
				return
				"``f then "Fizz" else ""``\
				 ``b then "Buzz" else ""``\
				  ``!f && !b then c else ""``";
				*/
			});
	}
	for (p in fizzBuzz2(50).partition(5)) { print(p); }
}

void demeter()
{
	print("## Demeter ##");
	class Delegate() satisfies List<String>//, MutableList<String>
	{
		List<String> list = ArrayList<String>();

//		shared actual String? getFromFirst(Integer index) => list.getFromFirst(index);
//		shared actual Integer? lastIndex => list.lastIndex;
		getFromFirst = list.getFromFirst;
		lastIndex = list.lastIndex;
//		size = list.size;

		shared void add(String s) { assert(is MutableList<String> list); list.add(s); }
		//shared actual Integer size { assert(is MutableList<String> lst = list); return lst.size; }
		shared actual Integer size { assert(is MutableList<String> list); return list.size; }

		shared actual Boolean equals(Object that)
		{
			if (is Delegate that)
			{
				return list == that.list;
			}
			return false;
		}
		shared actual Integer hash
		{
			return list.hash;
		}
	}
	value d = Delegate();
	d.add("Foo");
	d.add("Bar");
	print("``d.size`` ``d[1] else "null"``");
}
