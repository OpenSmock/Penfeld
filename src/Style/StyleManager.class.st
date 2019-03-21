Class {
	#name : #StyleManager,
	#superclass : #Object,
	#instVars : [
		'styleMap'
	],
	#category : #'Style-Utils'
}

{ #category : #'as yet unclassified' }
StyleManager >> initialize [
	super initialize.
	styleMap := Dictionary new.
]

{ #category : #'as yet unclassified' }
StyleManager >> stylesFor: aStyleable [
	styleMap at: aStyleable
]

{ #category : #'as yet unclassified' }
StyleManager >> transitionStatesFor: aNode [
	| parent states |
	states := OrderedCollection new.
	parent := aNode.
	[ parent isNotNil ]
		whileTrue:[ 
			states add: parent pseudoClassStates.
			parent := parent parent].
	^ states  
]
