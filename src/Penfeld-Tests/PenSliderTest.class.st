"
A PenSliderTest is a test class for testing the behavior of PenSlider
"
Class {
	#name : #PenSliderTest,
	#superclass : #TestCase,
	#instVars : [
		'slider'
	],
	#category : #'Penfeld-Tests-Elements'
}

{ #category : #running }
PenSliderTest >> setUp [
	slider := PenSlider new interval: (10 to: 100 by: 10).
]

{ #category : #test }
PenSliderTest >> testDecrement [
	slider index: 3.
	self assert: slider index equals: 3.
	self assert: slider value equals: 30.
	
	slider decrement.
	self assert: slider index equals: 2.
	self assert: slider value equals: 20.
	
	slider decrement.
	self assert: slider index equals: 1.
	self assert: slider value equals: 10.
	
	slider decrement.
	self assert: slider index equals: 1.
	self assert: slider value equals: 10.
]

{ #category : #test }
PenSliderTest >> testIncrement [
	slider index: 8.
	self assert: slider index equals: 8.
	self assert: slider value equals: 80.
	
	slider increment.
	self assert: slider index equals: 9.
	self assert: slider value equals: 90.
	
	slider increment.
	self assert: slider index equals: 10.
	self assert: slider value equals: 100.
	
	slider increment.
	self assert: slider index equals: 10.
	self assert: slider value equals: 100.
]

{ #category : #test }
PenSliderTest >> testMax [
	slider index: 8.
	self assert: slider index equals: 8.
	self assert: slider value equals: 80.
	
	slider max.
	self assert: slider index equals: 10.
	self assert: slider value equals: 100.
]

{ #category : #test }
PenSliderTest >> testMiddle [
	slider index: 8.
	self assert: slider index equals: 8.
	self assert: slider value equals: 80.
	
	slider middle.
	self assert: slider index equals: 5.
	self assert: slider value equals: 50.
]

{ #category : #test }
PenSliderTest >> testMin [
	slider index: 8.
	self assert: slider index equals: 8.
	self assert: slider value equals: 80.
	
	slider min.
	self assert: slider index equals: 1.
	self assert: slider value equals: 10.
]

{ #category : #test }
PenSliderTest >> testUpdateFraction [
	slider updateFraction: 110/200.
	self assert: slider index equals: 6.
	self assert: slider value equals: 60.
	
	slider updateFraction: 108/200.
	self assert: slider index equals: 5.
	self assert: slider value equals: 50.
]

{ #category : #test }
PenSliderTest >> testValue [
	slider value: 30.
	self assert: slider value equals: 30.
	
	"If value is not found in interval, do not change it."
	slider value: 38.
	self deny: slider value equals: 38.
	self assert: slider value equals: 30.
	
]
