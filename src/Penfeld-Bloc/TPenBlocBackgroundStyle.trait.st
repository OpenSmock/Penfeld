Trait {
	#name : #TPenBlocBackgroundStyle,
	#category : #'Penfeld-Bloc-Styles'
}

{ #category : #styling }
TPenBlocBackgroundStyle >> backgroundColor: aValue [
	self component engineElement background: aValue
]

{ #category : #styling }
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
