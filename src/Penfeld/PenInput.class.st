Class {
	#name : #PenInput,
	#superclass : #PenInteractionElement,
	#category : #'Penfeld-Elements'
}

{ #category : #'api - events' }
PenInput >> onValueChangedDo: aBlock [
	self whenEvent: PenEventSymbol valueChanged on: self do: aBlock
]

{ #category : #accessing }
PenInput >> styleName [
	^ #input
]
