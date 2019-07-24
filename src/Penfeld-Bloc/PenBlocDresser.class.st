Class {
	#name : #PenBlocDresser,
	#superclass : #PenDresser,
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #accessing }
PenBlocDresser >> dressersMap [ 
	^ PenBlocDressersMap new
]

{ #category : #accessing }
PenBlocDresser >> eventStrategy [
	^ PenBlocEventStrategy new
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
PenBlocDresser >> show [
	self component engineElement visibility: BlVisibility visible.
]
