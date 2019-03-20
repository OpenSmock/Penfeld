"
Node because Inclusion allows to include PFClass,  not PFNode.
 manage link between child class and parent class
maybe
"
Class {
	#name : #PenInclusion,
	#superclass : #Object,
	#instVars : [
		'node'
	],
	#category : #'Penfeld-Experimental'
}

{ #category : #'instance creation' }
PenInclusion class >> node: aSymbol [
	^ self new
		node: aSymbol;
		yourself
]

{ #category : #building }
PenInclusion >> build [
	super build.
	self halt: 'todo'
]

{ #category : #accessing }
PenInclusion >> node [
	^ node
]

{ #category : #accessing }
PenInclusion >> node: anObject [
	node := anObject
]
