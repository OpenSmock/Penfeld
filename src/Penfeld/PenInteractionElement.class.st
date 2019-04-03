Class {
	#name : #PenInteractionElement,
	#superclass : #PenElement,
	#instVars : [
		'tooltip',
		'loading'
	],
	#category : #'Penfeld-Core'
}

{ #category : #initialization }
PenInteractionElement >> initialize [ 
	super initialize.
	loading := false.
]

{ #category : #testing }
PenInteractionElement >> isLoading [
	^ loading
]

{ #category : #accessing }
PenInteractionElement >> loading: anObject [
	loading = anObject ifTrue: [ ^ self ].
	
	loading := anObject.
	loading 
		ifTrue: [ self disable ]
		ifFalse: [ self enable ]
]

{ #category : #accessing }
PenInteractionElement >> tooltip [
	^ tooltip
]

{ #category : #accessing }
PenInteractionElement >> tooltip: aString [
	tooltip := aString
]
