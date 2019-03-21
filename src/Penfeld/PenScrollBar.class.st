Class {
	#name : #PenScrollBar,
	#superclass : #PenSlider,
	#instVars : [
		'viewableFraction',
		'length'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenScrollBar >> length [
	^ length
]

{ #category : #accessing }
PenScrollBar >> length: anObject [
	length := anObject
]

{ #category : #accessing }
PenScrollBar >> styleName [
	^ #scrollBar
]

{ #category : #accessing }
PenScrollBar >> viewableFraction [
	^ viewableFraction
]

{ #category : #accessing }
PenScrollBar >> viewableFraction: aFloat [
	viewableFraction := aFloat
]
