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
	function := (StyleFunction value: #linearGradient) args: { Color red. Color yellow } asArray.
	
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
	function := (StyleFunction value: #linearGradient) args: 
		{ #( #to #bottom #right ).
		Color red. 
		Color yellow } asArray.
	
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
	function := (StyleFunction value: #linearGradient) args: { 
		#(#to #right). 
		Color red. 
		Color orange.
		Color yellow.
		Color green.
		Color blue.
		Color purple
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
	function := (StyleFunction value: #linearGradient) args: {
		#(#to #right).
		(StyleFunction value: #rgba) args: { 0. 0. 0. 0 } asArray.
		(StyleFunction value: #rgba) args: { 255. 0. 0. 1 } asArray
	} asArray.
	
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
	function := (StyleFunction value: #linearGradient) args: {
		{ -90. #deg } asArray.
		Color red.
		Color yellow
	} asArray.
	
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
	function := (StyleFunction value: #linearGradient) args: {
		StyleColorValue value: Color red. 
		{ { StyleColorValue value: Color orange. StyleValue percent: 50 } asArray } asArray.
		{ { StyleColorValue value: Color yellow. StyleValue percent: 52 } asArray } asArray.
		StyleColorValue value: Color green.
	} asArray.
	
	gradient := dresser helperLinearGradient: function args.
	
	expectedGradient := (BlLinearGradientPaint direction: 1@0)
		stops: { 
			0.0 -> Color red.
			0.5 -> Color orange.
			0.52 -> Color yellow.
			1.0 -> Color green.
		}.
	
	self assert: gradient equals: expectedGradient 
	
]
