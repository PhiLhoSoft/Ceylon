// From https://www.dartlang.org/docs/synonyms/
// Based on https://www.dartlang.org/docs/synonyms/assets/dart-samples.xml and https://www.dartlang.org/docs/synonyms/assets/java-samples.xml
import ceylon.collection
{
    ArrayList,
    HashMap,
    HashSet,
    Queue,
    Stack,
    LinkedList
}
import ceylon.math.float { ... }
//import ceylon.math.float { floor, ceiling, random, pi, sin, cos }
import ceylon.language.meta { type }
import java.util.regex { Pattern, Matcher }
import ceylon.interop.java { javaString }


class Dog()
{
    shared String noise() => "BARK!";
}

void fun()
{
    String myOtherName = "Aaron";
    // [...]
    print(myOtherName);
}

void printName()
{
    String name = "Bob";
    print("Hello, ``name``");
}

void collections()
{
    List<String> aa = ArrayList();
    ArrayList<String> aal = ArrayList<String>();
    assert(aa == aal);
    ArrayList<String> al = ArrayList { elements = [ "apple", "banana", "cherry" ]; };
    Array<String> a = arrayOfSize(5, "");
    Float[] f =  [ 42.0, 2.1, 5.0, 0.1, 391.0, 0.555, +1.0e5, -5.5e-5, 1m, 2u, 3n, 4p, 5f, 1.0k, 2.0M, 3.0G, 4.0T, 5.0P ];

    al.add("orange");
    assert(al.size == 4);
    a.set(3, "foo");
    //a.set(7, "bar");
    print(a);

    Float[] sf = f.sort((Float x, Float y) => x.compare(y));
    print(sf);

    Map<String, String> mapE = HashMap();
    assert(mapE.empty);
    Map<String, String> periodic = HashMap { entries = [ "gold"->"AU", "silver"->"AG" ]; };

    assert(is HashMap<String, String> periodic); // Ensure it is mutable
    periodic.get("gold"); // AU
    periodic.put("gold", "Glitter");

    Set<String> fruits = HashSet { elements = { "oranges", "apples" }; };
    if (is HashSet<String> fruits)
    {
        fruits.add("apricots");
        fruits.add("apples");
    }
    print(fruits.size.string + " fruits");

    Queue<String> queue = LinkedList<String>();
    assert(is List<String> queue);
    queue.offer("event:32342");
    queue.offer("event:49309");

    print(queue.size);  // 2

    String? eventId = queue.accept();
    assert(exists eventId);

    print(eventId == "event:32342"); // true
    print(queue.size); // 1

    Stack<String> stack = LinkedList<String>();
    assert(is List<String> stack);
    stack.push("event:32342");
    stack.push("event:49309");

    print(stack.size);  // 2

    String? eventId2 = stack.pop();
    assert(exists eventId2);

    print(eventId2 == "event:49309"); // true
    print(stack.size); // 1
}

void strings()
{
	value rawString = """The following is not expanded to a tab \t""";

    value escapedString = "The following is not expanded to a tab \\t".normalized;

    assert(rawString == escapedString); // == true

    value name = "Aaron";
    value greeting = "My name is ``name``.";

    value greetingPolish = "My Polish name would be ``name``ski.";

    print(greeting + "; " + greetingPolish);

    // calculations can be performed in string interpolation
    //Integer top = 5;
    //element.style.top = "``top + 20``px";

    // Strings can be mult``iline
    value longMessage = "This is a very long line.
                         It is concatenated into one string.";

    // Using + also works.
    value anotherMessage = "This is also a very long line. " +
            "It is concatenated with a +.";

    print(longMessage + "; " + anotherMessage);

    print("doghouses"[3 .. 7]);
    assert("doghouses"[3 .. 7] == "house");
    assert("doghouses"[3 : 5] == "house");
    print("doghouses".replace("o", "O"));
    assert("doghouses".replace("s", "z") == "doghouzez");
    print("racecar".replaceFirst("r", "sp"));
    assert("racecar".replaceFirst("r", "sp") == "spacecar");

    String string = "
                     This is a string that spans
                     many lines.
                     ";
    print(">``string``<");

    String animals = "dogs, cats, gophers, zebras";
    value individualAnimals = animals.replace(", ", "@").split('@'.equals);
    print(individualAnimals);

    assert("racecar".startsWith("race"));
    assert(!"racecar".startsWith("pace"));
}

