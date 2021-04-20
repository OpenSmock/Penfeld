Trait {
	#name : #TPenBlocMarginStyle,
	#category : #'Penfeld-Bloc-Styles'
}

{ #category : #testing }
TPenBlocMarginStyle classSide >> isDeprecated [
	^ true
]

{ #category : #'styling - margin' }
TPenBlocMarginStyle >> margin: aValue [
	| insets array |
	aValue isArray
	ifTrue: [ 
		array := aValue value.
		insets := array size = 2
		ifTrue: [ 
			BlInsets 
				top: array first value
				right: array second value
				bottom: array first value
				left: array second value
		] 
		ifFalse: [ array size = 3
			ifTrue: [ 
				BlInsets 
					top: array first value
					right: array second value
					bottom: array third value
					left: array second value
			]
			ifFalse: [ 
				BlInsets 
					top: array first value
					right: array second value
					bottom: array third value
					left: array fourth value
			]
		]
	]
	ifFalse: [ aValue isPixelValue
		ifTrue: [ insets := BlInsets all: aValue value ] ].
	self component engineElement margin: insets
]
