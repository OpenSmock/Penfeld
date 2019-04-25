Class {
	#name : #PenElement,
	#superclass : #PenDisplayComponent,
	#instVars : [
		'icon'
	],
	#category : #'Penfeld-Components'
}

{ #category : #accessing }
PenElement >> icon [
	^ icon
]

{ #category : #accessing }
PenElement >> icon: anObject [
	icon := anObject
]

{ #category : #'api - events' }
PenElement >> onActionDo: aBlock [
	self onEvent: PenEventSymbol action do: aBlock
]

{ #category : #'api - events' }
PenElement >> onActionPerform: aFunction on: aPerformer [
	self onEvent: PenEventSymbol action perform: aFunction on: aPerformer
]

{ #category : #'api - events' }
PenElement >> onClickDo: aBlock [
	self onEvent: PenEventSymbol click do: aBlock
]

{ #category : #'api - events' }
PenElement >> onClickPerform: aFunction on: aPerformer [
	self onEvent: PenEventSymbol click perform: aFunction on: aPerformer
]

{ #category : #'api - events' }
PenElement >> onMouseDownDo: aBlock [
	self onEvent: PenEventSymbol mouseDown do: aBlock
]

{ #category : #'api - events' }
PenElement >> onMouseDownPerform: aFunction on: aPerformer [
	self onEvent: PenEventSymbol mouseDown perform: aFunction on: aPerformer
]
