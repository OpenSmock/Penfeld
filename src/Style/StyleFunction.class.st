Class {
	#name : #StyleFunction,
	#superclass : #StyleValue,
	#instVars : [
		'args'
	],
	#category : #'Style-Value'
}

{ #category : #accessing }
StyleFunction >> args [
	^ args
]

{ #category : #accessing }
StyleFunction >> args: anObject [
	args := anObject
]

{ #category : #testing }
StyleFunction >> isFunction [
	^ true
]
