import ceylon.collection { HashSet, HashMap, LinkedList }
import ceylon.io { OpenFile, newOpenFile }
import ceylon.io.buffer { ByteBuffer, newByteBuffer }
import ceylon.file { File, Path, Nil, parsePath,
	createFileIfNil }

// See Enumerated types. Must be top-level...
// Idea taken from the Java enum tutorial.
interface Planet of mercury | venus | earth | mars | jupiter | saturn | uranus | neptune  // pluton is no longer there...
{
	shared formal Float mass;
	shared formal Float diameter;
}
object mercury satisfies Planet { string => "Mercury"; mass => 3.303e+23; diameter =>  2.4397M; }
object venus   satisfies Planet { string => "Venus";   mass => 4.869e+24; diameter =>  6.0518M; }
object earth   satisfies Planet { string => "Earth";   mass => 5.976e+24; diameter =>  6.37814M; }
object mars    satisfies Planet { string => "Mars";    mass => 6.421e+23; diameter =>  3.3972M; }
object jupiter satisfies Planet { string => "Jupiter"; mass => 1.900e+27; diameter => 71.4920M; }
object saturn  satisfies Planet { string => "Saturn";  mass => 5.688e+26; diameter => 60.2680M; }
object uranus  satisfies Planet { string => "Uranus";  mass => 8.686e+25; diameter => 25.5590M; }
object neptune satisfies Planet { string => "Neptune"; mass => 1.024e+26; diameter => 24.7460M; }

doc("First steps in Ceylon")
by("Philippe Lhoste")
class FirstSteps()
{
	/*
	 The mandatory line, of course.
	 /* This call is executed as being in the body of the class' constructor.
	    /* Do you see comment nesting? */
	  */
	 */
	print("Hello World!");

