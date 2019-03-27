Class {
	#name : #PenBlocDresserHelpers,
	#superclass : #TestCase,
	#instVars : [
		'dresser'
	],
	#category : #'Penfeld-Bloc-Tests'
}

{ #category : #setup }
PenBlocDresserHelpers >> setUp [ 
	dresser := PenBlocDresser new
]

{ #category : #tests }
PenBlocDresserHelpers >> testLinearGradient [ 
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
		
	self assert: gradient equals: expectedGradient 
	
]

{ #category : #tests }
PenBlocDresserHelpers >> testLinearGradientDiagonal [ 
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
		
	self assert: gradient equals: expectedGradient 
	
]

{ #category : #tests }
PenBlocDresserHelpers >> testLinearGradientMultipleColorStops [
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
	
	self assert: gradient equals: expectedGradient 
	
]

{ #category : #tests }
PenBlocDresserHelpers >> testLinearGradientRgba [
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
	
	self assert: gradient equals: expectedGradient 
	
]

{ #category : #tests }
PenBlocDresserHelpers >> testLinearGradientWithAngle [
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
	
	self assert: gradient equals: expectedGradient 
	
]

{ #category : #tests }
PenBlocDresserHelpers >> testLinearGradientWithPercentage [
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
	
	self assert: gradient equals: expectedGradient 
	
]
