Class {
	#name : #PenInput,
	#superclass : #PenInteractionElement,
	#category : #'Penfeld-Elements'
}

{ #category : #'api - events' }
PenInput >> onValueChangedDo: aBlock [
	self onEvent: PenEventSymbol valueChanged do: aBlock
]

{ #category : #accessing }
PenInput >> styleName [
	^ #input
]
