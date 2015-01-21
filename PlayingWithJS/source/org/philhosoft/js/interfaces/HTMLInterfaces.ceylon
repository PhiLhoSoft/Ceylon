import ceylon.language.meta.model { Function }

// Type definitions for generic HTML entities

/*
Methods of Number / global object. Not sure how to declare them properly.
dynamic shared Boolean isNaN();
dynamic shared Boolean isFinite();
dynamic shared Boolean isInteger();
dynamic shared Boolean isSafeInteger();
dynamic shared Float parseFloat();
dynamic shared Integer parseInt();
*/

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
/* Cannot use Number as it is a Ceylon class...
INumber newNumber(Anything? v)
{
	dynamic { return Number(v); }
}
*/

dynamic IEvent
{

}
dynamic IEventListener
{

}
dynamic IEventTarget
{
	shared formal void addEventListener(String type, IEventListener | Function listener, Boolean useCapture = false);
	shared formal void removeEventListener(String type, IEventListener listener, Boolean useCapture = false);
	shared formal Boolean dispatchEvent(IEvent event);
}

dynamic IDocument
{

}

dynamic INode satisfies IEventTarget
{
	shared formal String baseURI;
	shared formal INodeList childNodes;
	shared formal INode? firstChild;
	shared formal INode? lastChild;
	shared formal INode? previousSibling;
	shared formal INode? nextSibling;
	// These two should be defined in Element, but some browsers still locate them here
	shared formal String localName;
	shared formal String namespaceURI;

	shared formal String nodeName;
	shared formal variable String? nodeValue;
	shared formal variable String? textContent;
	shared formal Integer nodeType;

	shared formal IDocument? ownerDocument;
	shared formal INode? parentNode;
	shared formal IElement? parentElement;

	shared formal Boolean hasChildNodes();
	shared formal INode appendChild(INode newChild);
	shared formal INode removeChild(INode oldChild);
	shared formal INode replaceChild(INode newChild, INode oldChild);
	shared formal INode insertBefore(INode newChild, INode? referenceChild = null);
	shared formal INode cloneNode(Boolean deep = false);
	shared formal Integer compareDocumentPosition(INode node);
	shared formal Boolean contains(INode node);
	shared formal Boolean isEqualNode(INode node);
	shared formal Boolean isDefaultNamespace(String namespaceURI);
	shared formal String lookupPrefix(String namespaceURI);
	shared formal String lookupNamespaceURI(String prefix);
	shared formal void normalize();
}

dynamic IHTMLCollection
{
	shared formal Integer length;
	// According to https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection some browsers can return a NodeList or HTMLCollection if id isn't unique
	shared formal IElement? item(Integer index);
	shared formal IElement? namedItem(String name);
}

dynamic INodeList
{
	shared formal Integer length;
	shared formal IElement? item(Integer index);
	// Perhaps add the [] accessor
}

dynamic IClientRect
{

}
dynamic IClientRectList
{

}

// https://developer.mozilla.org/en-US/docs/Web/API/Element
dynamic IElement satisfies INode//, INodeSelector, IElementTraversal
{
	shared formal variable String id;
	shared formal variable String className;
	shared formal String tagName;
	shared formal variable String innerHTML;
	shared formal variable String outerHTML;
	shared formal Float clientTop;
	shared formal Float clientLeft;
	shared formal Float clientWidth;
	shared formal Float clientHeight;
	shared formal variable Float scrollTop;
	shared formal variable Float scrollLeft;
	shared formal Float scrollTopMax;
	shared formal Float scrollLeftMax;
	shared formal Float scrollWidth;
	shared formal Float scrollHeight;

	shared formal String getAttribute(String? name);
	shared formal String getAttributeNS(String namespaceURI, String localName);
	shared formal Boolean hasAttribute(String name);
	shared formal Boolean hasAttributeNS(String namespaceURI, String localName);
	shared formal void setAttribute(String? name, String? val);
	shared formal void setAttributeNS(String namespaceURI, String qualifiedName, String val);
	shared formal void removeAttribute(String? name);
	shared formal void removeAttributeNS(String namespaceURI, String localName);

	shared formal INodeList getElementsByTagName(String name);
	shared formal INodeList getElementsByTagNameNS(String namespaceURI, String localName);
	shared formal INodeList getElementsByClassName(String className);

	shared formal IClientRect getBoundingClientRect();
	shared formal IClientRectList getClientRects();

	shared formal INode? querySelector(String selectors);
	shared formal INodeList querySelectorAll(String selectors);

	shared formal void requestFullScreen();
	shared formal void scrollIntoView(Boolean alignToTop = true);
	shared formal void insertAdjacentHTML(String position, String html); // position is one of  'beforebegin', 'afterbegin', 'beforeend', 'afterend'

	/* Deprecated
	shared formal IAttr setAttributeNode(IAttr attribute);
	shared formal IAttr setAttributeNodeNS(IAttr attribute);
	shared formal IAttr getAttributeNode(String name);
	shared formal IAttr getAttributeNodeNS(String namespaceURI, String localName);
	shared formal void removeAttributeNode(IAttr attribute);
	*/
}

IElement newElement()
{
	dynamic { return Element(); }
}

// https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement
dynamic IHTMLElement satisfies IElement, IGlobalEventHandlers
{
	shared formal variable String title;
	shared formal variable String lang;
	shared formal variable String dir; // "ltr", "rtl" or "auto"
	shared formal variable ICSSStyleDeclaration style;
	shared formal variable Boolean disabled;
	shared formal variable Boolean hidden;
	shared formal variable Boolean spellcheck;
	shared formal variable Boolean draggable;
//	shared formal variable ISettableTokenList dropzone;
	shared formal variable String contentEditable;
	shared formal Boolean isContentEditable;
	shared formal variable Integer tabIndex;
	shared formal variable String accessKey;
	shared formal String accessKeyLabel;
//	shared formal variable IHTMLMenuElement contextMenu;
	shared formal Float offsetTop;
	shared formal Float offsetLeft;
	shared formal Float offsetWidth;
	shared formal Float offsetHeight;
	shared formal IElement offsetParent;
	shared formal variable Boolean translate;

	shared formal void focus();
	shared formal void blur();
	shared formal void click();
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

dynamic IBlob
{
	// To do
}
