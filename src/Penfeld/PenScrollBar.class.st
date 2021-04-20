Class {
	#name : #PenScrollBar,
	#superclass : #PenSlider,
	#instVars : [
		'viewableFraction',
		'length'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #'instance creation' }
PenScrollBar class >> horizontal [
	^ self new
]

{ #category : #accessing }
PenScrollBar class >> styleName [
	^ #scrollBar
]

{ #category : #'instance creation' }
PenScrollBar class >> vertical [
	^ self new
]
