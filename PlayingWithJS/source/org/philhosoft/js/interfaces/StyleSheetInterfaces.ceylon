// http://dev.w3.org/csswg/cssom/

"Collection of media queries."
shared dynamic MediaList satisfies JSList<String>
{
	shared formal variable String mediaText;
	shared formal void appendMedium(String medium);
	shared formal void deleteMedium(String medium);
}

"A single style sheet. CSS style sheets will further implement the more specialized [[CSSStyleSheet]] interface."
shared dynamic StyleSheet
{
	"Style sheet language for this style sheet. "
	shared formal String type;

	"Location of the stylesheet."
	shared formal String? href;

	"Associates this style sheet with the current document."
	shared formal Node? ownerNode;

	"Returns a StyleSheet including this one, if any; returns null if there aren't any."
	shared formal StyleSheet? parentStyleSheet;

	"Advisory title of the current style sheet."
	shared formal String? title;

	"Intended destination medium for style information."
	shared formal MediaList media;

	"Whether the current stylesheet has been applied or not."
	shared formal variable Boolean disabled;
}

"A single CSS style sheet."
shared dynamic CSSStyleSheet satisfies StyleSheet
{
	"If this style sheet is imported into the document using an `@import` rule, this property will return that [[CSSImportRule]],
	 otherwise it returns null."
	shared formal CSSRule? ownerRule;

	"The CSS rules in the style sheet."
	shared formal CSSRuleList cssRules;

	"Inserts a new style rule into the current style sheet."
	shared formal void insertRule(
		"The rule to be inserted (selector and declaration)"
		String rule,
		"The position to be inserted"
		Integer index
	);

	"Deletes a rule from the style sheet."
	shared formal void deleteRule(Integer index);
}

shared dynamic StyleSheetList satisfies JSList<StyleSheet>
{
}

shared Integer \iSTYLE_RULE = 1;
shared Integer \iCHARSET_RULE = 2;
shared Integer \iIMPORT_RULE = 3;
shared Integer \iMEDIA_RULE = 4;
shared Integer \iFONT_FACE_RULE = 5;
shared Integer \iPAGE_RULE = 6;
shared Integer \iKEYFRAMES_RULE = 7;
shared Integer \iKEYFRAME_RULE = 8;
shared Integer \iMARGIN_RULE = 9;
shared Integer \iNAMESPACE_RULE = 10;
shared Integer \iCOUNTER_STYLE_RULE = 11;
shared Integer \iSUPPORTS_RULE = 12;
shared Integer \iDOCUMENT_RULE = 13;
shared Integer \iFONT_FEATURE_VALUES_RULE = 14;
shared Integer \iVIEWPORT_RULE = 15;
shared Integer \iREGION_STYLE_RULE = 16;

"Abstract, base CSS style rule."
shared dynamic CSSRule
{
	"One of the Type constants indicating the type of CSS rule."
	shared formal Integer type;

	"""Textual representation of the rule, e.g. `"h1,h2 { font-size: 16pt }"`"""
	shared formal variable String cssText;

	"Containing rule, otherwise null. Eg. if this rule is a style rule inside an `@media` block, the parent rule would be that [[CSSMediaRule]]."
	shared formal CSSRule? parentRule;

	"The CSSStyleSheet object for the style sheet that contains this rule."
	shared formal CSSStyleSheet? parentStyleSheet;
}

shared dynamic CSSRuleList satisfies JSList<CSSRule>
{
}

"Represents a style rule (rule set in CSS 2.1)."
shared dynamic CSSStyleRule satisfies CSSRule
{
	shared formal variable String selectorText;
	shared formal CSSStyleDeclaration style;
}

"Represents an `@import` at-rule."
shared dynamic CSSImportRule satisfies CSSRule
{
	"URL specified by the `@import` at-rule."
	shared formal String href;

	"Value of the media attribute of the associated CSS style sheet."
	shared formal MediaList media;

	"Associated CSS style sheet."
	shared formal CSSStyleSheet styleSheet;
}

"Represents an at-rule that contains other rules nested inside itself."
shared dynamic CSSGroupingRule satisfies CSSRule
{
	"Child CSS rules."
	shared formal CSSRuleList cssRules;

	"Returns the result of invoking insert a CSS rule [[rule]] into the child CSS rules at [[index]]."
	shared formal Integer insertRule(String rule, Integer index);

	"Removes a CSS rule from the child CSS rules at index."
	shared formal void deleteRule(Integer index);
}

"Represents an `@media` at-rule."
shared dynamic CSSMediaRule satisfies CSSRule
{
	"MediaList object for the list of media queries specified with the `@media` at-rule."
	shared formal MediaList media;
}

"Represents an `@page` at-rule."
shared dynamic CSSPageRule satisfies CSSRule
{
	"Result of serializing the associated list of CSS page selectors."
	shared formal String selectorText;

	"Style declaration of the `@page` at-rule."
	shared formal CSSStyleDeclaration style;
}

"Represents a margin at-rule (eg. `@top-left`) in an `@page` at-rule."
shared dynamic CSSMarginRule satisfies CSSRule
{
	"Name of the margin at-rule. The @ character is not included in the name."
	shared formal String name;

	"Style declaration of the margin at-rule."
	shared formal CSSStyleDeclaration style;
}

"Represents an `@namespace` at-rule."
shared dynamic CSSNamespaceRule satisfies CSSRule
{
	"Namespace of the `@namespace` at-rule. "
	shared formal variable String namespaceURI;

	"Prefix of the `@namespace` at-rule or the empty string if there is no prefix."
	shared formal variable String prefix;
}

"Represents CSS declaration block, a collection of CSS property-value pairs."
shared dynamic CSSStyleDeclaration satisfies JSList<String>
{
	"Textual representation of the declaration block. Setting this attribute changes the style."
	shared formal variable String cssText;

	"Containing [[CSSRule]]."
	shared formal CSSRule? parentRule;

	"""Shortcut for getPropertyValue("float") and setProperty("float", value)."""
	shared formal variable String cssFloat;

	"Returns the property value."
	shared formal String getPropertyValue(String name);

	"Returns the optional priority, `important`."
	shared formal String getPropertyPriority(String name);

	"""No return. Example: styleObj.setProperty("color", "red", "important")"""
	shared formal void setProperty(String name, String val = "", String priority = "");

	shared formal void setPropertyValue(String name, String val = "");

	shared formal void setPropertyPriority(String name, String priority = "");

	"Returns the value deleted."
	shared formal String removeProperty(String name);
}
