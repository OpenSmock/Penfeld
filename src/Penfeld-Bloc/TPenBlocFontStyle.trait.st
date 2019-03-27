Trait {
	#name : #TPenBlocFontStyle,
	#category : #'Penfeld-Bloc-Styles'
}

{ #category : #styling }
TPenBlocFontStyle >> color: aValue [
	self ropedText foreground: aValue
]

{ #category : #styling }
TPenBlocFontStyle >> fontFamily: aValue [
	self ropedText fontName: aValue first.
]

{ #category : #styling }
TPenBlocFontStyle >> fontSize: aValue [
	self ropedText fontSize: aValue value
]

{ #category : #styling }
TPenBlocFontStyle >> fontWeight: aValue [
	| symbol |
	symbol := aValue value.
	(self ropedText respondsTo: symbol)
		ifTrue: [ self ropedText perform: symbol ]
		ifFalse: [ self halt: 'todo' ]
]

{ #category : #accessing }
TPenBlocFontStyle >> ropedText [
	self explicitRequirement
]
