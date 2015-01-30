
shared Integer \iELEMENT_NODE = 1;
deprecated shared Integer \iATTRIBUTE_NODE = 2;
shared Integer \iTEXT_NODE = 3;
deprecated shared Integer \iCDATA_SECTION_NODE = 4;
deprecated shared Integer \iENTITY_REFERENCE_NODE = 5;
deprecated shared Integer \iENTITY_NODE = 6;
shared Integer \iPROCESSING_INSTRUCTION_NODE = 7;
shared Integer \iCOMMENT_NODE = 8;
shared Integer \iDOCUMENT_NODE = 9;
shared Integer \iDOCUMENT_TYPE_NODE = 10;
shared Integer \iDOCUMENT_FRAGMENT_NODE = 11;
deprecated shared Integer \iNOTATION_NODE = 12;

"See [[Node.compareDocumentPosition]]. Bit set when node and other are not in the same tree."
shared Integer \iDOCUMENT_POSITION_DISCONNECTED            = $00_0001; // 1
"See [[Node.compareDocumentPosition]]. Bit set when other is preceding node."
shared Integer \iDOCUMENT_POSITION_PRECEDING               = $00_0010; // 2
"See [[Node.compareDocumentPosition]]. Bit set when other is following node."
shared Integer \iDOCUMENT_POSITION_FOLLOWING               = $00_0100; // 4
"See [[Node.compareDocumentPosition]]. Bit set when other is an ancestor of node."
shared Integer \iDOCUMENT_POSITION_CONTAINS                = $00_1000; // 8
"See [[Node.compareDocumentPosition]]. Bit set when other is a descendant of node."
shared Integer \iDOCUMENT_POSITION_CONTAINED_BY            = $01_0000; // 16
"See [[Node.compareDocumentPosition]]."
shared Integer \iDOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC = $10_0000; // 32

"Node is an abstract interface and does not exist as node.
 It is used by all nodes ([[Document]], DocumentFragment, DocumentType, [[Element]], Text, ProcessingInstruction, and Comment). "
shared dynamic Node satisfies EventTarget
{
	"Base URL, ie. the protocol, the domain name and the directory structure of the page, that is all until the last '/'."
	shared formal String baseURI;

	"Live list containing all the children of this node.
	 [[NodeList]] being live means that if the children of the [[Node]] change, the NodeList object is automatically updated."
	shared formal NodeList childNodes;

	"First direct child node of the node, or null if the node has no child."
	shared formal Node? firstChild;

	"Last direct child node of the node, or null if the node has no child."
	shared formal Node? lastChild;

	"Previous node in the tree, or null if there isn't such node."
	shared formal Node? previousSibling;

	"Next node in the tree, or null if there isn't such node."
	shared formal Node? nextSibling;


	"""Name of the node, like "audio", "#text" or "#document"."""
	shared formal String nodeName;

	"Type of the node, like [[ELEMENT_NODE]] and similar."
	shared formal Integer nodeType;

	"Value of the node. null for most nodes, except nodes of type [[TEXT_NODE]] (Text objects), [[COMMENT_NODE]] (Comment objects),
	 and [[PROCESSING_INSTRUCTION_NODE]] (ProcessingInstruction objects), where the value corresponds to the text data contained in the object."
	shared formal variable String? nodeValue;

	"Textual content of an element and all its descendants."
	shared formal variable String? textContent;


	"The Document that this node belongs to. Null if no document is associated with it."
	shared formal Document? ownerDocument;

	"Parent node of this node. Null if there is no such node, like if this node is the top of the tree or if it doesn't participate in a tree."
	shared formal Node? parentNode;

	"Parent element of this node. Null if the node has no parent, or if that parent is not an [[Element]]."
	shared formal Element? parentElement;


	"Indicates if the element has any child nodes, or not."
	shared formal Boolean hasChildNodes();

	"Insert a [[Node]] as the last child node of this element."
	shared formal Node appendChild(Node newChild);

	"Removes a child node from the current element, which must be a child of the current node."
	shared formal Node removeChild(Node oldChild);

	"Replaces one child Node of the current one with the second one given in parameter."
	shared formal Node replaceChild(Node newChild, Node oldChild);

	"Inserts the first [[Node]] given in a parameter immediately before the second, child of this element, Node."
	shared formal Node insertBefore(Node newChild, Node? referenceChild = null);

	"Clone a [[Node]], and optionally, all of its contents. By default, it clones the content of the node."
	shared formal Node cloneNode(Boolean deep = false);

	"Returns a bitmask indicating the position of [[other]] relative to this node. See constants [[DOCUMENT_POSITION_DISCONNECTED]] and similar."
	shared formal Integer compareDocumentPosition(Node other);

	"Returns true if [[other]] is an inclusive descendant of this node, and false otherwise. "
	shared formal Boolean contains(Node other);

	"Returns whether this node and [[other]] have the same properties. "
	shared formal Boolean isEqualNode(Node other);

	"Removes empty [[Text]] nodes and concatenates the data of remaining contiguous Text nodes into the first of their nodes. "
	shared formal void normalize();

	""
	shared formal Boolean isDefaultNamespace(String namespaceURI);

	""
	shared formal String lookupPrefix(String namespaceURI);

	""
	shared formal String lookupNamespaceURI(String prefix);
}


