shared dynamic MediaList
{

}

"A single style sheet. CSS style sheets will further implement the more specialized [[CSSStyleSheet]] interface."
shared dynamic StyleSheet
{
	"Whether the current stylesheet has been applied or not."
	shared formal variable Boolean disabled;

	"Location of the stylesheet."
	shared formal String href;

	"Intended destination medium for style information."
	shared formal MediaList media;

	"Associates this style sheet with the current document."
	shared formal Node ownerNode;

	"Returns a StyleSheet including this one, if any; returns null if there aren't any."
	shared formal StyleSheet? parentStyleSheet;

	"Advisory title of the current style sheet."
	shared formal String title;

	"Style sheet language for this style sheet. "
	shared formal String type;
}

"A single CSS style sheet."
shared dynamic CSSStyleSheet satisfies StyleSheet
{
	"The CSS rules in the style sheet."
	shared formal CSSRuleList cssRules;

	"If this style sheet is imported into the document using an `@import` rule, this property will return that [[CSSImportRule]],
	 otherwise it returns null."
	shared formal CSSImportRule? ownerRule;

	"Deletes a rule from the style sheet."
	shared formal void deleteRule(Integer index);

	"Inserts a new style rule into the current style sheet."
	shared formal void insertRule(
		"The rule to be inserted (selector and declaration)"
		String rule,
		"The position to be inserted"
		Integer index
	);
}

shared Integer \iSTYLE_RULE = 1;
shared Integer \iCHARSET_RULE = 2;
shared Integer \iIMPORT_RULE = 3;
shared Integer \iMEDIA_RULE = 4;
shared Integer \iFONT_FACE_RULE = 5;
shared Integer \iPAGE_RULE = 6;
shared Integer \iKEYFRAMES_RULE = 7;
shared Integer \iKEYFRAME_RULE = 8;
shared Integer \iNAMESPACE_RULE = 10;
shared Integer \iCOUNTER_STYLE_RULE = 11;
shared Integer \iSUPPORTS_RULE = 12;
shared Integer \iDOCUMENT_RULE = 13;
shared Integer \iFONT_FEATURE_VALUES_RULE = 14;
shared Integer \iVIEWPORT_RULE = 15;
shared Integer \iREGION_STYLE_RULE = 16;

shared dynamic CSSRule
{
	"One of the Type constants indicating the type of CSS rule."
	shared formal Integer type;

	"Textual representation of the rule, e.g. `\"h1,h2 { font-size: 16pt }\"`"
	shared formal variable String cssText;

	"Containing rule, otherwise null. Eg. if this rule is a style rule inside an `@media` block, the parent rule would be that [[CSSMediaRule]]."
	shared formal CSSRule? parentRule;

	"The CSSStyleSheet object for the style sheet that contains this rule."
	shared formal CSSStyleSheet? parentStyleSheet;
}

shared dynamic CSSRuleList
{
	shared formal Integer length;
	shared formal CSSRule? item(Integer index);
}

shared dynamic CSSStyleRule satisfies CSSRule
{
	shared formal variable String selectorText;
	shared formal CSSStyleDeclaration style;
}

shared dynamic CSSImportRule
{

}

shared dynamic CSSMediaRule
{

}
shared dynamic CSSValue
{

}
shared dynamic CSSPrimitiveValue satisfies CSSValue
{

}

"Represents a collection of CSS property-value pairs."
shared dynamic CSSStyleDeclaration
{
	"Textual representation of the declaration block. Setting this attribute changes the style."
	shared formal variable String cssText;

	"Number of properties."
	shared formal Integer length;

	"Containing [[CSSRule]]."
	shared formal CSSRule parentRule;

	"Returns the optional priority, `important`."
	shared formal String getPropertyPriority(String name);
	"Returns the property value."
	shared formal String getPropertyValue(String name);
	"Returns a property name."
	shared formal String item(Integer index);
	"Returns the value deleted."
	shared formal String removeProperty(String name);
	"""No return. Example: styleObj.setProperty("color", "red", "important")"""
	shared formal void setProperty(String name, String val, String priority);
	"""Only supported via getComputedStyle. Returns an CSSPrimitiveValue which implements CSSValue),
	   or null for Shorthand properties. Example: cssString = window.getComputedStyle(elem, null).getPropertyCSSValue("color").cssText;"""
	shared formal CSSPrimitiveValue? getPropertyCSSValue();
}

