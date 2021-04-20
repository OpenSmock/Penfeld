Class {
	#name : #PenLayout,
	#superclass : #Object,
	#category : #'Penfeld-Elements support'
}

{ #category : #testing }
PenLayout >> isAbsolute [
	^ false
]

{ #category : #testing }
PenLayout >> isFlow [
	^ false
]

{ #category : #testing }
PenLayout >> isLinear [
	^ false
]

{ #category : #testing }
PenLayout >> isPosition [ 
	self deprecated: 'rename: absolute'.
	^ false
]
