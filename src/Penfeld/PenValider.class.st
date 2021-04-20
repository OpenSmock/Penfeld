Class {
	#name : #PenValider,
	#superclass : #Object,
	#instVars : [
		'matcher'
	],
	#category : #'Penfeld-Elements support'
}

{ #category : #'instance creation' }
PenValider class >> fromString: aString [
	^ self new matcher: (RxMatcher forString: aString)
]

{ #category : #accessing }
PenValider >> matcher [
	^ matcher
]

{ #category : #accessing }
PenValider >> matcher: anObject [
	matcher := anObject
]

{ #category : #API }
PenValider >> validate: aString [

	matcher isNil 
		ifTrue: [ "No regex, string is valid" ^ true ]
		ifFalse: [ ^ matcher search: aString. ]
]
