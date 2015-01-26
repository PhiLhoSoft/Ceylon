import ceylon.language.meta.model { Function }

// Type definitions for generic HTML entities
// Note that most interfaces here are really only interfaces in the Dom model:
// they don't have constructors, so we cannot create them with new.
// In general, we have to call something like document.createElement() or similar, or to get them out of the Dom / HTML.

/*
Methods of Number / global object. Not sure how to declare them properly. Perhaps attached to document.
dynamic shared Boolean isNaN();
dynamic shared Boolean isFinite();
dynamic shared Boolean isInteger();
dynamic shared Boolean isSafeInteger();
dynamic shared Float parseFloat();
dynamic shared Integer parseInt();
*/

// Use the I prefix because:
// 1. We need to distinguish from the Ceylon Number;
// 2. We can instanciate this interface to create a new JS Number (eg. from a string).
dynamic INumber //satisfies Number<Float> | Number<Integer>
{
	shared formal Float \iEPSILON;
	shared formal Integer \iMAX_SAFE_INTEGER;
	shared formal Float \iMAX_VALUE;
	shared formal Integer \iMIN_SAFE_INTEGER;
	shared formal Float \iMIN_VALUE;
	shared formal Float \iNaN;
	shared formal Float \iNEGATIVE_INFINITY;
	shared formal Float \iPOSITIVE_INFINITY;
//	prototype
	shared formal String toExponential();
	shared formal String toFixed();
	shared formal String toLocaleString();
	shared formal String toPrecision();
	shared formal Anything toSource();
	shared formal String toString();
	shared formal String valueOf();
}
//* Cannot use Number as it is a Ceylon class...
/** Create a new Number (INumber) from something likely to be a string or an number... */
INumber newNumber(Anything? v)
{
	dynamic { return \iNumber(v); }
}
//*/

dynamic IEvent
{

}
dynamic IEventListener
{

}
dynamic IEventTarget
{
	"Registers an event handler to a specific event type on the EventTarget."
	shared formal void addEventListener(String type, IEventListener | Function listener, Boolean useCapture = false);

	"Removes an event listener from the EventTarget."
	shared formal void removeEventListener(String type, IEventListener listener, Boolean useCapture = false);

	"Dispatches an event to this node in the DOM and returns a Boolean that indicates that at least one handler has not canceled it."
	shared formal Boolean dispatchEvent(IEvent event);
}

dynamic INode satisfies IEventTarget
{
	""
	shared formal String baseURI;

	"Live list."
	shared formal INodeList childNodes;

	""
	shared formal INode? firstChild;

	""
	shared formal INode? lastChild;

	""
	shared formal INode? previousSibling;

	""
	shared formal INode? nextSibling;

	// These two should be defined in Element, but some browsers still locate them here

	""
	shared formal String localName;

	""
	shared formal String namespaceURI;


	""
	shared formal String nodeName;

	""
	shared formal variable String? nodeValue;

	""
	shared formal variable String? textContent;

	""
	shared formal Integer nodeType;


	""
	shared formal IDocument? ownerDocument;

	""
	shared formal INode? parentNode;

	""
	shared formal IElement? parentElement;


	""
	shared formal Boolean hasChildNodes();

	""
	shared formal INode appendChild(INode newChild);

	""
	shared formal INode removeChild(INode oldChild);

	""
	shared formal INode replaceChild(INode newChild, INode oldChild);

	""
	shared formal INode insertBefore(INode newChild, INode? referenceChild = null);

	""
	shared formal INode cloneNode(Boolean deep = false);

	""
	shared formal Integer compareDocumentPosition(INode node);

	""
	shared formal Boolean contains(INode node);

	""
	shared formal Boolean isEqualNode(INode node);

	""
	shared formal Boolean isDefaultNamespace(String namespaceURI);

	""
	shared formal String lookupPrefix(String namespaceURI);

	""
	shared formal String lookupNamespaceURI(String prefix);

	""
	shared formal void normalize();
}

"INodeList can be live (eg. from INode.childNodes) or static (from document.querySelectorAll for example)"
dynamic INodeList
{
	shared formal Integer length;
	shared formal INode? item(Integer index);
	// Perhaps add the [] accessor
}

dynamic IHTMLCollection
{
	shared formal Integer length;
	// According to https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection some browsers can return a NodeList or HTMLCollection if id isn't unique
	shared formal IElement? item(Integer index);
	shared formal IElement? namedItem(String name);
}

