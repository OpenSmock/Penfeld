Class {
	#name : #PenEventStrategy,
	#superclass : #Object,
	#category : #'Penfeld-Events'
}

{ #category : #installing }
PenEventStrategy >> install: aSymbol on: aModel [
	aSymbol = PenEventSymbol click
		ifTrue: [ self installClickOn: aModel ]
		ifFalse: 
	[ aSymbol = PenEventSymbol action
		ifTrue: [ self installActionOn: aModel ]
		ifFalse: [self halt: 'todo']]
]

{ #category : #installing }
PenEventStrategy >> installActionOn: aModel [
	self subclassResponsibility 
]

{ #category : #installing }
PenEventStrategy >> installClickOn: aModel [
	self subclassResponsibility 
]

{ #category : #installing }
PenEventStrategy >> installMouseDownOn: aModel [
	self subclassResponsibility 
]
