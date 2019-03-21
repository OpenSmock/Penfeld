"
to be removed ?
"
Class {
	#name : #StyleTransition,
	#superclass : #StyleStyle,
	#category : #'Style-Utils'
}

{ #category : #accessing }
StyleTransition >> transition [
	^ declaration
]

{ #category : #accessing }
StyleTransition >> transition: anObject [
	declaration := anObject
]
