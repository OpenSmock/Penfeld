Class {
	#name : #PenProgressBar,
	#superclass : #PenInteractionElement,
	#traits : 'TPenValueChangedEvent',
	#classTraits : 'TPenValueChangedEvent classTrait',
	#instVars : [
		'interval',
		'index'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenProgressBar >> fraction [
	^ (index - 1) / (interval size - 1)
]

{ #category : #api }
PenProgressBar >> increment [
	self isMax ifTrue: [ ^ self ].
	index := index + 1.
	self refresh.
	self valueChangedEvent  
]

{ #category : #api }
PenProgressBar >> increment: aNumber [
	self isMax ifTrue: [ ^ self ].
	index := (index + aNumber) min: interval size.
	self refresh.
	self valueChangedEvent  
]

{ #category : #initialization }
PenProgressBar >> initialize [
	super initialize.
	index := 1.
]

{ #category : #accessing }
PenProgressBar >> interval [
	^ interval
]

{ #category : #accessing }
PenProgressBar >> interval: anInterval [
	interval := anInterval
]

{ #category : #testing }
PenProgressBar >> isMax [
	^ index = interval size
]

{ #category : #accessing }
PenProgressBar >> styleName [ 
	^ #progressBar
]

{ #category : #accessing }
PenProgressBar >> value [
	^ interval at: index
]
