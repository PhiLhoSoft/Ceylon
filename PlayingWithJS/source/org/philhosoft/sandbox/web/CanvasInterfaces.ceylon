
// https://developer.mozilla.org/en-US/docs/Web/API/HTMLCanvasElement
dynamic IHTMLCanvasElement satisfies IHTMLElement
{
	shared formal variable Integer width;
	shared formal variable Integer height;
	shared formal String toDataURL();
	shared formal IBlob toBlob();
	shared formal ICanvasRenderingContext2D | IWebGLRenderingContext getContext(String contextId); // "2d" or "webgl"
}

IHTMLCanvasElement newHTMLCanvasElement()
{
	dynamic { return HTMLCanvasElement(); }
}

dynamic IWebGLRenderingContext
{
	// To do
}

// https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D
dynamic ICanvasRenderingContext2D
{
	shared formal IHTMLCanvasElement canvas;
	shared formal variable Anything fillStyle; // Default #000 (black)
	shared formal variable Anything strokeStyle; // Default #000 (black)
	shared formal variable String font; // Default 10px sans-serif
	shared formal variable String textAlign; // start (default), end, left, right or center
	shared formal variable String textBaseline; // top, hanging, middle, alphabetic (default), ideographic, bottom
	shared formal variable String direction; // ltr, rtl, inherit (default)
	shared formal variable Float lineWidth; // Default 1.0
	shared formal variable String lineCap; // butt (default), round, square
	shared formal variable String lineJoin; // round, bevel, miter (default)
	shared formal variable Float miterLimit; // Default 10
	shared formal variable Float shadowBlur; // Default 0
	shared formal variable String shadowColor; // Default fully-transparent black
	shared formal variable Float shadowOffsetX; // Default 0
	shared formal variable Float shadowOffsetY; // Default 0
	shared formal variable Float globalAlpha; // Default 1.0 (opaque)
	shared formal variable String globalCompositeOperation;

	shared formal void restore();
	shared formal void setTransform(Float m11, Float m12, Float m21, Float m22, Float dx, Float dy);
	shared formal void save();
	shared formal void arc(Float x, Float y, Float radius, Float startAngle, Float endAngle, Boolean? anticlockwise);
	shared formal ITextMetrics measureText(String text);
	shared formal Boolean isPointInPath(Float x, Float y);
	shared formal void quadraticCurveTo(Float cpx, Float cpy, Float x, Float y);
	shared formal void putImageData(IImageData imagedata, Float dx, Float dy,
			Float? dirtyX, Float? dirtyY, Float? dirtyWidth, Float? dirtyHeight);
	shared formal void rotate(Float angle);
	shared formal void fillText(String text, Float x, Float y, Float? maxWidth);
	shared formal void translate(Float x, Float y);
	shared formal void scale(Float x, Float y);
	shared formal ICanvasGradient createRadialGradient(Float x0, Float y0, Float r0, Float x1, Float y1, Float r1);
	shared formal void lineTo(Float x, Float y);
	shared formal void fill();
	shared formal ICanvasPattern createPattern(IHTMLElement image, String repetition);
	shared formal void closePath();
	shared formal void rect(Float x, Float y, Float w, Float h);
	shared formal void clip();
	shared formal IImageData createImageData(Anything imageDataOrSw, Float? sh);
	shared formal void clearRect(Float x, Float y, Float w, Float h);
	shared formal void moveTo(Float x, Float y);
	shared formal IImageData getImageData(Float sx, Float sy, Float sw, Float sh);
	shared formal void fillRect(Float x, Float y, Float w, Float h);
	shared formal void bezierCurveTo(Float cp1x, Float cp1y, Float cp2x, Float cp2y, Float x, Float y);
	shared formal void drawImage(IHTMLElement image, Float offsetX, Float offsetY,
			Float? width, Float? height, Float? canvasOffsetX, Float? canvasOffsetY, Float? canvasImageWidth, Float? canvasImageHeight);
	shared formal void transform(Float m11, Float m12, Float m21, Float m22, Float dx, Float dy);
	shared formal void stroke();
	shared formal void strokeRect(Float x, Float y, Float w, Float h);
	shared formal void strokeText(String text, Float x, Float y, Float? maxWidth);
	shared formal void beginPath();
	shared formal void arcTo(Float x1, Float y1, Float x2, Float y2, Float radius);
	shared formal ICanvasGradient createLinearGradient(Float x0, Float y0, Float x1, Float y1);
}

