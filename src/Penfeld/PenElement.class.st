Class {
	#name : #PenElement,
	#superclass : #PenDisplayComponent,
	#instVars : [
		'icon'
	],
	#category : #'Penfeld-Components'
}

{ #category : #accessing }
PenElement >> icon [
	^ icon
]

{ #category : #accessing }
PenElement >> icon: anObject [
	icon := anObject
]
