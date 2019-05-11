Class {
	#name : #PenInput,
	#superclass : #PenInteractionElement,
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenInput class >> styleName [
	^ #input
]

{ #category : #'api - events' }
PenInput >> onValueChangedDo: aBlock [
	self onEvent: PenEventSymbol valueChanged do: aBlock
]
