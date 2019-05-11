Class {
	#name : #PenLength,
	#superclass : #Object,
	#instVars : [
		'pref',
		'min',
		'max'
	],
	#category : #'Penfeld-Elements support'
}

{ #category : #'instance creation' }
PenLength class >> pref: aNumber [
	^ self new pref: aNumber
]

{ #category : #'instance creation' }
PenLength class >> pref: aNumber min: aNumber2 max: aNumber3 [
	^ self new 
		pref: aNumber;
		min: aNumber2;
		max: aNumber3
]

{ #category : #converting }
PenLength >> asLength [
	^ self
]

{ #category : #accessing }
PenLength >> max [
	^ max
]

{ #category : #accessing }
PenLength >> max: anObject [
	max := anObject
]

{ #category : #accessing }
PenLength >> min [
	^ min
]

{ #category : #accessing }
PenLength >> min: anObject [
	min := anObject
]

{ #category : #accessing }
PenLength >> pref [
	^ pref
]

{ #category : #accessing }
PenLength >> pref: anObject [
	pref := anObject
]
