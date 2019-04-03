Trait {
	#name : #TPenBlocBorderStyle,
	#category : #'Penfeld-Bloc-Styles'
}

{ #category : #styling }
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
					(property isKindOf: StyleValue)
					ifTrue: 
					[ 
						"Linear gradient" 
						| paint |
						paint := self performFunction: property.
						paint end: paint end * (self component width pref @ self component height pref).
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
