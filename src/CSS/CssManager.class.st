Class {
	#name : #CssManager,
	#superclass : #Object,
	#instVars : [
		'styleMap'
	],
	#category : #'CSS-Utils'
}

{ #category : #'as yet unclassified' }
CssManager >> initialize [
	super initialize.
	styleMap := Dictionary new.
]

{ #category : #'as yet unclassified' }
CssManager >> stylesFor: aStyleable [
	styleMap at: aStyleable
]

{ #category : #'as yet unclassified' }
CssManager >> transitionStatesFor: aNode [
	| parent states |
	states := OrderedCollection new.
	parent := aNode.
	[ parent isNotNil ]
		whileTrue:[ 
			states add: parent pseudoClassStates.
			parent := parent parent].
	^ states  
]
