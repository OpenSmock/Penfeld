Class {
	#name : #CssRelation,
	#superclass : #Object,
	#instVars : [
		'type'
	],
	#category : #'CSS-Core'
}

{ #category : #'as yet unclassified' }
CssRelation class >> CHILD [
	^ CSSChildRelation
]

{ #category : #'as yet unclassified' }
CssRelation class >> DESCENDANT [
	^ CSSDescendantRelation
]

{ #category : #'as yet unclassified' }
CssRelation class >> isChild [
	^ false
]

{ #category : #'as yet unclassified' }
CssRelation class >> isDescendant [
	^ false
]
