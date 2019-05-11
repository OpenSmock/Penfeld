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
