Trait {
	#name : #TPenBlocFontStyle,
	#category : #'Penfeld-Bloc-Styles'
}

{ #category : #'styling - font' }
TPenBlocFontStyle >> color: aValue [
	| element |
	self ropedText foreground: aValue.
	
	self component icon ifNil: [ ^ self ].
	element := self component engineElement childNamed: #icon.
	element background: (self component icon repaintWith: aValue).
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
