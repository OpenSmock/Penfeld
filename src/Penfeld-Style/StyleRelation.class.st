Class {
	#name : #StyleRelation,
	#superclass : #Object,
	#instVars : [
		'type'
	],
	#category : #'Style-Core'
}

{ #category : #'as yet unclassified' }
StyleRelation class >> CHILD [
	^ CSSChildRelation
]

{ #category : #'as yet unclassified' }
StyleRelation class >> DESCENDANT [
	^ CSSDescendantRelation
]

{ #category : #'as yet unclassified' }
StyleRelation class >> isChild [
	^ false
]

{ #category : #'as yet unclassified' }
StyleRelation class >> isDescendant [
	^ false
]
