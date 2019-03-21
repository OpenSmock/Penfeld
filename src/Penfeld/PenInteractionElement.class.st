Class {
	#name : #PenInteractionElement,
	#superclass : #PenElement,
	#instVars : [
		'enabled',
		'tooltip'
	],
	#category : #'Penfeld-Core'
}

{ #category : #accessing }
PenInteractionElement >> disable [
	self enabled: false
]

{ #category : #accessing }
PenInteractionElement >> enable [
	self enabled: true
]

{ #category : #accessing }
PenInteractionElement >> enabled: aBoolean [
	enabled := aBoolean
]

{ #category : #testing }
PenInteractionElement >> isDisabled [
	^ enabled not
]

{ #category : #testing }
PenInteractionElement >> isEnabled [
	^ enabled
]

{ #category : #'api - events' }
PenInteractionElement >> onClickDo: aBlock [
	self addCallback: aBlock for: PenEventSymbol click
]

{ #category : #accessing }
PenInteractionElement >> tooltip [
	^ tooltip
]

{ #category : #accessing }
PenInteractionElement >> tooltip: aString [
	tooltip := aString
]
