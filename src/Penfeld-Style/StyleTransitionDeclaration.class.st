Class {
	#name : #StyleTransitionDeclaration,
	#superclass : #StyleDeclaration,
	#instVars : [
		'duration',
		'timingFunction',
		'delay'
	],
	#category : #'Style-Core'
}

{ #category : #'adding/removing' }
StyleTransitionDeclaration >> addTo: aRule [
	aRule transitions add: self
]

{ #category : #accessing }
StyleTransitionDeclaration >> delay [
	^ delay
]

{ #category : #accessing }
StyleTransitionDeclaration >> delay: anObject [
	delay := anObject
]

{ #category : #accessing }
StyleTransitionDeclaration >> duration [
	^ duration
]

{ #category : #accessing }
StyleTransitionDeclaration >> duration: anObject [
	duration := anObject
]

{ #category : #'initialize-release' }
StyleTransitionDeclaration >> initialize [
	super initialize.
	duration := 0.
	timingFunction := #linear.
	delay := 0.
]

{ #category : #accessing }
StyleTransitionDeclaration >> timingFunction [
	^ timingFunction
]

{ #category : #accessing }
StyleTransitionDeclaration >> timingFunction: anObject [
	timingFunction := anObject
]

{ #category : #importing }
StyleTransitionDeclaration >> valuesFromArray: anArray [
	self duration: (anArray at: 1 ifAbsent: [ ^ self duration ]) value.
	self timingFunction: (anArray at: 2 ifAbsent: [ ^ self timingFunction ]) value.
	self delay: (anArray at: 3 ifAbsent: [ ^ self delay ]) value
]
