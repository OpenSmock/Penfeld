Class {
	#name : #PenBlocRadioGroupDresser,
	#superclass : #PenBlocDresser,
	#instVars : [
		'horizontal'
	],
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #factory }
PenBlocRadioGroupDresser class >> horizontal [
	^ self new horizontal
]

{ #category : #dressing }
PenBlocRadioGroupDresser >> doAfterApplyStyle [ 
	| var |

	"Position"
	var := self component position.
	var ifNotNil: [ self component engineElement relocate: var ].

	"Width"
	var := self component width.
	var ifNotNil: [ self component engineElement width: var pref ].
	
	"Height"
	var := self component height.
	var ifNotNil: [ self component engineElement height: var pref ].
]

{ #category : #dressing }
PenBlocRadioGroupDresser >> horizontal [
	horizontal := true
]

{ #category : #dressing }
PenBlocRadioGroupDresser >> initEngineElement [
	self component engineElement: BlElement new.
	self component engineElement layout: 
		(horizontal 
			ifTrue: [ BlLinearLayout horizontal ]
			ifFalse: [ BlLinearLayout vertical ]).
	self component engineElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	self component radioButtons do: [ :each |
		self component engineElement addChild: each engineElement ]
]

{ #category : #dressing }
PenBlocRadioGroupDresser >> initialize [ 
	super initialize.
	horizontal := false
]
