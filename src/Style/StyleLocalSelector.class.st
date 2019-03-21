Class {
	#name : #StyleLocalSelector,
	#superclass : #StyleSimpleSelector,
	#instVars : [
		'target'
	],
	#category : #'Style-Utils'
}

{ #category : #'as yet unclassified' }
StyleLocalSelector class >> target: aNode [
	^ self new
		target: aNode;
		yourself
]

{ #category : #'as yet unclassified' }
StyleLocalSelector >> matchesPseudoClasseState: aPseudoClassStates [
	^ aPseudoClassStates includesAll: pseudoClasses
]

{ #category : #'as yet unclassified' }
StyleLocalSelector >> matchesStyleable: aStyleable [
	^ true
]

{ #category : #'as yet unclassified' }
StyleLocalSelector >> origin [
	^ StyleOrigin INLINE
]

{ #category : #accessing }
StyleLocalSelector >> target [
	^ target
]

{ #category : #accessing }
StyleLocalSelector >> target: anObject [
	target := anObject
]

{ #category : #'as yet unclassified' }
StyleLocalSelector >> updateSpecificity [
	idCount := 0.
	styleClassCount := self target styleClassProperty size.
	pseudoClassCount := self pseudoClasses size.
	nameCount := 0.
	specificity := idCount << 8 | (pseudoClassCount << 4) | styleClassCount | nameCount
]
