Class {
	#name : #StylePseudoClassStates,
	#superclass : #OrderedCollection,
	#instVars : [
		'styleable'
	],
	#category : #'Style-Utils'
}

{ #category : #'as yet unclassified' }
StylePseudoClassStates class >> on: aStyleable [
	^ self new
		styleable: aStyleable;
		yourself
]

{ #category : #accessing }
StylePseudoClassStates >> styleable [
	^ styleable
]

{ #category : #accessing }
StylePseudoClassStates >> styleable: anObject [
	styleable := anObject
]