"NodeList can be live (eg. from [[Node.childNodes]]) or static (from document.querySelectorAll for example)"
//shared dynamic NodeList satisfies Correspondence<Integer, Node> // Cannot use nodes[i], apparently
shared dynamic NodeList satisfies JSList<Node>
{
}

shared dynamic HTMLCollection satisfies JSList<Element>
{
	shared formal Element? namedItem(String name);
}

shared dynamic DOMImplementation
{

}

// https://developer.mozilla.org/en-US/docs/Web/API/Document
"Each web page loaded in the browser has its own document object.
 The IDocument interface serves as an entry point into the web page's content
 (the DOM tree, including elements such as &lt;body> and &lt;table>)
 and provides functionality which is global to the document
 (such as obtaining the page's URL and creating new elements in the document)."
shared dynamic Document satisfies Node, GlobalEventHandlers
{
	"Document Type Definition (DTD) of the current document."
	shared formal String? doctype; // Or DocumentType?

	"Element that is a direct child of the document. For HTML documents, this is normally the HTML element."
	shared formal Element? documentElement;

	"URL of the Document."
	shared formal String documentURI;

	"DOM implementation associated with the current document."
	shared formal DOMImplementation implementation;

	// Style sheet extension

	"Returns a list of the style sheet objects on the current document."
	shared formal StyleSheetList styleSheets;

	"Which style sheet set is currently in use."
	shared formal variable String? selectedStyleSheetSet;

	"Name of the style sheet set that was last enabled.
	 Has the value null until the style sheet is changed by setting the value of [[selectedStyleSheetSet]]."
	shared formal String? lastStyleSheetSet;

	"Preferred style sheet set as specified by the page author."
	shared formal String? preferredStyleSheetSet;

	"Returns a list of the style sheet sets available on the document."
	shared formal String[] styleSheetSets;

	""
	shared formal void enableStyleSheetsForSet(String? name);
}

shared dynamic Window satisfies GlobalEventHandlers
{

}

// https://developer.mozilla.org/en-US/docs/Web/API/Element
"Represents an object of a Document. Describes methods and properties common to all kinds of elements.

 Specific behaviors are described in interfaces which inherit from Element but add additional functionality.
 For example, the HTMLElement interface is the base interface for HTML elements,
 while the SVGElement interface is the basis for all SVG elements."
shared dynamic Element satisfies Node//, NodeSelector, ElementTraversal
{
	"Id of the element."
	shared formal variable String id;

	"Class of the element."
	shared formal variable String className;

	"Name of the tag for the element."
	shared formal String tagName;

	"Markup of the element's content."
	shared formal variable String innerHTML;

	"Markup of the element including its content.
	 When used as a setter, replaces the element with nodes parsed from the given string."
	shared formal variable String outerHTML;

	"Width of the top border of the element."
	shared formal Float clientTop;

	"Width of the left border of the element"
	shared formal Float clientLeft;

	"Inner width of the element."
	shared formal Float clientWidth;

	"Inner height of the element."
	shared formal Float clientHeight;

	"Top scroll offset the element."
	shared formal variable Float scrollTop;

	"Left scroll offset of the element."
	shared formal variable Float scrollLeft;

	"Maximum top scroll offset possible for the element."
	shared formal Float scrollTopMax;

	"Maximum left scroll offset possible for the element."
	shared formal Float scrollLeftMax;

	"Scroll view width of the element."
	shared formal Float scrollWidth;

	"Scroll view height of an element."
	shared formal Float scrollHeight;


	"Retrieves the value of the named attribute from the current node and returns it as an Object."
	shared formal String getAttribute(String? name);

	"Retrieves the value of the attribute with the specified name and namespace, from the current node and returns it as an Object."
	shared formal String getAttributeNS(String namespaceURI, String localName);

	"Returns a Boolean indicating if the element has the specified attribute or not."
	shared formal Boolean hasAttribute(String name);

	"Returns a Boolean indicating if the element has the specified attribute, in the specified namespace, or not."
	shared formal Boolean hasAttributeNS(String namespaceURI, String localName);

	"Sets the value of a named attribute of the current node."
	shared formal void setAttribute(String? name, String? val);

	"Sets the value of the attribute with the specified name and namespace, from the current node."
	shared formal void setAttributeNS(String namespaceURI, String qualifiedName, String val);

	"Removes the named attribute from the current node."
	shared formal void removeAttribute(String? name);

	"Removes the attribute with the specified name and namespace, from the current node."
	shared formal void removeAttributeNS(String namespaceURI, String localName);


	"Returns a live HTMLCollection containing all descendant elements, of a particular tag name, from the current element."
	shared formal NodeList getElementsByTagName(String name);

	"Returns a live HTMLCollection containing all descendant elements, of a particular tag name and namespace, from the current element."
	shared formal NodeList getElementsByTagNameNS(String namespaceURI, String localName);

	"Returns a live HTMLCollection that contains all descendant of the current element that posses the list of classes given in parameter."
	shared formal NodeList getElementsByClassName(String className);


	"Returns a text rectangle object that encloses a group of text rectangles."
	shared formal ClientRect getBoundingClientRect();

	"Returns a collection of rectangles that indicate the bounding rectangles for each box in a client."
	shared formal ClientRectList getClientRects();


	"Returns the first element that is a descendant of the element on which it is invoked that matches the specified group of selectors."
	shared formal Node? querySelector(String selectors);

	"Returns a non-live NodeList of all elements descended from the element on which it is invoked that match the specified group of CSS selectors."
	shared formal NodeList querySelectorAll(String selectors);


	"Asynchronously asks the browser to make the element full-screen."
	shared formal void requestFullScreen();

	"Scrolls the page until the element gets into the view."
	shared formal void scrollIntoView(Boolean alignToTop = true);

	"Parses the text as HTML or XML and inserts the resulting nodes into the tree in the position given."
	shared formal void insertAdjacentHTML(String position, String html); // position is one of  'beforebegin', 'afterbegin', 'beforeend', 'afterend'

	/* Deprecated
	shared formal IAttr setAttributeNode(IAttr attribute);
	shared formal IAttr setAttributeNodeNS(IAttr attribute);
	shared formal IAttr getAttributeNode(String name);
	shared formal IAttr getAttributeNodeNS(String namespaceURI, String localName);
	shared formal void removeAttributeNode(IAttr attribute);
	*/
}

// https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement
"Represents any HTML element. Some elements directly implement this interface, others implement it via an interface that inherits it."
shared dynamic HTMLElement satisfies Element, GlobalEventHandlers
{
	"Text that appears in a popup box when mouse is over the element."
	shared formal variable String title;

	"Language of an element's attributes, text, and element contents."
	shared formal variable String lang;

	"Reflects the dir global attribute, representing the directionality of the element.
	 Possible values are \"ltr\", \"rtl\", and \"auto\"."
	shared formal variable String dir;

	"Represents the declarations of an element's style attributes."
	shared formal variable CSSStyleDeclaration style;

	""
	shared formal variable Boolean disabled;

	"Indicates if the element is hidden or not."
	shared formal variable Boolean hidden;

	"Controls spell-checking. It is present on all HTML elements, though it hasn't an effect on all of them."
	shared formal variable Boolean spellcheck;

	""
	shared formal variable Boolean translate;

	"Indicates if the element can be dragged."
	shared formal variable Boolean draggable;

	"Reflects the dropzone global attribute and describes the behavior of the element regarding a drop operation."
	shared formal variable DOMSettableTokenList dropzone;

	"'true' means the element is editable and 'false' means it isn't."
	shared formal variable String contentEditable;

	"Indicates whether or not the content of the element can be edited."
	shared formal Boolean isContentEditable;

	"Position of the element in the tabbing order."
	shared formal variable Integer tabIndex;

	"Access key assigned to the element."
	shared formal variable String accessKey;

	"Element's assigned access key."
	shared formal String accessKeyLabel;

//	shared formal variable IHTMLMenuElement contextMenu;
//	shared formal IDOMStringMap dataSet;

	"Distance from this element's top border to its offsetParent's top border."
	shared formal Float offsetTop;

	"Distance from this element's left border to its offsetParent's left border."
	shared formal Float offsetLeft;

	"Width of an element, relative to the layout."
	shared formal Float offsetWidth;

	"Height of an element, relative to the layout."
	shared formal Float offsetHeight;

	"The element from which all offset calculations are currently computed."
	shared formal Element offsetParent;

	"Makes the element the current keyboard focus."
	shared formal void focus();

	"Removes keyboard focus from the currently focused element."
	shared formal void blur();

	"Sends a mouse click event to the element."
	shared formal void click();

	"Makes the spell checker runs on the element."
	shared formal void forceSpellCheck();

/*
	ondragend: (ev: DragEvent) => any;
	onkeydown: (ev: KeyboardEvent) => any;
	ondragover: (ev: DragEvent) => any;
	onkeyup: (ev: KeyboardEvent) => any;
	onreset: (ev: Event) => any;
	onmouseup: (ev: MouseEvent) => any;
	ondragstart: (ev: DragEvent) => any;
	ondrag: (ev: DragEvent) => any;
	onmouseover: (ev: MouseEvent) => any;
	ondragleave: (ev: DragEvent) => any;
	onpause: (ev: Event) => any;
	onseeked: (ev: Event) => any;
	onmousedown: (ev: MouseEvent) => any;
	onclick: (ev: MouseEvent) => any;
	onwaiting: (ev: Event) => any;
	ondurationchange: (ev: Event) => any;
	onblur: (ev: FocusEvent) => any;
	onemptied: (ev: Event) => any;
	onseeking: (ev: Event) => any;
	oncanplay: (ev: Event) => any;
	onstalled: (ev: Event) => any;
	onmousemove: (ev: MouseEvent) => any;
	onratechange: (ev: Event) => any;
	onloadstart: (ev: Event) => any;
	ondragenter: (ev: DragEvent) => any;
	onsubmit: (ev: Event) => any;
	onprogress: (ev: any) => any;
	ondblclick: (ev: MouseEvent) => any;
	oncontextmenu: (ev: MouseEvent) => any;
	onchange: (ev: Event) => any;
	onloadedmetadata: (ev: Event) => any;
	onerror: (ev: Event) => any;
	onplay: (ev: Event) => any;
	onplaying: (ev: Event) => any;
	oncanplaythrough: (ev: Event) => any;
	onabort: (ev: UIEvent) => any;
	onreadystatechange: (ev: Event) => any;
	onkeypress: (ev: KeyboardEvent) => any;
	onloadeddata: (ev: Event) => any;
	onsuspend: (ev: Event) => any;
	onfocus: (ev: FocusEvent) => any;
	ontimeupdate: (ev: Event) => any;
	onselect: (ev: UIEvent) => any;
	ondrop: (ev: DragEvent) => any;
	onmouseout: (ev: MouseEvent) => any;
	onended: (ev: Event) => any;
	onscroll: (ev: UIEvent) => any;
	onmousewheel: (ev: MouseWheelEvent) => any;
	onvolumechange: (ev: Event) => any;
	onload: (ev: Event) => any;
	oninput: (ev: Event) => any;
*/
}

shared dynamic HTMLBodyElement satisfies HTMLElement, WindowEventHandlers
{

}

shared dynamic DOMSettableTokenList
{
	// To do
}