ICanvasRenderingContext2D newCanvasRenderingContext2D()
{
	dynamic { return CanvasRenderingContext2D(); }
}

dynamic ITextMetrics
{
	shared formal Float width;
}
dynamic ICanvasPattern
{
}

dynamic ICanvasGradient
{
	shared formal void addColorStop(Float offset, String color);
}

dynamic IImageData
{
	shared formal Integer width;
    shared formal Integer height;
	shared formal Byte[] data;
}

/*
 http://stackoverflow.com/questions/13118051/typescript-definition-files
 http://typescript.codeplex.com/SourceControl/changeset/view/fe3bc0bfce1f#bin/lib.d.ts

 interface HTMLCanvasElement extends HTMLElement {
    width: number;
    height: number;
    toDataURL(): string;
    toDataURL(type: string, ...args: any[]): string;
    getContext(contextId: string): CanvasRenderingContext2D;
 }

 interface CanvasRenderingContext2D {
    shadowOffsetX: number;
    lineWidth: number;
    miterLimit: number;
    canvas: HTMLCanvasElement;
    strokeStyle: any;
    font: string;
    globalAlpha: number;
    globalCompositeOperation: string;
    shadowOffsetY: number;
    fillStyle: any;
    lineCap: string;
    shadowBlur: number;
    textAlign: string;
    textBaseline: string;
    shadowColor: string;
    lineJoin: string;
    restore(): void;
    setTransform(m11: number, m12: number, m21: number, m22: number, dx: number, dy: number): void;
    save(): void;
    arc(x: number, y: number, radius: number, startAngle: number, endAngle: number, anticlockwise?: bool): void;
    measureText(text: string): TextMetrics;
    isPointInPath(x: number, y: number): bool;
    quadraticCurveTo(cpx: number, cpy: number, x: number, y: number): void;
    putImageData(imagedata: ImageData, dx: number, dy: number, dirtyX?: number, dirtyY?: number, dirtyWidth?: number, dirtyHeight?: number): void;
    rotate(angle: number): void;
    fillText(text: string, x: number, y: number, maxWidth?: number): void;
    translate(x: number, y: number): void;
    scale(x: number, y: number): void;
    createRadialGradient(x0: number, y0: number, r0: number, x1: number, y1: number, r1: number): CanvasGradient;
    lineTo(x: number, y: number): void;
    fill(): void;
    createPattern(image: HTMLElement, repetition: string): CanvasPattern;
    closePath(): void;
    rect(x: number, y: number, w: number, h: number): void;
    clip(): void;
    createImageData(imageDataOrSw: any, sh?: number): ImageData;
    clearRect(x: number, y: number, w: number, h: number): void;
    moveTo(x: number, y: number): void;
    getImageData(sx: number, sy: number, sw: number, sh: number): ImageData;
    fillRect(x: number, y: number, w: number, h: number): void;
    bezierCurveTo(cp1x: number, cp1y: number, cp2x: number, cp2y: number, x: number, y: number): void;
    drawImage(image: HTMLElement, offsetX: number, offsetY: number, width?: number, height?: number, canvasOffsetX?: number, canvasOffsetY?: number, canvasImageWidth?: number, canvasImageHeight?: number): void;
    transform(m11: number, m12: number, m21: number, m22: number, dx: number, dy: number): void;
    stroke(): void;
    strokeRect(x: number, y: number, w: number, h: number): void;
    strokeText(text: string, x: number, y: number, maxWidth?: number): void;
    beginPath(): void;
    arcTo(x1: number, y1: number, x2: number, y2: number, radius: number): void;
    createLinearGradient(x0: number, y0: number, x1: number, y1: number): CanvasGradient;
 }

 interface CanvasGradient {
    addColorStop(offset: number, color: string): void;
 }

 interface ImageData {
    width: number;
    data: number[];
    height: number;
 }
 */
