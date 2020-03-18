Trait {
	#name : #TPenBlocSizeStyle,
	#category : #'Penfeld-Bloc-Styles'
}

{ #category : #testing }
TPenBlocSizeStyle classSide >> isDeprecated [
	^ true
]

{ #category : #'styling - size' }
TPenBlocSizeStyle >> height: aValue [
	self component engineElement constraintsDo: [ :c |
		c vertical exact: aValue ] 
]

{ #category : #'styling - size' }
TPenBlocSizeStyle >> width: aValue [
	self component engineElement constraintsDo: [ :c |
		c horizontal exact: aValue ] 
]
