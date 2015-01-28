import ceylon.language.meta.model { Function }


shared dynamic Node satisfies EventTarget
{
	""
	shared formal String baseURI;

	"Live list."
	shared formal NodeList childNodes;

	""
	shared formal Node? firstChild;

	""
	shared formal Node? lastChild;

	""
	shared formal Node? previousSibling;

	""
	shared formal Node? nextSibling;

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
	shared formal Document? ownerDocument;

	""
	shared formal Node? parentNode;

	""
	shared formal Element? parentElement;


	""
	shared formal Boolean hasChildNodes();

	""
	shared formal Node appendChild(Node newChild);

	""
	shared formal Node removeChild(Node oldChild);

	""
	shared formal Node replaceChild(Node newChild, Node oldChild);

	""
	shared formal Node insertBefore(Node newChild, Node? referenceChild = null);

	""
	shared formal Node cloneNode(Boolean deep = false);

	""
	shared formal Integer compareDocumentPosition(Node node);

	""
	shared formal Boolean contains(Node node);

	""
	shared formal Boolean isEqualNode(Node node);

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
shared dynamic NodeList
{
	shared formal Integer length;
	shared formal Node? item(Integer index);
}

shared dynamic HTMLCollection
{
	shared formal Integer length;
	// According to https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection some browsers can return a NodeList or HTMLCollection if id isn't unique
	shared formal Element? item(Integer index);
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
shared dynamic Document satisfies Node
{
	"Document Type Definition (DTD) of the current document."
	shared formal String doctype;

	"Element that is a direct child of the document. For HTML documents, this is normally the HTML element."
	shared formal Element documentElement;

	"URL of the Document."
	shared formal String documentURI;

	"DOM implementation associated with the current document."
	shared formal DOMImplementation implementation;

	"Preferred style sheet set as specified by the page author."
	shared formal String preferredStyleSheetSet;

	"Which style sheet set is currently in use."
	shared formal variable String? selectedStyleSheetSet;

	"Name of the style sheet set that was last enabled.
	 Has the value null until the style sheet is changed by setting the value of [[selectedStyleSheetSet]]."
	shared formal String? lastStyleSheetSet;

	"Returns a list of the style sheet objects on the current document."
	shared formal String? styleSheets;

	"Returns a list of the style sheet sets available on the document."
	shared formal String[] styleSheetSets; // Type isn't clear...
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
