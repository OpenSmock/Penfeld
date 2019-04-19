Class {
	#name : #PenTextEditor,
	#superclass : #PenInteractionElement,
	#category : #'Penfeld-Brick-TextEditor'
}

{ #category : #initialization }
PenTextEditor >> initialize [
	super initialize.
	self stylesheet: (PssParser parse: 'textEditor {background-color: white; color: blue}')
]

{ #category : #accessing }
PenTextEditor >> styleName [
	^ #textEditor
]
