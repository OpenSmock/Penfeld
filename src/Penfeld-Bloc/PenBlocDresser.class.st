Class {
	#name : #PenBlocDresser,
	#superclass : #PenDresser,
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocDresser >> background: aModel on: aComponent [
	"Default application of background"
	self background: aModel onBl: aComponent engineElement.
	
]

{ #category : #styling }
PenBlocDresser >> background: aModel onBl: anElement [
	aModel hasPaint
		ifTrue: [ 
			aModel hasImage 
				ifTrue: [ self buildCompositeBackground: aModel onBl: anElement ]
				ifFalse: [ self buildPaintBackground: aModel onBl: anElement ] ]
		ifFalse: [ 
			aModel hasImage 
				ifTrue: [ self buildImageBackground: aModel onBl: anElement ] ]
]

{ #category : #styling }
PenBlocDresser >> border: aModel on: aComponent [
	"Default application of border"
	self border: aModel onBl: aComponent engineElement.
	
]

{ #category : #styling }
PenBlocDresser >> border: aModel onBl: anElement [
	aModel allSidesAreUniform
		ifTrue: [ self buildBorder: aModel all onBl: anElement ]
		ifFalse: [ '<< border >> aModel is not uniform: not yet supported' ]
]

{ #category : #styling }
PenBlocDresser >> borderRadius: aModel on: aComponent [
	aModel allCornersAreUniform ifTrue: [ aComponent engineElement geometry: (BlRectangle cornerRadius: aModel allCorners value) ]
	
	
]

{ #category : #'private - styling' }
PenBlocDresser >> buildBorder: aBorderModel onBl: anElement [
	| builder paint |
	builder := BlBorderBuilder new
		paint: aBorderModel color asBlPaint;
		width: aBorderModel width value.
	anElement border: builder build
		
]

{ #category : #'private - styling' }
PenBlocDresser >> buildCompositeBackground: aModel onBl: anElement [
	self flag: #toDo
]

{ #category : #'private - styling' }
PenBlocDresser >> buildImageBackground: aModel onBl: anElement [
	aModel image isGradient ifFalse: [ self flag: #toDo. ^ self ].
	anElement background: aModel image asBlPaint.
]

{ #category : #'private - styling' }
PenBlocDresser >> buildPaintBackground: aModel onBl: anElement [
	anElement background: aModel color asBlBackground
]

{ #category : #dressing }
PenBlocDresser >> dress [ 
	self component key = #radarMenuRadio ifTrue: [ ('Value of radarMenuRadio before dress: ', self component value printString) traceCr ].
	super dress.
	self component key = #radarMenuRadio ifTrue: [ ('Value of radarMenuRadio after dress: ', self component value printString) traceCr ].
	self component engineElement invalidate.
	self component key = #radarMenuRadio ifTrue: [ self component engineElement background paint stops first printString traceCr ]
]

{ #category : #accessing }
PenBlocDresser >> dressersMap [ 
	^ PenBlocDressersMap get
]

{ #category : #accessing }
PenBlocDresser >> eventStrategy [
	^ PenBlocEventStrategy
]

{ #category : #styling }
PenBlocDresser >> font: aModel on: aComponent [
	"Default application of font"
	self font: aModel onBl: aComponent engineElement.
]

{ #category : #styling }
PenBlocDresser >> font: aModel onBl: anElement [
	"Default application of font"
	| textElement |
	textElement := anElement 
		childNamed: #text 
		ifFound: [ :child | child ]
		ifNone: [ '<< text >> There is no textElement initialized.' record. ^ self ].
		
	"font-family"
	textElement text fontName: aModel family value.
	
	"font-size"
	textElement text fontSize: aModel size value.
	
	"font-weight"
	textElement text perform: aModel weight value.
]

{ #category : #styling }
PenBlocDresser >> height: aModel on: aComponent [
	"Default application of height"
	self height: aModel onBl: aComponent engineElement.
]

{ #category : #styling }
PenBlocDresser >> height: aModel onBl: anElement [
	anElement height: aModel value.
]

{ #category : #helpers }
PenBlocDresser >> helperIcon: args [
	^ (self class environment at: args first value) perform: args second value
]

{ #category : #helpers }
PenBlocDresser >> helperLinearGradient: args [
	| stops direction minIndexColor maxIndexColor factor stop |
	stops := OrderedCollection new.
	
	minIndexColor := 1.
	maxIndexColor := args size.
	
	factor := (1 / (maxIndexColor - minIndexColor)) asFloat.
	
	args withIndexDo: 
	[ :arg :index |
		stop := ((index - minIndexColor) * factor) round: 2.
		
		arg value isColor 
		ifTrue: [ 
			"Color without stop"
			stops add: stop -> arg value.
		]
		ifFalse: [ 
			arg value isArray
			ifTrue: [ 
				arg first value isColor 
				ifTrue: [ 
					"Color with stop"
					stops add: ((arg second value asFloat round: 2) -> arg first value)
				]
				ifFalse: [ 
					(arg first value = #rgb or: [ arg first value = #rgba ])
					ifTrue: [ 
						stops add: ((arg second value asFloat round: 2) -> (self getColor: arg first))
					]
					ifFalse: [ 
						"Update factor"
						minIndexColor := minIndexColor + 1.
						factor := (1 / (maxIndexColor - minIndexColor)) asFloat.
					
						arg first = #to 
						ifTrue: [ 
							"Direction"
							direction := 0@0.
							arg allButFirstDo: [ :e |
								e = #bottom ifTrue: [ direction := direction + (0@1) ].
								e = #top ifTrue: [ direction := direction + (0@ -1) ].
								e = #left ifTrue: [ direction := direction + (-1 @ 0) ].
								e = #right ifTrue: [ direction := direction + (1 @ 0) ].
							] 
						]
						ifFalse: [ | angle |
							"Direction with angle"
							arg second = #deg ifTrue: [ 
								"Angle in degree"
								angle := arg first degreesToRadians.
								direction := angle sin @ angle cos.
							]
						]
					]
				]
			]
			ifFalse: [ 
				"Gradient without stop"
				stops add: (stop -> (self getColor: arg))
			]
		]
	].

	"Default direction is top to bottom"
	direction ifNil: [ direction := 0@1 ].

	^ (BlLinearGradientPaint direction: direction) stops: stops
]

{ #category : #helpers }
PenBlocDresser >> helperRgb: args [
	^ PssColorValue value: (Color 
		r: args first 
		g: args second 
		b: args third 
		range: 255)
]

{ #category : #helpers }
PenBlocDresser >> helperRgba: args [
	^ PssColorValue value: ((Color 
		r: args first 
		g: args second 
		b: args third 
		range: 255) 
		alpha: args fourth value)
]

{ #category : #dressing }
PenBlocDresser >> hide [
	self component engineElement visibility: BlVisibility hidden.
]

{ #category : #dressing }
PenBlocDresser >> hide: aComponent [
	aComponent engineElement visibility: BlVisibility hidden.
]

{ #category : #styling }
PenBlocDresser >> margin: aModel onBl: anElement [
	"Default application of margin"
	self flag: #toDo
]

{ #category : #styling }
PenBlocDresser >> outline: aModel on: aComponent [
	| outline |
	outline := BlElement new.
	self outline: aModel onBl: outline.
	aComponent engineElement addChildFirst: outline as: #outline. 
]

{ #category : #styling }
PenBlocDresser >> outline: aModel onBl: anElement [
	""
]

{ #category : #styling }
PenBlocDresser >> position: aModel on: aComponent [
	"Default application of position"
	self position: aModel onBl: aComponent engineElement.
	
]

{ #category : #styling }
PenBlocDresser >> position: aModel onBl: anElement [
	aModel position apply: aModel onBl: anElement
]

{ #category : #dressing }
PenBlocDresser >> show [
	self component engineElement visibility: BlVisibility visible.
]

{ #category : #dressing }
PenBlocDresser >> show: aComponent [
	aComponent engineElement visibility: BlVisibility visible.
]

{ #category : #styling }
PenBlocDresser >> text: aModel on: aComponent [
	"Default application of text"
	self text: aModel onBl: aComponent engineElement.
]

{ #category : #styling }
PenBlocDresser >> text: aModel onBl: anElement [
	| textElement |
	textElement := anElement 
		childNamed: #text 
		ifFound: [ :child | child ]
		ifNone: [ '<< text >> There is no textElement initialized.' record. ^ self].
		
	"text-align"
	aModel align apply: aModel onBl: textElement.
	
	"color"
	textElement text foreground: aModel color value.
]

{ #category : #styling }
PenBlocDresser >> width: aModel on: aComponent [
	"Default application of width"
	self width: aModel onBl: aComponent engineElement.
]

{ #category : #styling }
PenBlocDresser >> width: aModel onBl: anElement [
	anElement width: aModel value.
]
