Class {
	#name : #PenElement,
	#superclass : #PenDisplayComponent,
	#category : #'Penfeld-Core'
}

{ #category : #events }
PenElement >> actionEvent [
	callbacks do: [ :eventBinding |
		(eventBinding symbol = PenEventSymbol action)
			ifTrue: [ eventBinding callback value ]] 
]

{ #category : #events }
PenElement >> clickEvent: anEvent [
	| list |
	list := callbacks 
		at: PenEventSymbol click
		ifAbsent: [ ^nil ].
	list do: [ :callback |
		callback value: anEvent ].
]

{ #category : #'api - events' }
PenElement >> onActionDo: aBlock [
	self addAutoInstalledCallback: aBlock for: PenEventSymbol action
]

{ #category : #'api - events' }
PenElement >> onClickDo: aBlock [
	self addCallback: aBlock for: PenEventSymbol click
]

{ #category : #'api - events' }
PenElement >> onMouseDownDo: aBlock [
	self addCallback: aBlock for: PenEventSymbol mouseDown
]
