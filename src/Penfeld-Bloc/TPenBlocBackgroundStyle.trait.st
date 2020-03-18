Trait {
	#name : #TPenBlocBackgroundStyle,
	#category : #'Penfeld-Bloc-Styles'
}

{ #category : #testing }
TPenBlocBackgroundStyle classSide >> isDeprecated [
	^ true
]

{ #category : #'styling - background' }
TPenBlocBackgroundStyle >> backgroundColor: aValue [
	self component engineElement background: aValue
]

{ #category : #'styling - background' }
TPenBlocBackgroundStyle >> backgroundImage: aValue [
	self component engineElement background: aValue
]

{ #category : #styling }
TPenBlocBackgroundStyle >> backgroundPosition: aValue [
	| element |
	aValue = #center ifFalse: [ self flag: #toDo. ^ self ].
	element := self imageElement.
	element ifNil: [ ^ self ].
	element constraintsDo: [ :c |
		c horizontal alignCenter.
		c vertical alignCenter ]
]
