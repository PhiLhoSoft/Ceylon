/*
Methods of Number / global object. Not sure how to declare them properly. Perhaps attached to document.
dynamic shared Boolean isNaN();
dynamic shared Boolean isFinite();
dynamic shared Boolean isInteger();
dynamic shared Boolean isSafeInteger();
dynamic shared Float parseFloat();
dynamic shared Integer parseInt();
*/

// Use the JS prefix because:
// 1. We need to distinguish from the Ceylon Number;
// 2. We can instanciate this interface to create a new JS Number (eg. from a string).
shared dynamic JSNumber //satisfies Number<Float> | Number<Integer>
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

/** Create a new Number (INumber) from something likely to be a string or an number... */
JSNumber newNumber(Anything? v)
{
    dynamic { return \iNumber(v); }
}

shared dynamic ClientRect
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

shared dynamic ClientRectList
{
    shared formal Integer length;
    shared formal ClientRect? item(Integer index);
}

shared dynamic Event
{

}
shared dynamic EventListener
{

}
shared dynamic EventTarget
{
    "Registers an event handler to a specific event type on the EventTarget."
    shared formal void addEventListener(String type, EventListener | Anything() listener, Boolean useCapture = false);

    "Removes an event listener from the EventTarget."
    shared formal void removeEventListener(String type, EventListener listener, Boolean useCapture = false);

    "Dispatches an event to this node in the DOM and returns a Boolean that indicates that at least one handler has not canceled it."
    shared formal Boolean dispatchEvent(Event event);
}

// https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers
shared dynamic GlobalEventHandlers // No instances
{
    shared formal variable Anything()? onabort;
    shared formal variable Anything()? onblur;
}
shared dynamic WindowEventHandlers // Not an interface, no instances
{
    shared formal variable Anything()? onbeforeunload;
    shared formal variable Anything()? onunload;
}

"The ArrayBuffer object is used to represent a generic, fixed-length raw binary data buffer.
 You can not directly manipulate the contents of an ArrayBuffer;
 instead, you create one of the typed array objects or a DataView object which represents the buffer in a specific format,
 and use that to read and write the contents of the buffer."
shared dynamic ArrayBuffer
{
    "Returns `true` if arg is one of the `ArrayBuffer` views, such as typed array objects or a `DataView`. Returns `false` otherwise."
    shared formal Boolean isView(Anything arg);

    "The size, in bytes, of the array. This is established when the array is constructed and cannot be changed. "
    shared formal Integer byteLength;

    "Returns a new `ArrayBuffer` whose contents are a copy of this `ArrayBuffer`'s bytes from begin, inclusive, up to end, exclusive.
     The `slice` method copies up to, but not including, the byte indicated by the end parameter.
     If either begin or end is negative, it refers to an index from the end of the array, as opposed to from the beginning."
    shared formal ArrayBuffer slice(
        "Zero-based byte index at which to begin slicing."
        Integer begin,
        "Byte index to end slicing. If end is unspecified, the new `ArrayBuffer` contains all bytes from begin to the end of this `ArrayBuffer`.
         The range specified by the begin and end values is clamped to the valid index range for the current array.
         If the computed length of the new `ArrayBuffer` would be negative, it is clamped to zero."
        Integer end = byteLength
    );
}
shared ArrayBuffer newArrayBuffer(
    "The size, in bytes, of the array buffer to create."
    Integer byteLength
)
{
    dynamic { return \iArrayBuffer(byteLength); }
}

shared dynamic Int8Array {}
shared dynamic UInt8Array {}
shared dynamic UInt8ClampedArray {}
shared dynamic Int16Array {}
shared dynamic UInt16Array {}
shared dynamic Int32Array {}
shared dynamic UInt32Array {}
shared dynamic Float32Array {}
shared dynamic Float64Array {}

