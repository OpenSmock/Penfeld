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
	var := self model position.
	var ifNotNil: [ self model engineElement relocate: var ].

	"Width"
	var := self model width.
	var ifNotNil: [ self model engineElement width: var pref ].
	
	"Height"
	var := self model height.
	var ifNotNil: [ self model engineElement height: var pref ].
]

{ #category : #dressing }
PenBlocRadioGroupDresser >> horizontal [
	horizontal := true
]

{ #category : #dressing }
PenBlocRadioGroupDresser >> initEngineElement [
	self model engineElement: BlElement new.
	self model engineElement layout: 
		(horizontal 
			ifTrue: [ BlLinearLayout horizontal ]
			ifFalse: [ BlLinearLayout vertical ]).
	self model engineElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	self model radioButtons do: [ :each |
		self model engineElement addChild: each engineElement ]
]

{ #category : #dressing }
PenBlocRadioGroupDresser >> initialize [ 
	super initialize.
	horizontal := false
]
