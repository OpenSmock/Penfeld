Class {
	#name : #PenModel,
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
PenModel class >> key: aSymbol [
	^ self basicNew initialize; key: aSymbol
]

{ #category : #'instance creation' }
PenModel class >> new [
	^ self key: #dock
]

{ #category : #accessing }
PenModel >> description [
	^ description
]

{ #category : #accessing }
PenModel >> description: anObject [
	description := anObject
]

{ #category : #accessing }
PenModel >> key [
	^ key
]

{ #category : #accessing }
PenModel >> key: anObject [
	key := anObject
]