"The `DataView` view provides a low-level interface for reading data from and writing it to an [[ArrayBuffer]]."
shared dynamic DataView
{
    "The [[ArrayBuffer]] referenced by this view. Fixed at construction time and thus read only."
    shared formal ArrayBuffer buffer;
    "The length (in bytes) of this view from the start of its [[ArrayBuffer]]. Fixed at construction time and thus read only."
    shared formal Integer byteOffset;
    "The number of elements in the byte array. If unspecified, length of the view will match the buffer's length."
    shared formal Integer byteLength;

    // Read

    "Gets a signed 8-bit integer (byte) at the specified byte offset from the start of the view."
    shared formal Byte getInt8();
    "Gets an unsigned 8-bit integer (unsigned byte) at the specified byte offset from the start of the view."
    shared formal Byte getUint8();
    "Gets a signed 16-bit integer (short) at the specified byte offset from the start of the view."
    shared formal Integer getInt16();
    "Gets an unsigned 16-bit integer (unsigned short) at the specified byte offset from the start of the view."
    shared formal Integer getUint16();
    "Gets a signed 32-bit integer (long) at the specified byte offset from the start of the view."
    shared formal Integer getInt32();
    "Gets an unsigned 32-bit integer (unsigned long) at the specified byte offset from the start of the view."
    shared formal Integer getUint32();
    "Gets a signed 32-bit float (float) at the specified byte offset from the start of the view."
    shared formal Float getFloat32();
    "Gets a signed 64-bit float (double) at the specified byte offset from the start of the view."
    shared formal Float getFloat64();

    // Write

    "Stores a signed 8-bit integer (byte) value at the specified byte offset from the start of the view."
    shared formal void setInt8(Integer byteOffset, Byte val);
    "Stores an unsigned 8-bit integer (unsigned byte) value at the specified byte offset from the start of the view."
    shared formal void setUint8(Integer byteOffset, Byte val);
    "Stores a signed 16-bit integer (short) value at the specified byte offset from the start of the view."
    shared formal void setInt16(Integer byteOffset, Integer val);
    "Stores an unsigned 16-bit integer (unsigned short) value at the specified byte offset from the start of the view."
    shared formal void setUint16(Integer byteOffset, Integer val);
    "Stores a signed 32-bit integer (long) value at the specified byte offset from the start of the view."
    shared formal void setInt32(Integer byteOffset, Integer val);
    "Stores an unsigned 32-bit integer (unsigned long) value at the specified byte offset from the start of the view."
    shared formal void setUint32(Integer byteOffset, Integer val);
    "Stores a signed 32-bit float (float) value at the specified byte offset from the start of the view."
    shared formal void setFloat32(Integer byteOffset, Float val);
    "Stores a signed 64-bit float (double) value at the specified byte offset from the start of the view."
    shared formal void setFloat64(Integer byteOffset, Float val);
}
shared DataView newDataView(
        "An existing ArrayBuffer to use as the storage for the new DataView object."
        ArrayBuffer buffer,
        "The offset, in bytes, to the first byte in the specified buffer for the new view to reference.
         If not specified, the view of the buffer will start with the first byte."
        Integer byteOffset,
        "The number of elements in the byte array. If unspecified, length of the view will match the buffer's length."
        Integer byteLength
        )
{
    dynamic { return \iDataView(buffer, byteOffset, byteLength); }
}


shared alias ArrayBufferView =>
        Int8Array |
        UInt8Array |
        UInt8ClampedArray |
        Int16Array |
        UInt16Array |
        Int32Array |
        UInt32Array |
        Float32Array |
        Float64Array |
        DataView;


shared dynamic Blob
{
    "The size, in bytes, of the data contained in the `Blob` object."
    shared formal Integer size;

    "A string indicating the Mime type of the data contained in the `Blob`. If the type is unknown, this string is empty."
    shared formal String type;

    "Returns a new `Blob` object containing the data in the specified range of bytes of the source `Blob`."
    shared formal Blob slice(
        "An index into the `Blob` indicating the first byte to copy into the new `Blob`.
         If you specify a negative value, it's treated as an offset from the end of the string toward the beginning.
         For example, `-10` would be the 10th from last byte in the Blob. The default value is `0`.
         If you specify a value for start that is larger than the size of the source `Blob`, the returned `Blob` has size 0 and contains no data."
        Integer start = 0,
        "An index into the `Blob` indicating where to stop copying into the new `Blob`.
         The byte exactly at this index is not included.
         If you specify a negative value, it's treated as an offset from the end of the string toward the beginning.
         For example, `-10` would be the 10th from last byte in the `Blob`. The default value is [[size]]."
        Integer end = size,
        "The content type to assign to the new `Blob`; this will be the value of its type property. The default value is an empty string."
        String contentType = ""
    );
}

