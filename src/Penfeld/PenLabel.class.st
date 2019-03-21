Class {
	#name : #PenLabel,
	#superclass : #PenVisualisationElement,
	#instVars : [
		'text'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #'instance creation' }
PenLabel class >> text: aString [
	^ self new text: aString
]

{ #category : #accessing }
PenLabel >> styleName [
	^ #label
]

{ #category : #accessing }
PenLabel >> text [
	^ text
]

{ #category : #accessing }
PenLabel >> text: aString [
	text := aString.
	self isBuilt ifTrue: [ self refresh ]
]
