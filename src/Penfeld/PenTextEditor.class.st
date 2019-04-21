Class {
	#name : #PenTextEditor,
	#superclass : #PenInteractionElement,
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenTextEditor >> editor [ 	
	^dresser dataSource
]

{ #category : #API }
PenTextEditor >> getText [
	^self editor text asString
]

{ #category : #API }
PenTextEditor >> setText: aStringOrText [
	self editor setTextFromString: aStringOrText
]

{ #category : #accessing }
PenTextEditor >> styleName [
	^ #textEditor
]