shared interface BlobElements => [ ArrayBuffer | ArrayBufferView | Blob | String * ];

shared Blob newBlob(BlobElements blobElements)
{
    dynamic { return \iBlob(blobElements); }
}

shared dynamic FormData
{

}

shared dynamic XMLHttpRequest
{
    "Initializes a request."
    shared formal void open(String method, String url, Boolean async = true, String user = "", String password = "");

    "Sends the request. If the request is asynchronous (which is the default), this method returns as soon as the request is sent.
     If the request is synchronous, this method doesn't return until the response has arrived."
    shared formal void send(
        ArrayBuffer |
		ArrayBufferView |
		Blob |
		Document |
		String? |
		FormData data = null);

    "Aborts the request if it has already been sent."
    shared formal void abort();

    "Returns the string containing the text of the specified header,
     or null if either the response has not yet been received or the header doesn't exist in the response."
    shared formal String? getResponseHeader(String header);

    "Returns all the response headers as a string, or `null` if no response has been received."
    shared formal String? getAllResponseHeaders();

    "Overrides the Mime type returned by the server.
     This may be used, for example, to force a stream to be treated and parsed as `text/xml`, even if the server does not report it as such.
     This method must be called before [[send]]."
    shared formal void overrideMimeType(String mimeType);

    "Sets the value of an HTTP request header.
     You must call [[setRequestHeader]] after [[open]], but before [[send]].
     If this method is called several times with the same header, the values are merged into one single request header."
    shared formal void setRequestHeader(String header, String val);

    "A JavaScript function object that is called whenever the [[readyState]] attribute changes. The callback is called from the user interface thread."
    shared formal variable Anything()? onreadystatechange;

    "The state of the request.
     - 0 UNSENT `open()` has not been called yet.
     - 1 OPENED `send()` has not been called yet.
     - 2 HEADERS_RECEIVED `send()` has been called, and headers and status are available.
     - 3 LOADING Downloading; `responseText` holds partial data.
     - 4 DONE The operation is complete."
    shared formal variable Integer readyState;

    "The response entity body according to `responseType`, as an `ArrayBuffer`, `Blob`, `Document`, JavaScript object (for `'json'`), or string.
     This is `null` if the request is not complete or was not successful."
    shared formal variable Anything? response;

    "The response to the request as text, or `null` if the request was unsuccessful or has not yet been sent."
    shared formal String? responseText;

    """Can be set to change the response type.
       - "" (empty string) String (this is the default)
       - "arraybuffer" ArrayBuffer
       - "blob" Blob
       - "document" Document
       - "json" JavaScript object, parsed from a JSON string returned by the server
       - "text" String
       """
    // Theoretically of type XMLHttpRequestResponseType but looks like strings...
    shared formal variable String responseType;

    """The response to the request as a DOM `Document` object, or null if the request was unsuccessful,
       has not yet been sent, or cannot be parsed as XML or HTML.
       The response is parsed as if it were a `text/xml` stream.
       When the `responseType` is set to `"document"` and the request has been made asynchronously, the response is parsed as a `text/html` stream.
       """
    shared formal variable Document? responseXML;

    "The status of the response to the request. This is the HTTP result code (for example, status is 200 for a successful request)."
    shared formal Integer status;

    """The response string returned by the HTTP server. Unlike status, this includes the entire text of the response message ("200 OK", for example)."""
    shared formal String statusText;

    "The number of milliseconds a request can take before automatically being terminated. A value of 0 (which is the default) means there is no timeout."
    shared formal variable Integer timeout;

    "A JavaScript function object that is called whenever the request times out."
    shared formal variable Anything()? ontimeout;

    "The upload process can be tracked by adding an event listener to upload."
    shared formal variable XMLHttpRequestUpload upload;

    "Indicates whether or not cross-site Access-Control requests should be made using credentials such as cookies or authorization headers.
     The default is false.
     Note: This never affects same-site requests."
    shared formal variable Boolean withCredentials;
}

shared XMLHttpRequest newXMLHttpRequest()
{
    dynamic { return \iXMLHttpRequest(); }
}

shared dynamic XMLHttpRequestUpload
{

}
