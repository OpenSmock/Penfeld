"
toto
"
Class {
	#name : #PenAbsoluteLayout,
	#superclass : #PenLayout,
	#category : #'Penfeld-Elements support'
}

{ #category : #testing }
PenAbsoluteLayout >> isAbsolute [
	^ true
]

{ #category : #testing }
PenAbsoluteLayout >> isPosition [
	self deprecated: 'rename: absolute'.
	^ true
]
