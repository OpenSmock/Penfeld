Trait {
	#name : #TPenValueChangedEvent,
	#category : #'Penfeld-Events'
}

{ #category : #'API - events' }
TPenValueChangedEvent >> onValueChangedDo: aBlock [
	self onEvent: PenEventSymbol valueChanged do: aBlock
]

{ #category : #'API - events' }
TPenValueChangedEvent >> onValueChangedPerform: aSymbol on: aReceiver [
	self onEvent: PenEventSymbol valueChanged perform: aSymbol on: aReceiver
]

{ #category : #'API - events' }
TPenValueChangedEvent >> valueChangedEvent [
	self eventBindings do: [ :eventBinding |
		(eventBinding symbolMatches: PenEventSymbol valueChanged)
			ifTrue: [ eventBinding executeCallback ]].
]
