Class {
	#name : #PenSlider,
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
PenSlider class >> styleName [
	^ #slider
]

{ #category : #api }
PenSlider >> decrement [
	self isMin ifTrue: [ ^ self ].
	self index: index - 1.
]

{ #category : #accessing }
PenSlider >> fraction [
	^ (index - 1) / (interval size - 1)
]

{ #category : #api }
PenSlider >> increment [
	self isMax ifTrue: [ ^ self ].
	self index: index + 1.
]

{ #category : #accessing }
PenSlider >> index [
	^ index
]

{ #category : #accessing }
PenSlider >> index: aNumber [
	index = aNumber ifTrue: [ ^ self ].
	index := aNumber.
	self valueChangedEvent.
	self refresh.
]

{ #category : #initialization }
PenSlider >> initialize [
	super initialize.
	index := 1.
]

{ #category : #accessing }
PenSlider >> interval [
	^ interval
]

{ #category : #accessing }
PenSlider >> interval: anInterval [
	interval := anInterval
]

{ #category : #testing }
PenSlider >> isMax [
	^ index = interval size
]

{ #category : #testing }
PenSlider >> isMin [
	^ index = 1
]

{ #category : #api }
PenSlider >> max [
	self index: self interval size.
]

{ #category : #api }
PenSlider >> middle [
	self index: (self interval size / 2) asInteger.
]

{ #category : #api }
PenSlider >> min [ 
	self index: 1.
]

{ #category : #api }
PenSlider >> updateFraction: aNumber [
"Click on a fraction of the bar, update the interval value"
	| newIndex |
	newIndex := ((aNumber * (interval size - 1)) + 1) rounded.
	newIndex := newIndex min: self interval size.
	newIndex = index ifTrue: [ ^ self ].
	index := newIndex.
	self refresh.
	self valueChangedEvent
	
	
	
]

{ #category : #accessing }
PenSlider >> value [
	^ interval at: index
]
