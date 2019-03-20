Trait {
	#name : #TPenValueChangedEvent,
	#category : #'Penfeld-Events'
}

{ #category : #'api - events' }
TPenValueChangedEvent >> onValueChangedDo: aBlock [
	self addCallback: aBlock for: PenEventSymbol valueChanged
]

{ #category : #events }
TPenValueChangedEvent >> valueChangedEvent [
	self callbacks do: [ :eventBinding |
		(eventBinding symbol = PenEventSymbol valueChanged)
			ifTrue: [ eventBinding callback value ]].
]
