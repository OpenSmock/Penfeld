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
	self index: index + 1.
]

{ #category : #api }
PenProgressBar >> increment: aNumber [
	self isMax ifTrue: [ ^ self ].
	self index: ((index + aNumber) min: interval size).
]

{ #category : #accessing }
PenProgressBar >> index: aNumber [
	index = aNumber ifTrue: [ ^ self ].
	index := aNumber.
	self valueChangedEvent.
	self refresh.
]

{ #category : #initialization }
PenProgressBar >> initialize [
	super initialize.
	index := 1.
	self interval: (0 to: 10)
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

{ #category : #api }
PenProgressBar >> reinit [
	self index: 1
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
