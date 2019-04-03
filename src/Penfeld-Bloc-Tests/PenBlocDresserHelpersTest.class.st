Class {
	#name : #PenBlocDresserHelpersTest,
	#superclass : #TestCase,
	#instVars : [
		'dresser'
	],
	#category : #'Penfeld-Bloc-Tests'
}

{ #category : #tools }
PenBlocDresserHelpersTest >> gradient: aGradient1 equals: aGradient2 [
	aGradient1 start = aGradient2 start ifFalse: [ ^ false ].
	aGradient1 end = aGradient2 end ifFalse: [ ^ false ].
	
	1 to: aGradient1 stops size do: [ :i | | stop1 stop2 |
		stop1 := aGradient1 stops at: i.
		stop2 := aGradient2 stops at: i.
		stop1 key = stop2 key ifFalse: [ ^ false ].
		stop1 value = stop2 value ifFalse: [ ^ false ].
	].

	^ true
]

{ #category : #tests }
PenBlocDresserHelpersTest >> testLinearGradient [ 
	| function gradient expectedGradient |
	dresser := PenBlocDresser new.
	function := (StyleFunctionValue value: #linearGradient) args: { 
		StyleColorValue value: Color red. 
		StyleColorValue value: Color yellow 
	} asArray.
	
	gradient := dresser helperLinearGradient: function args.
	
	expectedGradient := (BlLinearGradientPaint direction: 0@1)
		stops: { 
			0.0 -> Color red.
			1.0 -> Color yellow
		}.
		
	self assert: (self gradient: gradient equals: expectedGradient)
	
]

{ #category : #tests }
PenBlocDresserHelpersTest >> testLinearGradientDiagonal [ 
	| function gradient expectedGradient |
	dresser := PenBlocDresser new.
	function := (StyleFunctionValue value: #linearGradient) args: { 
		StyleArrayValue value: {
			StyleSymbolValue value: #to.
			StyleSymbolValue value: #bottom.
			StyleSymbolValue value: #right. 
		} asArray.
		StyleColorValue value: Color red. 
		StyleColorValue value: Color yellow 
	} asArray.
	
	gradient := dresser helperLinearGradient: function args.
	
	expectedGradient := (BlLinearGradientPaint direction: 1@1)
		stops: { 
			0.0 -> Color red.
			1.0 -> Color yellow
		}.
		
	self assert: (self gradient: gradient equals: expectedGradient)
	
]

{ #category : #tests }
PenBlocDresserHelpersTest >> testLinearGradientMultipleColorStops [
	| function gradient expectedGradient |
	dresser := PenBlocDresser new.	
	function := (StyleFunctionValue value: #linearGradient) args: { 
		StyleArrayValue value: {
			StyleSymbolValue value: #to.
			StyleSymbolValue value: #right. 
		} asArray.
		StyleColorValue value: Color red. 
		StyleColorValue value: Color orange.
		StyleColorValue value: Color yellow. 
		StyleColorValue value: Color green.
		StyleColorValue value: Color blue. 
		StyleColorValue value: Color purple.
	} asArray.
	
	gradient := dresser helperLinearGradient: function args.
	
	expectedGradient := (BlLinearGradientPaint direction: 1@0)
		stops: { 
			0.0 -> Color red.
			0.2 -> Color orange.
			0.4 -> Color yellow.
			0.6 -> Color green.
			0.8 -> Color blue.
			1.0 -> Color purple.
		}.
	
	self assert: (self gradient: gradient equals: expectedGradient)
	
]

{ #category : #tests }
PenBlocDresserHelpersTest >> testLinearGradientRgba [
	| function gradient expectedGradient |
	dresser := PenBlocDresser new.	
	function := (StyleFunctionValue value: #linearGradient) args: {
		StyleArrayValue value: {
			StyleSymbolValue value: #to.
			StyleSymbolValue value: #right. 
		}.
		(StyleFunctionValue value: #rgba) args: {
			StyleNumberValue value: 0.
			StyleNumberValue value: 0.
			StyleNumberValue value: 0.
			StyleNumberValue value: 0.
		}. 
		(StyleFunctionValue value: #rgba) args: {
			StyleNumberValue value: 255.
			StyleNumberValue value: 0.
			StyleNumberValue value: 0.
			StyleNumberValue value: 1.
		}.
	}.
	
	gradient := dresser helperLinearGradient: function args.
	
	expectedGradient := (BlLinearGradientPaint direction: 1@0)
		stops: { 
			0.0 -> Color transparent.
			1.0 -> Color red.
		}.
	
	self assert: (self gradient: gradient equals: expectedGradient)
	
]

{ #category : #tests }
PenBlocDresserHelpersTest >> testLinearGradientWithAngle [
	| function gradient expectedGradient |
	dresser := PenBlocDresser new.	
	function := (StyleFunctionValue value: #linearGradient) args: {
		StyleArrayValue value: { 
			StyleNumberValue value: -90. 
			StyleSymbolValue value: #deg 
		}.
		StyleColorValue value: Color red.
		StyleColorValue value: Color yellow
	}.
	
	gradient := dresser helperLinearGradient: function args.
	
	expectedGradient := (BlLinearGradientPaint direction: -1@0)
		stops: { 
			0.0 -> Color red .
			1.0 -> Color yellow.
		}.
	
	self assert: (self gradient: gradient equals: expectedGradient)
	
]

{ #category : #tests }
PenBlocDresserHelpersTest >> testLinearGradientWithPercentage [
	| function gradient expectedGradient |
	dresser := PenBlocDresser new.
	function := (StyleFunctionValue value: #linearGradient) args: {
		StyleArrayValue value: { 
			StyleColorValue value: Color red. 
			StyleValue percent: 0 
		}.
		StyleArrayValue value: { 
			StyleColorValue value: Color orange. 
			StyleValue percent: 50
		}.
		StyleArrayValue value: { 
			StyleColorValue value: Color yellow. 
			StyleValue percent: 52
		}
	}.
	
	gradient := dresser helperLinearGradient: function args.
	
	expectedGradient := (BlLinearGradientPaint direction: 0@1)
		stops: { 
			0.0 -> Color red.
			0.5 -> Color orange.
			0.52 -> Color yellow.
			1.0 -> Color green.
		}.
	
	self assert: (self gradient: gradient equals: expectedGradient)
	
]

{ #category : #tests }
PenBlocDresserHelpersTest >> testRgb [
	| function color expectedColor |
	dresser := PenBlocDresser new.	
	function := (StyleFunctionValue value: #rgb) args: {
		StyleNumberValue value: 255.
		StyleNumberValue value: 0.
		StyleNumberValue value: 0.
	}.
	
	color := dresser helperRgb: function args.
	expectedColor := Color red.
	
	self assert: color equals: expectedColor 
	
]

{ #category : #tests }
PenBlocDresserHelpersTest >> testRgba [
	| function color expectedColor |
	dresser := PenBlocDresser new.	
	function := (StyleFunctionValue value: #rgba) args: {
		StyleNumberValue value: 50.
		StyleNumberValue value: 0.
		StyleNumberValue value: 50.
		StyleNumberValue value: 0.2.
	}.
	
	color := dresser helperRgba: function args.
	expectedColor := (Color r: 50 g: 0 b: 50 range: 255) alpha: 0.2.
	
	self assert: color equals: expectedColor 
	
]

{ #category : #tests }
PenBlocDresserHelpersTest >> testRgba2 [
	| function color expectedColor |
	dresser := PenBlocDresser new.	
	function := (StyleFunctionValue value: #rgba) args: {
		StyleNumberValue value: 255.
		StyleNumberValue value: 0.
		StyleNumberValue value: 0.
		StyleNumberValue value: 1.
	}.
	
	color := dresser helperRgba: function args.
	expectedColor := Color red.
	
	self assert: color equals: expectedColor 
	
]

{ #category : #tests }
PenBlocDresserHelpersTest >> testRgbaTransparent [
	| function color expectedColor |
	dresser := PenBlocDresser new.	
	function := (StyleFunctionValue value: #rgba) args: {
		StyleNumberValue value: 0.
		StyleNumberValue value: 0.
		StyleNumberValue value: 0.
		StyleNumberValue value: 0.
	}.
	
	color := dresser helperRgba: function args.
	expectedColor := Color transparent.
	
	self assert: color value equals: expectedColor 
	
]
