Class {
	#name : #CssFunction,
	#superclass : #CssValue,
	#instVars : [
		'args'
	],
	#category : #'CSS-Value'
}

{ #category : #accessing }
CssFunction >> args [
	^ args
]

{ #category : #accessing }
CssFunction >> args: anObject [
	args := anObject
]

{ #category : #testing }
CssFunction >> isFunction [
	^ true
]
