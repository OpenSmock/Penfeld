"
Divide slider and progress bar, or keep it in one model ?
"
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

{ #category : #api }
PenSlider >> decrement [
	self isMin ifTrue: [ ^ self ].
	index := index - 1.
	self refresh.
	self valueChangedEvent  
]

{ #category : #accessing }
PenSlider >> fraction [
	^ (index - 1) / (interval size - 1)
]

{ #category : #api }
PenSlider >> increment [
	self isMax ifTrue: [ ^ self ].
	index := index + 1.
	self refresh.
	self valueChangedEvent  
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
	index := 1.
	self valueChangedEvent  
]

{ #category : #api }
PenSlider >> middle [
	index := (self interval size / 2) asInteger.
	self valueChangedEvent  
]

{ #category : #api }
PenSlider >> min [
	index := 1.
	self valueChangedEvent  
]

{ #category : #accessing }
PenSlider >> styleName [
	^ #slider
]

{ #category : #api }
PenSlider >> updateFraction: aNumber [
	| newIndex |
	newIndex := ((aNumber * (interval size - 1)) + 1) rounded.
	newIndex = index ifTrue: [ ^ self ].
	index := newIndex.
	self refresh.
	self valueChangedEvent
	
	
	
]

{ #category : #accessing }
PenSlider >> value [
	^ interval at: index
]

{ #category : #events }
PenSlider >> valueChangedEvent [
	self eventBindings do: [ :eventBinding |
		(eventBinding symbol = PenEventSymbol valueChanged)
			ifTrue: [ eventBinding callback value ]].
]
