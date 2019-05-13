Trait {
	#name : #TPenBlocSizeStyle,
	#category : #'Penfeld-Bloc-Styles'
}

{ #category : #'accessing structure variables' }
TPenBlocSizeStyle >> height: aValue [
	self component engineElement constraintsDo: [ :c |
		c vertical exact: aValue ] 
]

{ #category : #'accessing structure variables' }
TPenBlocSizeStyle >> width: aValue [
	self component engineElement constraintsDo: [ :c |
		c horizontal exact: aValue ] 
]
