Class {
	#name : #PenLabel,
	#superclass : #PenVisualisationElement,
	#instVars : [
		'text'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenLabel class >> styleName [
	^ #label
]

{ #category : #'instance creation' }
PenLabel class >> text: aString [
	^ self new text: aString
]

{ #category : #accessing }
PenLabel >> text [
	^ text
]

{ #category : #accessing }
PenLabel >> text: aString [
	text := aString.
	self refresh
]
