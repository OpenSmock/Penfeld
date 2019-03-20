"
to be removed ?
"
Class {
	#name : #CssTransition,
	#superclass : #CssStyle,
	#category : #'CSS-Utils'
}

{ #category : #accessing }
CssTransition >> transition [
	^ declaration
]

{ #category : #accessing }
CssTransition >> transition: anObject [
	declaration := anObject
]