dynamic IClientRect
{
	"Y-coordinate, relative to the viewport origin, of the top of the rectangle box."
	shared formal Float top;

	"X-coordinate, relative to the viewport origin, of the right of the rectangle box."
	shared formal Float right;

	"Y-coordinate, relative to the viewport origin, of the bottom of the rectangle box."
	shared formal Float bottom;

	"X-coordinate, relative to the viewport origin, of the left of the rectangle box."
	shared formal Float left;

	"Width of the rectangle box (This is identical to right minus left)."
	shared formal Float width;

	"Height of the rectangle box (This is identical to bottom minus top)."
	shared formal Float height;
}
dynamic IClientRectList
{
	shared formal Integer length;
	shared formal IClientRect? item(Integer index);
}

dynamic IDOMImplementation
{

}

// https://developer.mozilla.org/en-US/docs/Web/API/Document
"Each web page loaded in the browser has its own document object.
 The IDocument interface serves as an entry point into the web page's content
 (the DOM tree, including elements such as &lt;body> and &lt;table>)
 and provides functionality which is global to the document
 (such as obtaining the page's URL and creating new elements in the document)."
dynamic IDocument satisfies INode
{
	"Document Type Definition (DTD) of the current document."
	shared formal String doctype;

	"Element that is a direct child of the document. For HTML documents, this is normally the HTML element."
	shared formal IElement documentElement;

	"URL of the Document."
	shared formal String documentURI;

	"DOM implementation associated with the current document."
	shared formal IDOMImplementation implementation;

	"Name of the style sheet set that was last enabled.
	 Has the value null until the style sheet is changed by setting the value of selectedStyleSheetSet."
	shared formal String? lastStyleSheetSet;

	"Preferred style sheet set as specified by the page author."
	shared formal String? preferredStyleSheetSet;

	"Which style sheet set is currently in use."
	shared formal String? selectedStyleSheetSet;
}

// https://developer.mozilla.org/en-US/docs/Web/API/Element
"Represents an object of a Document. Describes methods and properties common to all kinds of elements.

 Specific behaviors are described in interfaces which inherit from Element but add additional functionality.
 For example, the HTMLElement interface is the base interface for HTML elements,
 while the SVGElement interface is the basis for all SVG elements."
dynamic IElement satisfies INode//, INodeSelector, IElementTraversal
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
	shared formal INodeList getElementsByTagName(String name);

	"Returns a live HTMLCollection containing all descendant elements, of a particular tag name and namespace, from the current element."
	shared formal INodeList getElementsByTagNameNS(String namespaceURI, String localName);

	"Returns a live HTMLCollection that contains all descendant of the current element that posses the list of classes given in parameter."
	shared formal INodeList getElementsByClassName(String className);


	"Returns a text rectangle object that encloses a group of text rectangles."
	shared formal IClientRect getBoundingClientRect();

	"Returns a collection of rectangles that indicate the bounding rectangles for each box in a client."
	shared formal IClientRectList getClientRects();


	"Returns the first element that is a descendant of the element on which it is invoked that matches the specified group of selectors."
	shared formal INode? querySelector(String selectors);

	"Returns a non-live NodeList of all elements descended from the element on which it is invoked that match the specified group of CSS selectors."
	shared formal INodeList querySelectorAll(String selectors);


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
dynamic IHTMLElement satisfies IElement, IGlobalEventHandlers
{
	"Text that appears in a popup box when mouse is over the element."
	shared formal variable String title;

	"Language of an element's attributes, text, and element contents."
	shared formal variable String lang;

	"Reflects the dir global attribute, representing the directionality of the element.
	 Possible values are \"ltr\", \"rtl\", and \"auto\"."
	shared formal variable String dir;

	"Represents the declarations of an element's style attributes."
	shared formal variable ICSSStyleDeclaration style;

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
	shared formal variable IDOMSettableTokenList dropzone;

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
	shared formal IElement offsetParent;

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

// https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers
dynamic IGlobalEventHandlers // No instances
{
	shared formal variable Anything()? onabort;
	shared formal variable Anything()? onblur;
}
dynamic WindowEventHandlers // Not an interface, no instances
{
	shared formal variable Anything()? onbeforeunload;
	shared formal variable Anything()? onunload;
}

dynamic IHTMLBodyElement satisfies IHTMLElement, WindowEventHandlers
{

}

dynamic ICSSStyleDeclaration
{

}

dynamic IDOMSettableTokenList
{
	// To do
}
dynamic IBlob
{
	// To do
}
