Trait {
	#name : #TPenBlocFontStyle,
	#category : #'Penfeld-Bloc-Styles'
}

{ #category : #testing }
TPenBlocFontStyle classSide >> isDeprecated [
	^ true
]

{ #category : #'styling - font' }
TPenBlocFontStyle >> color: aValue [
	self ropedText foreground: aValue
]

{ #category : #'styling - font' }
TPenBlocFontStyle >> fontFamily: aValue [
	self ropedText fontName: aValue value.
]

{ #category : #'styling - font' }
TPenBlocFontStyle >> fontSize: aValue [
	self ropedText fontSize: aValue value
]

{ #category : #'styling - font' }
TPenBlocFontStyle >> fontStyle: aValue [
	| symbol |
	symbol := aValue value.
	(self ropedText respondsTo: symbol)
		ifTrue: [ self ropedText perform: symbol ]
]

{ #category : #'styling - font' }
TPenBlocFontStyle >> fontWeight: aValue [
	| symbol |
	symbol := aValue value.
	(self ropedText respondsTo: symbol)
		ifTrue: [ self ropedText perform: symbol ]
]

{ #category : #'accessing - font' }
TPenBlocFontStyle >> ropedText [
	self explicitRequirement
]
