Trait {
	#name : #TPenBlocBackgroundStyle,
	#category : #'Penfeld-Bloc-Styles'
}

{ #category : #styling }
TPenBlocBackgroundStyle >> backgroundColor: aValue [
	self model engineElement background: aValue
]

{ #category : #styling }
TPenBlocBackgroundStyle >> backgroundImage: aValue [
	self model engineElement background: aValue
]
