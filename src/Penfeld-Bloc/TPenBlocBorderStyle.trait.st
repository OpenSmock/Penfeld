Trait {
	#name : #TPenBlocBorderStyle,
	#category : #'Penfeld-Bloc-Styles'
}

{ #category : #testing }
TPenBlocBorderStyle classSide >> isDeprecated [
	^ true
]

{ #category : #'styling - border' }
TPenBlocBorderStyle >> border: aValue [
	| borderBuilder |	
	borderBuilder := BlBorderBuilder new.
	
	aValue do: 
	[ :property | 
		property value isNumber 
		ifTrue: [ borderBuilder width: property ] 
		ifFalse: 
		[
			property value isSymbol
			ifTrue: 
			[ 
				(borderBuilder respondsTo: property value) 
				ifTrue: [ borderBuilder perform: property value ]
				ifFalse: 
				[
					(property isKindOf: PssValue)
					ifTrue: 
					[ 
						"Linear gradient" 
						| paint |
						paint := self performFunction: property.
						paint value class = Color ifFalse: [ paint end: paint end * (self component width pref @ self component height pref) ].
						borderBuilder paint: paint
					]
				]
			]
			ifFalse: 
			[ 
				(property value isKindOf: Color)
				ifTrue: [ borderBuilder paint: property ]
				ifFalse: [ self notYetImplemented ]
			]
		]
	].
	
	self component engineElement border: borderBuilder build.
]

{ #category : #'styling - border' }
TPenBlocBorderStyle >> borderRadius: aValue [
	| radius |
	aValue class = PssPercentValue 
		ifTrue: [ self component size 
			ifNil: [ ^ self ]
			ifNotNil: [ | minLength |
				minLength := self component size x pref min: self component size y pref.
				radius := (aValue value * minLength) rounded] ]
		ifFalse: [ radius := aValue value ].
	self component engineElement geometry: (BlRectangle cornerRadius: radius)
]
