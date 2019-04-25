Class {
	#name : #PenInteractionElement,
	#superclass : #PenElement,
	#instVars : [
		'tooltip'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #initialization }
PenInteractionElement >> initialize [ 
	super initialize.
]

{ #category : #accessing }
PenInteractionElement >> tooltip [
	^ tooltip
]

{ #category : #accessing }
PenInteractionElement >> tooltip: aString [
	tooltip := aString
]
