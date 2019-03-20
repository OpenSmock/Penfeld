Class {
	#name : #PenInput,
	#superclass : #PenInteractionElement,
	#traits : 'TPenValueChangedEvent',
	#classTraits : 'TPenValueChangedEvent classTrait',
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenInput >> styleName [
	^ #input
]

{ #category : #events }
PenInput >> valueChangedEvent [
	self eventBindings do: [ :eventBinding |
		(eventBinding symbol = PenEventSymbol valueChanged)
			ifTrue: [ eventBinding callback value ]].
]
