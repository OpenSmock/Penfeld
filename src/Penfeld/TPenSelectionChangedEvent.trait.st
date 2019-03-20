Trait {
	#name : #TPenSelectionChangedEvent,
	#category : #'Penfeld-Events'
}

{ #category : #'api - events' }
TPenSelectionChangedEvent >> onSelectionChangedDo: aBlock [
	self addCallback: aBlock for: PenEventSymbol selectionChanged
]

{ #category : #events }
TPenSelectionChangedEvent >> selectionChangedEvent [
	self eventBindings do: [ :eventBinding |
		(eventBinding symbol = PenEventSymbol selectionChanged)
			ifTrue: [ eventBinding callback value ]].
]