void controlStructures()
{
	//### Booleans

    value bugNumbers = [ 3234, 4542, 944, 124 ];
    if (bugNumbers.size > 0)
    {
        print("Not ready for release");
    }
    String status = bugNumbers.size > 0 then "RED" else "GREEN";
    print("The build is ``status``");

    String emptyString = "";

    if (emptyString.empty)
    {
        print("use empty to check for emptiness");
    }

    Integer tzero = 0;
    Integer zero = 0;

    if (zero == 0 && tzero == 0)
    {
        print("use == 0 to check zero");
    }

    String? notNull = "nn";
    String? myNull = null;

    if (exists notNull)
    {
        print("use exists to check null");
    }
    if (!is Null myNull) {} else
    {
        print("use !is Null to invert the check");
    }

    Float myNaN = 0.0 / 0;
    Float myInfinite = 1.0 / 0;

    if (myInfinite.infinite)
    {
        print("use infinite to check if a number is Infinite");
    }
    if (myNaN.undefined)
    {
        print("use undefined to check if a number is NaN");
    }

    String letterA = "A";
    String charA = String({ 65.character });

    // String defines equality as "same character codes in same order"
    assert(letterA == charA); // == true

    // However, the following is different than JavaScript
    Integer number5 = 5;
    String char5 = "5";

    assert(number5 != char5); // == true, because of different types

    // You can implement == in your own class
    class Person(String name, String ssn)
    {
        shared actual Boolean equals(Object that)
        {
        	if (is Person that)
        	{
        		return ssn == that.ssn;
        	}
    		return false;
        }
    }

    assert(Person("Bob", "111") == Person("Robert", "111"));

    //### Iterations

    value colors = [ "red", "orange", "green" ];

    for (i in 0:colors.size)
    {
        print(colors[i]);
    }

    value fruits = [ "orange", "apple", "banana" ];

    for (fruit in fruits)
    {
        print(fruit);
    }
    // We can also have the index
    for (idx->fruit in fruits.indexed)
    {
        print("``idx`` - ``fruit``");
    }

    Map<String, String> data = HashMap { entries = [ "gold"->"AU", "silver"->"AG" ]; };
    for (key->val in data)
    {
        print("``key`` - ``val``");
    }

    value callbacks = ArrayList<Anything()>();
    for (i in 0:3)
    {
        callbacks.add(void () { print(i); return; });
    }

    if (exists c = callbacks.get(0)) { c(); } // => 0
    if (exists c = callbacks.get(1)) { c(); } // => 1
}

void functions()
{
	value loudify = (String msg) => msg.uppercased;
	print(loudify("not gonna take it anymore")); // NOT GONNA TAKE IT ANYMORE

	function fn_m(Integer a, Integer b, Integer c) => c;

	//fn_m(1); // ERROR: Missing argument to required parameter b of fn (idem for c)
	print(fn_m(1, 2, 3)); // == 3

	// Ceylon specifies optional parameters by providing a default value
	function fn_o(Integer a, Integer b = -1, Integer c = -2) => c;
	print(fn_o(1)); // == -2

	String send(String msg, String rate = "First Class")
	{
		return "``msg`` was sent via ``rate``";
	}

	print(send("hello")); // == "hello was sent via First Class"
	print(send("I'm cheap", "4th class")); // == "I"m cheap was sent via 4th class"
	print(send { "I'm cheap"; rate = "4th class"; }); // == "I"m cheap was sent via 4th class"
	print(send { rate = "4th class"; msg = "I'm cheap"; }); // == "I"m cheap was sent via 4th class"

	void method(Integer mandatory, String* strings)
	{
		print(mandatory);
		for (s in strings[0:mandatory])
		{
			print(s);
		}
	}
	method(2, "a", "b", "c");
	method(10, "a", "b", "c");
}

void classes()
{
	class Person_1()
	{
		shared variable String name = "";

		shared String greet() => "Hello, ``name``";
	}
	value person_1 = Person_1();
	person_1.name = "Bob";
	print(person_1.greet());

	class Person_2(shared String name)
	{
	}
	value person_2 = Person_2("Bob");
	print(person_2.name);

	print(type(person_2));
	print(type("Bob"));

	String | Integer name = "Bob";
	assert(is String name);

	class Person_3(String name)
	{
		shared String greet() => "Hello, ``name``";
	}

	class Employee(String name, salary) extends Person_3(name)
	{
		shared variable Integer salary;
		shared void grantRaise(Float percent)
		{
			salary += (salary * percent / 100).integer;
		}
	}

	Employee e = Employee("Jack", 10000);
	e.grantRaise(10.0);
	print("``e.greet()``, your salary is now ``e.salary``");

	class Hug(strength) satisfies Summable<Hug>
	{
		shared Integer strength;

		shared actual Hug plus(Hug other) => Hug(strength + other.strength);
	}

	value hug1 = Hug(10);
	value hug2 = Hug(100);
	value bigHug = hug1 + hug2;
	print(bigHug.strength);
}

void regExesAndExceptions()
{
	String email = "test@example.com";
	// Using Java's regexes since they are not implemented / available directly in Ceylon
	Pattern pattern = Pattern.compile("""[^@]+@[\w.-]+""");
	Matcher matcher = pattern.matcher(javaString(email));
	print(matcher.matches());

	value invalidEmail = "f@il@example.com";
	Matcher imatcher = pattern.matcher(javaString(invalidEmail));
	print(imatcher.groupCount());

	if (email.empty)
	{
		throw Exception("Intruder Alert!!");
	}

	try
	{
		value v = parseInteger("three"); // Doesn't throw an exception, returns null
		value ill = 5 % 0;
		print("Never prints this - ``(v else 0) + ill``");
	}
	catch (Exception e)
	{
		print(e);
	}
	finally
	{
		print("This runs even if an exception is thrown");
	}
}

void math()
{
	print((-4).magnitude);
	print(ceiling(4.89));
	print(floor(4.89));

	// Returns a random float greater than or equal to 0.0
	// and less than 1.0
	print(random());

	// Returns a random boolean value.
	print(random() > 0.5);

	// Returns a positive random integer greater or equal
	// to 0 and less than 10
	print(floor(10 *random()));

	print(sin(pi / 2));
	print(cos(pi));

	print(parseInteger("3"));
	print(parseFloat("3.14"));
	print(parseInteger("3px"));
	print(parseInteger("three"));
}
