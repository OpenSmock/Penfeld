Class {
	#name : #CssTransitionDeclaration,
	#superclass : #CssDeclaration,
	#instVars : [
		'duration',
		'timingFunction',
		'delay'
	],
	#category : #'CSS-Core'
}

{ #category : #'adding/removing' }
CssTransitionDeclaration >> addTo: aRule [
	aRule transitions add: self
]

{ #category : #accessing }
CssTransitionDeclaration >> delay [
	^ delay
]

{ #category : #accessing }
CssTransitionDeclaration >> delay: anObject [
	delay := anObject
]

{ #category : #accessing }
CssTransitionDeclaration >> duration [
	^ duration
]

{ #category : #accessing }
CssTransitionDeclaration >> duration: anObject [
	duration := anObject
]

{ #category : #'initialize-release' }
CssTransitionDeclaration >> initialize [
	super initialize.
	duration := 0.
	timingFunction := #linear.
	delay := 0.
]

{ #category : #accessing }
CssTransitionDeclaration >> timingFunction [
	^ timingFunction
]

{ #category : #accessing }
CssTransitionDeclaration >> timingFunction: anObject [
	timingFunction := anObject
]

{ #category : #importing }
CssTransitionDeclaration >> valuesFromArray: anArray [
	self duration: (anArray at: 1 ifAbsent: [ ^ self duration ]) value.
	self timingFunction: (anArray at: 2 ifAbsent: [ ^ self timingFunction ]) value.
	self delay: (anArray at: 3 ifAbsent: [ ^ self delay ]) value
]
