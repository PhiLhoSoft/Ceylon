dynamic HTMLCanvasElement
{
	shared formal Float width;
	shared formal Float height;
	shared formal String toDataURL();
//	shared formal String toDataURL(String type, Anything* args)
	shared formal CanvasRenderingContext2D getContext(String contextId);


	shared formal void open(String method, String url, Boolean async);
	shared formal variable Anything()? onreadystatechange;
	shared formal void send();
	shared formal Integer readyState;
	shared formal String? getAllResponseHeaders();
	//TODO: more operations
}

HTMLCanvasElement newHTMLCanvasElement()
{
	dynamic { return HTMLCanvasElement(); }
}

dynamic CanvasRenderingContext2D
{

}

CanvasRenderingContext2D newCanvasRenderingContext2D()
{
	dynamic { return CanvasRenderingContext2D(); }
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

 */
