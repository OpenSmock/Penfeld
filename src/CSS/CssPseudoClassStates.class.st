Class {
	#name : #CssPseudoClassStates,
	#superclass : #OrderedCollection,
	#instVars : [
		'styleable'
	],
	#category : #'CSS-Utils'
}

{ #category : #'as yet unclassified' }
CssPseudoClassStates class >> on: aStyleable [
	^ self new
		styleable: aStyleable;
		yourself
]

{ #category : #accessing }
CssPseudoClassStates >> styleable [
	^ styleable
]

{ #category : #accessing }
CssPseudoClassStates >> styleable: anObject [
	styleable := anObject
]
