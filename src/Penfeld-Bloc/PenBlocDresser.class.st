Class {
	#name : #PenBlocDresser,
	#superclass : #PenDresser,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #opening }
PenBlocDresser class >> spaceBackground [
	^ Color r: 128 g: 128 b: 128 range: 255
]

{ #category : #accessing }
PenBlocDresser >> dressersMap [ 
	^ PenBlocBasicDressersMap new
]

{ #category : #accessing }
PenBlocDresser >> eventStrategy [
	^ PenBlocEventStrategy new
]

{ #category : #helpers }
PenBlocDresser >> helperLinearGradient: args [
	| colors frac stops direction |
	colors := OrderedCollection new.
	frac := OrderedCollection new.
	
	args do: [ :arg |
		arg isColor 
			ifTrue: [ colors add: arg ]
			ifFalse: [ 
				arg isArray
				ifTrue: [ 
					arg first isSymbol ifTrue: 
					[ 
						direction := 0@0.
						arg do: [ :e |
							e = #bottom ifTrue: [ direction := direction + (0@1) ].
							e = #top ifTrue: [ direction := direction + (0@ -1) ].
							e = #left ifTrue: [ direction := direction + (-1 @ 0) ].
							e = #right ifTrue: [ direction := direction + (1 @ 0) ].
						] 
					].
					arg first isNumber ifTrue: [ | angle |
						"Angle direction"
						arg second = #deg ifTrue: [ 
							"Angle in degree"
							angle := arg first degreesToRadians.
							direction := angle sin @ angle cos.
						]
					].
					arg first isArray ifTrue: [ | colorStop |
						"Color with stop"
						colorStop := arg first.
						colors add: colorStop first value.
						frac add: colorStop second value asFloat.
					]
				]
				ifFalse: [ arg isFunction ifTrue: [ colors add: (self performFunction: arg) ] ] 
			]
	].

	frac isEmpty ifTrue: [ | div |
		div := 1 / (colors size - 1).
		frac := 0 to: 1 by: div asFloat.
		frac := frac collect: [ :e | e round: 2 ]
	].

	stops := colors withIndexCollect: [ 
		:color :i |
		(frac at: i) -> color
	].

	"Default direction is top to bottom"
	direction ifNil: [ direction := 0@1 ].

	^ (BlLinearGradientPaint direction: direction) stops: stops
]

{ #category : #helpers }
PenBlocDresser >> helperRgb: args [
	^ StyleColorValue value: (Color 
		r: args first 
		g: args second 
		b: args third 
		range: 255)
]

{ #category : #helpers }
PenBlocDresser >> helperRgba: args [
	^ StyleColorValue value: ((Color 
		r: args first 
		g: args second 
		b: args third range: 255) 
		alpha: args fourth value)
]
