Class {
	#name : #PenSection,
	#superclass : #Object,
	#instVars : [
		'selector',
		'header',
		'resizable',
		'visible',
		'size'
	],
	#category : #'Penfeld-Elements support'
}

{ #category : #accessing }
PenSection >> header [
	^ header
]

{ #category : #accessing }
PenSection >> header: anObject [
	header := anObject
]

{ #category : #initialization }
PenSection >> initialize [
	super initialize.
	resizable := true.
	visible := true.
	size := #maximized
]

{ #category : #accessing }
PenSection >> resizable [
	^ resizable
]

{ #category : #accessing }
PenSection >> resizable: anObject [
	resizable := anObject
]

{ #category : #accessing }
PenSection >> selector [
	^ selector
]

{ #category : #accessing }
PenSection >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
PenSection >> size [
	^ size
]

{ #category : #accessing }
PenSection >> size: anObject [
	size := anObject
]

{ #category : #accessing }
PenSection >> visible [
	^ visible
]

{ #category : #accessing }
PenSection >> visible: anObject [
	visible := anObject
]
