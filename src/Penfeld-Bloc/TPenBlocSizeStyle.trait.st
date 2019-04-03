Trait {
	#name : #TPenBlocSizeStyle,
	#category : #'Penfeld-Bloc-Styles'
}

{ #category : #'accessing structure variables' }
TPenBlocSizeStyle >> height: aValue [
	self component engineElement height: aValue
]

{ #category : #'accessing structure variables' }
TPenBlocSizeStyle >> width: aValue [
	self component engineElement width: aValue
]
