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
	function := (PssFunctionValue value: #linearGradient) args: { 
		PssFunctionValue value: Color red. 
		PssFunctionValue value: Color yellow 
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
	function := (PssFunctionValue value: #linearGradient) args: { 
		PssArrayValue value: {
			PssSymbolValue value: #to.
			PssSymbolValue value: #bottom.
			PssSymbolValue value: #right. 
		} asArray.
		PssColorValue value: Color red. 
		PssColorValue value: Color yellow 
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
	function := (PssFunctionValue value: #linearGradient) args: { 
		PssArrayValue value: {
			PssSymbolValue value: #to.
			PssSymbolValue value: #right. 
		} asArray.
		PssColorValue value: Color red. 
		PssColorValue value: Color orange.
		PssColorValue value: Color yellow. 
		PssColorValue value: Color green.
		PssColorValue value: Color blue. 
		PssColorValue value: Color purple.
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
	function := (PssFunctionValue value: #linearGradient) args: {
		PssArrayValue value: {
			PssSymbolValue value: #to.
			PssSymbolValue value: #right. 
		}.
		(PssFunctionValue value: #rgba) args: {
			PssNumberValue value: 0.
			PssNumberValue value: 0.
			PssNumberValue value: 0.
			PssNumberValue value: 0.
		}. 
		(PssFunctionValue value: #rgba) args: {
			PssNumberValue value: 255.
			PssNumberValue value: 0.
			PssNumberValue value: 0.
			PssNumberValue value: 1.
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
	function := (PssFunctionValue value: #linearGradient) args: {
		PssArrayValue value: { 
			PssNumberValue value: -90. 
			PssSymbolValue value: #deg 
		}.
		PssColorValue value: Color red.
		PssColorValue value: Color yellow
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
	function := (PssFunctionValue value: #linearGradient) args: {
		PssArrayValue value: { 
			PssColorValue value: Color red. 
			PssValue percent: 0 
		}.
		PssArrayValue value: { 
			PssColorValue value: Color orange. 
			PssValue percent: 50
		}.
		PssArrayValue value: { 
			PssColorValue value: Color yellow. 
			PssValue percent: 52
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
	function := (PssFunctionValue value: #rgb) args: {
		PssNumberValue value: 255.
		PssNumberValue value: 0.
		PssNumberValue value: 0.
	}.
	
	color := dresser helperRgb: function args.
	expectedColor := Color red.
	
	self assert: color equals: expectedColor 
	
]

{ #category : #tests }
PenBlocDresserHelpersTest >> testRgba [
	| function color expectedColor |
	dresser := PenBlocDresser new.	
	function := (PssFunctionValue value: #rgba) args: {
		PssNumberValue value: 50.
		PssNumberValue value: 0.
		PssNumberValue value: 50.
		PssNumberValue value: 0.2.
	}.
	
	color := dresser helperRgba: function args.
	expectedColor := (Color r: 50 g: 0 b: 50 range: 255) alpha: 0.2.
	
	self assert: color equals: expectedColor 
	
]

{ #category : #tests }
PenBlocDresserHelpersTest >> testRgba2 [
	| function color expectedColor |
	dresser := PenBlocDresser new.	
	function := (PssFunctionValue value: #rgba) args: {
		PssNumberValue value: 255.
		PssNumberValue value: 0.
		PssNumberValue value: 0.
		PssNumberValue value: 1.
	}.
	
	color := dresser helperRgba: function args.
	expectedColor := Color red.
	
	self assert: color equals: expectedColor 
	
]

{ #category : #tests }
PenBlocDresserHelpersTest >> testRgbaTransparent [
	| function color expectedColor |
	dresser := PenBlocDresser new.	
	function := (PssFunctionValue value: #rgba) args: {
		PssNumberValue value: 0.
		PssNumberValue value: 0.
		PssNumberValue value: 0.
		PssNumberValue value: 0.
	}.
	
	color := dresser helperRgba: function args.
	expectedColor := Color transparent.
	
	self assert: color value equals: expectedColor 
	
]
