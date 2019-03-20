"
A CSSStylesheetParserTest is a test class for testing the behavior of CSSStylesheetParser
"
Class {
	#name : #CSSParserTest,
	#superclass : #PPCompositeParserTest,
	#category : #'CSS-Tests'
}

{ #category : #accessing }
CSSParserTest >> parserClass [
	^ CssParser 
]

{ #category : #'tests-background' }
CSSParserTest >> testBackgroundColor [
	| rule declaration |
	result := self parse: '.a { background-color: #123456; }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	
	self assert: declaration property equals: #backgroundColor.
	self assert: declaration value equals: (Color fromHexString: '123456'). 
	
]

{ #category : #'tests-border' }
CSSParserTest >> testBorder [
	| rule declaration value |
	result := self parse: '.a { border: 1px solid #123456; }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	
	self assert: declaration property equals: #border.
	value := declaration value.
	self assert: value class equals: CssArrayValue.
	self assert: (value includes: 1).
	self assert: (value includes: #solid).
	self assert: (value includes: (Color fromHexString: '123456')).
	
]

{ #category : #'tests-selectors' }
CSSParserTest >> testClassSelector [
	| rule selector |
	result := self parse: '.button {}'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations isEmpty.
	self assert: rule selectors size equals: 1.
	
	selector := rule selectors first.
	
	"Selector general tests"
	self assert: selector isSimpleSelector.
	self deny: selector matchesOnName.
	self deny: selector matchesOnId.
	self assert: selector pseudoClassCount equals: 0.
	
	"Selecor class tests"
	self assert: selector matchesOnStyleClass.
	self assert: selector styleClassCount equals: 1.
	self assert: selector styleClasses first equals: #button.
]

{ #category : #'tests-color' }
CSSParserTest >> testColorNames [
"HTML support 140 colors names: https://www.w3schools.com/colors/colors_names.asp"
	| rule declaration |
	result := self parse: '
		.a { color: white; }
		.b { color: black; }
		.c { color: red; }'.
	
	self assert: result rules size equals: 3.
	
	"White"
	rule := result rules first.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #color.
	self assert: declaration value equals: Color white. 
	
	"Black"
	rule := result rules second.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #color.
	self assert: declaration value equals: Color black. 
	
	"Red"
	rule := result rules third.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #color.
	self assert: declaration value equals: Color red. 
]

{ #category : #'tests-font' }
CSSParserTest >> testFontFamily [
	| rule declaration |
	result := self parse: 'a { font-family: "sans-serif"; }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #fontFamily.
	self assert: declaration value first equals: 'sans-serif'.
]

{ #category : #'tests-font' }
CSSParserTest >> testFontFamily3 [
	| rule declaration |
	result := self parse: 'a { font-family: "Century Gothic", "Arial", "sans-serif"; }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #fontFamily.
	self assert: declaration value first equals: 'Century Gothic'.
	self assert: declaration value second equals: 'Arial'.
	self assert: declaration value third equals: 'sans-serif'.
]

{ #category : #'tests-color' }
CSSParserTest >> testHexColor [
	| rule declaration |
	result := self parse: '.a { color: #123456; }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #color.
	self assert: declaration value equals: (Color fromHexString: '123456'). 
]

{ #category : #tests }
CSSParserTest >> testLength [
	| rule declaration |
	result := self parse: 'a { width: 30; height: 40; }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations size equals: 2.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #width.
	self assert: declaration value equals: 30. 
	
	declaration := rule declarations second.
	self assert: declaration property equals: #height.
	self assert: declaration value equals: 40. 
]

{ #category : #'tests-gradients' }
CSSParserTest >> testLinearGradient [
	| rule declaration function |
	result := self parse: 'a { color: linear-gradient(red, yellow); }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #color.
	
	function := (CssFunction value: #linearGradient) args: { Color red. Color yellow } asArray.
	self assert: declaration value equals: function. 
]

{ #category : #'tests-gradients' }
CSSParserTest >> testLinearGradientDiagonal [
	| rule declaration function |
	result := self parse: 'a { color: linear-gradient(to bottom right, red, yellow); }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #color.
	
	function := (CssFunction value: #linearGradient) args: 
		{ #( #to #bottom #right ).
		Color red. 
		Color yellow } asArray.
	self assert: declaration value equals: function. 
]

{ #category : #'tests-gradients' }
CSSParserTest >> testLinearGradientMultipleColorStops [
	| rule declaration function |
	result := self parse: 'a { color: linear-gradient(red, yellow, green); }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #color.
	
	function := (CssFunction value: #linearGradient) args: 
	{ 
		Color red. 
		Color yellow.
		Color green
	} asArray.
	self assert: declaration value equals: function.
]

{ #category : #'tests-gradients' }
CSSParserTest >> testLinearGradientMultipleColorStopsToRight [
	| rule declaration function |
	result := self parse: 'a { color: linear-gradient(to right, red,orange,yellow,green,blue,purple); }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #color.
	
	function := (CssFunction value: #linearGradient) args: {
		#(#to #right). 
		Color red. 
		Color orange.
		Color yellow.
		Color green.
		Color blue.
		Color purple
	} asArray.
	self assert: declaration value equals: function. 
]

{ #category : #'tests-gradients' }
CSSParserTest >> testLinearGradientRgba [
	| rule declaration function |
	result := self parse: 'a { color: linear-gradient(to right, rgba(255,0,0,0), rgba(255,0,0,1)); }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #color.
	
	function := (CssFunction value: #linearGradient) args: {
		#(#to #right).
		(CssFunction value: #rgba) args: { 255. 0. 0. 0 } asArray.
		(CssFunction value: #rgba) args: { 255. 0. 0. 1 } asArray
	} asArray.
	self assert: declaration value equals: function. 
]

{ #category : #'tests-gradients' }
CSSParserTest >> testLinearGradientToRight [
	| rule declaration function |
	result := self parse: 'a { color: linear-gradient(to right, red , yellow); }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #color.
	
	function := (CssFunction value: #linearGradient) args: {
		#(#to #right).
		Color red.
		Color yellow
	} asArray.
	self assert: declaration value equals: function. 
]

{ #category : #'tests-gradients' }
CSSParserTest >> testLinearGradientWithAngle [
	| rule declaration function |
	result := self parse: 'a { color: linear-gradient(-90deg, red, yellow); }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #color.
	
	function := (CssFunction value: #linearGradient) args: {
		{ -90. #deg } asArray.
		Color red.
		Color yellow
	} asArray.
	self assert: declaration value equals: function. 
]

{ #category : #'tests-selectors' }
CSSParserTest >> testNameSelector [
	| rule selector |
	result := self parse: 'body {}'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations isEmpty.
	self assert: rule selectors size equals: 1.
	
	selector := rule selectors first.
	
	"Selector general tests"
	self assert: selector isSimpleSelector.
	self deny: selector matchesOnStyleClass.
	self deny: selector matchesOnId.
	self assert: selector pseudoClassCount equals: 0.
	
	"Selecor class tests"
	self assert: selector matchesOnName.
	self assert: selector name equals: #body.
]

{ #category : #'tests-selectors' }
CSSParserTest >> testNamesSelector [
	| rule list |
	result := self parse: 'p, ul, li, td {}'.
	list := { #p. #ul. #li. #td }.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations isEmpty.
	self assert: rule selectors size equals: 4.
	
	rule selectors do: 
		[ :selector | 
	
		"Selector general tests"
		self assert: selector isSimpleSelector.
		self deny: selector matchesOnStyleClass.
		self deny: selector matchesOnId.
		self assert: selector pseudoClassCount equals: 0.
	
		"Selecor class tests"
		self assert: selector matchesOnName.
		list detect: [ :e | e = selector name ]
			ifFound: [ list := list reject: [ :e | e = selector name ] ]
			ifNone: [ self fail ]]
]

{ #category : #'tests-gradients' }
CSSParserTest >> testRadialGradient [
	| rule declaration function |
	result := self parse: 'a { color:  radial-gradient(red, yellow, green); }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #color.
	
	function := (CssFunction value: #radialGradient) args: { 
		Color red. 
		Color yellow.
		Color green
	} asArray.
	self assert: declaration value equals: function.
]

{ #category : #'tests-gradients' }
CSSParserTest >> testRadialGradientDifferentlySpaced [
	| rule declaration |
	result := self parse: 'a { color:  radial-gradient(red 5%, yellow 15%, green 60%); }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #color.
	self assert: declaration value equals: (Color fromHexString: '123456'). 
]

{ #category : #'tests-gradients' }
CSSParserTest >> testRadialGradientShape [
	| rule declaration |
	result := self parse: 'a { color:  radial-gradient(circle, red, yellow, green); }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #color.
	self assert: declaration value equals: (Color fromHexString: '123456'). 
]

{ #category : #'tests-gradients' }
CSSParserTest >> testRepeatingLinearGradient [
	| rule declaration function |
	result := self parse: 'a { color:  repeating-linear-gradient(red, yellow 10%, green 20%); }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #color.
	
	function := (CssFunction value: #repeatingLinearGradient) args: {
		Color red. 
		{ Color yellow. 0.1} asArray.
		{ Color green. 0.2} asArray
	} asArray.
	self assert: declaration value equals: function. 
]

{ #category : #'tests-gradients' }
CSSParserTest >> testRepeatingRadialGradient [
	| rule declaration |
	result := self parse: 'a { color: repeating-radial-gradient(red, yellow 10%, green 15%); }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #color.
	self assert: declaration value equals: (Color fromHexString: '123456'). 
]

{ #category : #'tests-color' }
CSSParserTest >> testRgbColor [
	| rule declaration |
	result := self parse: 'a { color: rgb(250, 99, 71); }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #color.
	self assert: declaration value equals: (Color r: 250 g: 99 b: 71 range: 255). 
]

{ #category : #'tests-color' }
CSSParserTest >> testRgbaColor [
	| rule declaration |
	result := self parse: 'a { color: rgba(250, 99, 71, 0.5); }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #color.
	self assert: declaration value equals: ((Color r: 250 g: 99 b: 71 range: 255) alpha: 0.5). 
]

{ #category : #'tests-text' }
CSSParserTest >> testTextAlign [
	| rule declaration value |
	result := self parse: '.a { text-align: center; }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations size equals: 1.
	
	declaration := rule declarations first.
	self assert: declaration property equals: #textAlign.
	self assert: declaration value equals: #center.
]

{ #category : #'tests-selectors' }
CSSParserTest >> testUniversalSelector [
	| rule selector |
	result := self parse: '* {}'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations isEmpty.
	self assert: rule selectors size equals: 1.
	
	selector := rule selectors first.
	
	"Selector general tests"
	self assert: selector isSimpleSelector.
	self deny: selector matchesOnStyleClass.
	self deny: selector matchesOnId.
	self assert: selector pseudoClassCount equals: 0.
	
	"Selecor class tests"
	self assert: selector name equals: #*.
]

{ #category : #'tests-selectors' }
CSSParserTest >> testWithPseudoClassSelector [
	| rule selector |
	result := self parse: '*:visited { }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations isEmpty.
	self assert: rule selectors size equals: 1.
	
	selector := rule selectors first.
	
	"Selector general tests"
	self assert: selector isSimpleSelector.
	self deny: selector matchesOnStyleClass.
	self deny: selector matchesOnId.
	self deny: selector matchesOnName.
	self assert: selector pseudoClassCount equals: 1.
	
	"Selecor class tests"
	self assert: selector name equals: #*.
	self assert: (selector pseudoClasses includes: #visited).
]

{ #category : #'tests-selectors' }
CSSParserTest >> testWithPseudoClassesSelector [
	| rule selector |
	result := self parse: 'a:visited:hover { }'.
	
	self assert: result rules size equals: 1.
	
	rule := result rules first.
	self assert: rule declarations isEmpty.
	self assert: rule selectors size equals: 1.
	
	selector := rule selectors first.
	
	"Selector general tests"
	self assert: selector isSimpleSelector.
	self deny: selector matchesOnStyleClass.
	self deny: selector matchesOnId.
	self assert: selector pseudoClassCount equals: 2.
	
	"Selecor class tests"
	self assert: selector name equals: #a.
	self assert: (selector pseudoClasses includes: #visited).
	self assert: (selector pseudoClasses includes: #hover).
]
