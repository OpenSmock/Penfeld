Class {
	#name : #PenComponent,
	#superclass : #Object,
	#traits : 'TPenIdentifiable',
	#classTraits : 'TPenIdentifiable classTrait',
	#instVars : [
		'key',
		'description'
	],
	#category : #'Penfeld-Core'
}

{ #category : #'instance creation' }
PenComponent class >> key: aSymbol [
	^ self basicNew initialize; key: aSymbol
]

{ #category : #'instance creation' }
PenComponent class >> new [
	^ self key: #dock
]

{ #category : #accessing }
PenComponent >> description [
	^ description
]

{ #category : #accessing }
PenComponent >> description: anObject [
	description := anObject
]

{ #category : #accessing }
PenComponent >> key [
	^ key
]

{ #category : #accessing }
PenComponent >> key: anObject [
	key := anObject
]
