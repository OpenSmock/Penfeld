Class {
	#name : #PenTextEditor,
	#superclass : #PenInteractionElement,
	#category : #'Penfeld-Elements'
}

{ #category : #initialization }
PenTextEditor >> initialize [
	super initialize.
	self stylesheet: (StyleParser parse: 'textEditor {background-color: white; color: blue}')
]

{ #category : #accessing }
PenTextEditor >> styleName [
	^ #textEditor
]
