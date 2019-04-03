Class {
	#name : #PenComponent,
	#superclass : #Object,
	#traits : 'TPenDebug + TPenIdentifiable',
	#classTraits : 'TPenDebug classTrait + TPenIdentifiable classTrait',
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