	"This is a doc comment too (doc annotation is implicit here)"
	shared void exploringLiterals()
	{
		stepTitle("Exploring literals");

		title("Simple multiline string");
		// Indenting of string content is mandatory, and removed by the compiler. Newline are kept, though.
		String simple = "Simple string (multiline), with escapes\nand with Unicode literals:
		                 \{#00B6} - Numerical (hexa) - 00B6
		                 \{PILCROW SIGN} - Unicode official name - PILCROW SIGN
		                 ¶ - Literal pasted in the code";
		print(simple);

		title("String interpolation");
		void fn() // No anonymous blocks allowed, apparently, so I make a function to scope the variables
		{
			Character c = 'z';
			String s = "Foo déjà";
			Integer i = 42T; // T = tera = 1e12
			Integer b = $0100_1010; // Binary literal
			Integer h = #BABE_1BEE; // Hexadecimal literal
			Float f = 3.141_592_653_589_793_23u; // u = µ = micro = 1e-6
			print("I can embed a reference to a character ``c`` or string (``s.uppercased``)(package-level constant: ``constant``)
			       or to numbers like ``i`` or even computations: ``i * f``.
			       No formatting, though. Binary: ``b`` - Hexa: ``h``");
		}
		fn();

		title("Literal string");
		String literal = """
		                    String with no "interpolation" nor "escapes":
		                    No escape \o/ and ``no interpolation``.
		                    """.normalized; // normalized => formatting line breaks are removed
		print(literal);

		title("Literal for iterable");
		{String+} iterable = { "a", "b", "c" };
		print(iterable); // When printing it, the iterable becomes a sequence

		title("Literal for sequence");
		[String+] sequence = [ "A", "B", "C" ];
		print(sequence);
		print(sequence[1]);
		// Another notation
		String[] almostArray = [ "ichi", "ni", "san" ];
		String? probably = almostArray[2]; // String or null
		String? maybe = almostArray[10];
		// The else keyword here provides the altenative (second part) if the first part is null
		print("``maybe else "(null)"`` / ``probably else "(null)"``");

		title("Sequence of key, value pairs");
		// Using type inference (value)
		value almostMap = [ "1"->"a", "2"->"b", "3"->"c" ];
		print(almostMap);

		title("Tuple");
		// Heterogenous sequence
		value tuple = [ true, 1, 2.0, '§', "Boo", "k"->"v" ];
		print(tuple);
		print(tuple[4]);

		title("Simple, classical named function definition");
		String triple(String p) { return p + p + p; }
		print(triple("Fun "));

		title("Anonymous function");
		value funfunfun = (String p) => p + p + p;
		print(almostArray.map(funfunfun));
	}

	shared void someBaseTypes()
	{
		stepTitle("Some base types");
		// Skipping Character, String, Integer, Float seen above

		// Official name for {String+}
		Iterable<String> iterable = { "Alpha", "Beta", "Gamma", "Alpha" };
		// Official name for [String+]
		Sequence<String> sequence = [ "Harry", "Ron", "Hermione" ];
		// Official name for [String*] aka. String[]
		Sequential<String> sequential = [];
		// [String->String+]
		Sequence<Entry<String, String>> sequenceOfEntries = [ "one"->"ichi", "two"->"ni", "three"->"san", "seven"->"shichi", "seven"->"nana" ];

		// Just use them...
		title("Iterable / Sequence API");
		print("Contains: ``iterable.contains("Alpha")``");
		print("Filter: " + sequence.filter((String name) => name.startsWith("H")).string);
		print("Empty sequential: ``sequential.empty``");
		print("Collect: " + sequenceOfEntries.collect((String->String element) => element.key == "seven" then "Foo" else element.item).string);
		print("Sort: " + sequenceOfEntries.collect((String->String element) => element.item).sort(byIncreasing(identity<String>)).string);

		title("List of strings (array)");
		List<String> list = arrayOfSize { size = 5; element = "Yay!"; }; // Named parameters
		Boolean isArray = list is Array<String>;
		assert(is Array<String> list); // Narrow down the type to Array, which is mutable
		list.set(2, "Wee! \{BULLET} ``isArray``");
		print(list);

		title("List of strings (linked list)");
		List<String> llist = LinkedList(sequence);
		print(llist);

		title("Set of strings (from iterable)");
		Set<String> set = HashSet { elements = iterable; };
		print(set);
		print(set.contains("alpha"));

		title("Map of strings to strings (from sequence)");
		Map<String, String> map = HashMap { entries = sequenceOfEntries; };
		print(map);
		print(map["seven"]);

		title("Range of characters");
		Range<Character> rc = 'a'..'z';
		print(rc);
		print("x in range? ``'x' in rc``");

		title("Segment of characters");
		Character[] sc = 'A':26;
		print(sc);
		print("X in segment? ``'X' in sc``");
	}

	shared void simpleControls()
	{
		stepTitle("Simple controls: conditionals and loops");

		title("Source of bugs");
		variable Boolean b = false;
		if (b = true) // Ouch, Ceylon allows this too... :-( Newbies write if (a == true) and often forget the second =...
		{
			print("Ouch!");
		}

		title("Simple if");
		Integer a = 42;
		if (a == 6 * 7)
		{
			print("Math is awesome!");
		}

		title("Simple for");
		for (n in 39..a)
		{
			print("Loooooping... ``n``");
		}
		// Can be explicit on type and in reversed order
		for (Integer n in 45..a)
		{
			print("Unloooping... ``n``");
		}
		// Can have an else clause
		else
		{
			print("Finished the loop without interruption");
		}
		for (n in 39:3)
		{
			print("Looping again... ``n``");
		}

		title("for each with index");
		value jNumbers = [ "ichi", "ni", "san", "shi", "go", "roku", "shichi" ];
		for (idx->jn in jNumbers.indexed)
		{
			print("Counting: ``idx + 1`` is ``jn``");
		}

		title("Zip this");
		value eNumbers = [ "one", "two", "three", "four", "five", "six", "seven" ];
		for (en->jn in zipEntries(eNumbers, jNumbers))
		{
			print("``en`` --> ``jn``");
		}

		title("Meanwhile... let's switch the lights");
		variable Integer n = 0;
		variable [Integer*] seq = [];
		while (n < 5)
		{
			switch (n)
			case (0) { print("Zero"); }
			case (1) { print("One"); }
			case (2) { print("Two"); }
			case (3) { print("Three"); }
			else { print("A lot"); }

			seq = seq.withTrailing(n++);
		}
		print(seq);

		title("Trying hard!");
		try
		{
			print("Before");
			if (n > 1)
			{
				throw Exception { description = "Too big!"; cause = null; };
			}
			print("After");
		}
		catch (e)
		{
			print(e.message);
		}
		finally
		{
			print("Shown whatever the result");
		}
	}

	shared void functions()
	{
		stepTitle("Functions");

		title("Defining a simple function");
		// Mandatory parameters called by position
		String simple(String s, Integer i, Float f)
		{
			return "``s`` / ``i`` / ``f``";
		}
		print(simple("Some numbers", 42, 3.1415926));
		// We can already use the parameters by name, in any order. Notice the usage of semi-colon as separator.
		print(simple { f = 3.1415926; i = 42; s = "Same numbers"; });

		title("Optional parameters with defaults and varargs");
		String options(Integer perhapsI = 3333, String maybeS = "not provided", Integer* someI)
		{
			return "``perhapsI`` / ``maybeS`` / ``someI``";
		}
		print(options());
		print(options(1));
		print(options(2, "Foo"));
		print(options(3, "Bar", 44));
		print(options(4, "Baz", 3, 14, 15, 926));
		print(options { someI = [ 5, 7, 11 ]; maybeS = "Provided"; });

		title("Fat arrow for expressions");
		String(Integer) faA = (Integer v) => "Value A[``v``]";
		String(Integer) faB = (Integer v) => "Value B{``v``}";
		// Infered type
		function faC(Integer v) => "Value C<``v``>";
		// Infered in a variable
		value faD = (Integer v) => "Value D/``v``\\";

		String caller(Integer v, String(Integer) f) => f(v);

		print([ faA(11), faB(121), faC(12321), faD(1235321) ]);
		print(caller(22, faA));
		print(caller(33, faB));
		print(caller(55, faC));
		print(caller(77, faD));
	}

	shared void declaringTypes()
	{
		stepTitle("Declaring types");

		title("Simple class declaration");
		class Concrete(String name, Integer count)
		{
			// A public variable
			shared String weight = "``count`` kg";
			// A void method
			shared void showName() { print(name); }
			// Shortcut method notation; default means "can be overridden"
			shared default Integer getValue() => count * name.size;
		}
		value concrete = Concrete("You rock", 10);
		print(concrete);
		concrete.showName();
		print("Value: ``concrete.getValue()`` with weight of ``concrete.weight``");

		title("Simple interface declaration and usage");
		// Don't try to find a meaning to the following mindless code!
		interface BluePrint
		{
			// formal = to be defined (abstract)
			shared formal void doPrint(Integer v);
			// A method in an interface can have an implementation (but not state)
			shared String getColor() => "#0000FF"; // Blue, of course
		}
		interface BlueFish
		{
			// Looks like a variable, but is actually an accessor
			shared formal Boolean isOK;
		}
		class Printer(String pathToPrinter) extends Concrete(pathToPrinter, 42) satisfies BluePrint
		{
			// actual = provides an implementation (@Override)
			shared actual void doPrint(Integer v) { showName(); }
			// Here, actually = override existing implementation
			shared actual Integer getValue() => getColor().size * super.getValue();

			// Refine the field defined in Object (corresponds to toString)
			string => "Printer{``pathToPrinter``}";
		}
		class Bluish(shared Integer hue) satisfies BluePrint
		{
			shared actual void doPrint(Integer v) { print("Indigo #``v``"); }
		}
		value bluish = Bluish(123);
		bluish.doPrint(bluish.hue);

		title("Algebraic types: union (or)");
		Printer | Bluish maybeBlue = Printer("/path/to/printer");
		maybeBlue.doPrint(11011);
		if (is Printer maybeBlue)
		{
			print("Value is ``maybeBlue.getValue()`` with object ``maybeBlue``");
		}
		// More realistic (?)
		String | Integer someValue(Printer | Bluish pOrB)
		{
			if (is Printer pOrB)
			{
				return pOrB.getValue(); // We know for sure that pOrB is a Printer, we return an Integer
			}
			return pOrB.getColor(); // It is necessarily a Bluish, we return a String
		}
		// Calling a package-level function
		printValue(someValue(bluish));
		printValue(someValue(maybeBlue));

		title("Algebraic types: intersection (and)");
		// Printer & Bluish pb; // Legal, but is actually a Nothing, we can't do anything with it!

		class IndigoPrinter(Boolean b) satisfies BluePrint & BlueFish
		{
			shared actual void doPrint(Integer v) { print(b then v else 31415); }

			shared actual Boolean isOK = b;
		}
		BluePrint & BlueFish indigoPrinter = IndigoPrinter(true);
		value printerIndigo = IndigoPrinter(false);
		indigoPrinter.doPrint(42);
		printerIndigo.doPrint(42);
		print("One is ``indigoPrinter.isOK`` while the other is ``printerIndigo.isOK``");
		print("One is ``indigoPrinter.getColor()`` while the other is also ``printerIndigo.getColor()``");

		title("Type alias");
		interface MapSI => Map<String, Integer>;
		variable MapSI mapsi = HashMap { entries = [ "One"->1, "Two"->2 ]; };
		print(mapsi);

		alias Primitive => Float | Integer | Boolean | String;
		Primitive convert(String representation) // Inspired by Renato Athaydes' articles
		{
			return parseBoolean(representation) else parseInteger(representation) else parseFloat(representation) else representation;
		}
		void show(Primitive p)
		{
			// Switch on type
			switch (p)
			case (is Float)   { print("Float: ``p``"); }
			case (is Integer) { print("Integer: ``p``"); }
			case (is Boolean) { print("Boolean: ``p``"); }
			case (is String)  { print("String: ``p``"); }
		}
		show(convert("3.14"));
		show(convert("42"));
		show(convert("true"));
		show(convert("whatever"));

		title("Enumerated types");
		Boolean? isBig(Planet p)
		{
			// Switch on enumerated type
			switch (p)
			case (mercury, mars) { return false; }
			case (jupiter, uranus) { return true; }
			else { return null; }
		}
		void checkSize(Planet p)
		{
			Boolean? big = isBig(p);
			String diam = "diameter = ``p.diameter``";
			if (exists big)
			{
				if (big) { print("``p`` is big - ``diam``"); }
				else { print("``p`` is rather small - ``diam``"); }
			}
			else
			{
				print("So so for ``p`` - ``diam``");
			}
		}
		checkSize(mars);
		checkSize(uranus);
		checkSize(earth);
	}

	shared void accessors()
	{
		stepTitle("Accessors");

		void before()
		{
			class Exposure(arg, String? opt = null) // A mandatory argument, an optional one
			{
				// We expose all the attributes (members); they are 'public'!
				shared String arg; // Recommended way to declare a class argument as shared
				// Immutable attribute depending on argument
				shared String val = "Value " + arg.reversed.string;
				// Variable attribute, with initial value
				shared variable Integer count = val.size;

				// Immutable field (value at object creation time)
				shared Integer dynamicValue = count * system.milliseconds;

				// Not visible from outside
				variable String internal; // Defered evaluation, done in the body of the class (equivalent to constructor's code)
				if (exists opt) // Not null (can be done in a simpler way, it just illustrtates the point above
				{
					internal = arg + opt + " -> " + count.string;
				}
				else
				{
					internal = arg + " -> " + count.string;
				}

				shared void showMeaningfulInformation()
				{
					print("Parameter was ``arg``, secret information is ``internal``");
				}
			}

			value exp = Exposure("Public");
			print("Exposure: arg=``exp.arg`` / val=``exp.val`` / count=``exp.count.string`` / dynamicValue=``exp.dynamicValue.string``");
			exp.showMeaningfulInformation();
			exp.count = 1;
			print("Exposure: arg=``exp.arg`` / val=``exp.val`` / count=``exp.count.string`` / dynamicValue=``exp.dynamicValue.string``");
			exp.showMeaningfulInformation();
			Exposure("Other", " with option").showMeaningfulInformation();
		}

		void after()
		{
			class Exposure(arg, String? opt = null)
			{
				shared String arg;
				shared String val = "Value " + arg.reversed.string;
				// We change the implementation, and leave unchanged the calling code
				variable Float newCount = 24.0 * arg.size / val.size;
				// Getter
				shared Integer count => newCount.integer;
				// Setter
				assign count
				{
					newCount = count.float;
				}

				// This value is now a getter, and gets fresh information on each call
				shared Integer dynamicValue => count * system.milliseconds;

				// Here, just use the terse way...
				variable String internal = arg + (opt else "") + " -> " + count.string;

				shared void showMeaningfulInformation()
				{
					print("Parameter was ``arg``, secret information is ``internal``");
				}
			}

			value exp = Exposure("Public");
			print("Exposure: arg=``exp.arg`` / val=``exp.val`` / count=``exp.count.string`` / dynamicValue=``exp.dynamicValue.string``");
			exp.showMeaningfulInformation();
			exp.count = 1;
			print("Exposure: arg=``exp.arg`` / val=``exp.val`` / count=``exp.count.string`` / dynamicValue=``exp.dynamicValue.string``");
			exp.showMeaningfulInformation();
			Exposure("Other", " with option").showMeaningfulInformation();
		}

		before();
		print("");
		after();
	}

	shared void namedArguments()
	{
		stepTitle("Named arguments");

		// Let's make a function with several arguments
		void doStuff(Integer number, String name, {String*} items)
		{
			print("``number`` - ``name`` with ``items``");
		}
		doStuff(0, "zero", {});
		doStuff(5, "five", [ "1", "2", "3", "4", "5" ]);
		doStuff { name = "three"; items = [ "3", "4", "5" ]; number = 314; };
	}

	shared void usingIO()
	{
		stepTitle("Using I/O");
		// http://modules.ceylon-lang.org/modules/ceylon.file/1.1.0/doc

		"Reads all lines from a file reader and returns them as a string."
		String readAllLines(File.Reader reader)
		{
			StringBuilder result = StringBuilder();

			while (exists line = reader.readLine())
			{
				result.append(line).append("\n");
			}

			return result.string;
		}

		Path projectPath = parsePath(".");
		print(projectPath.absolutePath.string);

		Path projectFilePath = projectPath.childPath(".project");
		Path classFilePath = projectFilePath.siblingPath(".classpath");
		assert(projectPath == classFilePath.parent);
		value inputResource = projectFilePath.resource;
		variable value lines = "";
		if (is File inputResource)
		{
			try (reader = inputResource.Reader())
			{
				lines = readAllLines(reader);
			}
		}
		Path outputPath = parsePath("./output.txt");
		// See below's createFileIfNil
		//if (is Nil resource = outputPath.resource)
		//{
		//	resource.createFile();
		//}
		if (is File | Nil outputResource = outputPath.resource)
		{
			value outputFile = createFileIfNil(outputResource);

			try (writer = outputFile.Overwriter())
			{
				writer.writeLine(lines.uppercased);
			}
		}

		OpenFile openFile = newOpenFile(outputPath.resource);
		ByteBuffer buffer = newByteBuffer(4096);
		Integer readNb = openFile.read(buffer);
		print("Has read ``readNb`` bytes from ``projectFilePath.absolutePath``");
		buffer.flip();
		value byteSequence = buffer.sequence();
		value changedBuffer = newByteBuffer(byteSequence.size);
		for (byte in byteSequence.reversed)
		{
			changedBuffer.putByte(byte);
		}
//		openFile.position
		changedBuffer.flip();
		openFile.position = 0;
		Integer writeNb = openFile.write(changedBuffer);
		print("Has written ``writeNb`` bytes to ``outputPath.absolutePath``");
		openFile.close();
	}
}
