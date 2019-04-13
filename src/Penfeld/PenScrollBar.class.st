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
PenScrollBar >> styleName [
	^ #scrollBar
]
