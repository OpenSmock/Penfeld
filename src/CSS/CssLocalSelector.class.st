Class {
	#name : #CssLocalSelector,
	#superclass : #CssSimpleSelector,
	#instVars : [
		'target'
	],
	#category : #'CSS-Utils'
}

{ #category : #'as yet unclassified' }
CssLocalSelector class >> target: aNode [
	^ self new
		target: aNode;
		yourself
]

{ #category : #'as yet unclassified' }
CssLocalSelector >> matchesPseudoClasseState: aPseudoClassStates [
	^ aPseudoClassStates includesAll: pseudoClasses
]

{ #category : #'as yet unclassified' }
CssLocalSelector >> matchesStyleable: aStyleable [
	^ true
]

{ #category : #'as yet unclassified' }
CssLocalSelector >> origin [
	^ CSSOrigin INLINE
]

{ #category : #accessing }
CssLocalSelector >> target [
	^ target
]

{ #category : #accessing }
CssLocalSelector >> target: anObject [
	target := anObject
]

{ #category : #'as yet unclassified' }
CssLocalSelector >> updateSpecificity [
	idCount := 0.
	styleClassCount := self target styleClassProperty size.
	pseudoClassCount := self pseudoClasses size.
	nameCount := 0.
	specificity := idCount << 8 | (pseudoClassCount << 4) | styleClassCount | nameCount
]
