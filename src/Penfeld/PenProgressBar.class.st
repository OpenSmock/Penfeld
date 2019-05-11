Class {
	#name : #PenProgressBar,
	#superclass : #PenInteractionElement,
	#instVars : [
		'interval',
		'index'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenProgressBar class >> styleName [ 
	^ #progressBar
]

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

{ #category : #'api - events' }
PenProgressBar >> onValueChangedDo: aBlock [
	self onEvent: PenEventSymbol valueChanged do: aBlock
]

{ #category : #accessing }
PenProgressBar >> progress [
	^ interval at: index
]

{ #category : #accessing }
PenProgressBar >> value [
	self deprecated: 'use progress insted'.
	^ self value
]

{ #category : #events }
PenProgressBar >> valueChangedEvent [
	self eventBindings do: [ :eventBinding |
		(eventBinding symbolMatches: PenEventSymbol valueChanged)
			ifTrue: [ eventBinding executeCallback ]].
]
