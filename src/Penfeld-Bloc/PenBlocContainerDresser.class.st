Class {
	#name : #PenBlocContainerDresser,
	#superclass : #PenBlocDresser,
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocContainerDresser >> backgroundColor: aValue [
	self component engineElement background: aValue
]

{ #category : #dressing }
PenBlocContainerDresser >> doAfterApplyStyle [
	| var |

	"Position"
	var := self component position.
	var ifNotNil: [ self component engineElement relocate: var ].

	"Width and Height"
	self component engineElement constraintsDo: [ :c |
		self component width ifNotNil: [ c horizontal exact: self component width pref ].
		self component height ifNotNil: [ c vertical exact: self component height pref ] 
	]
]

{ #category : #dressing }
PenBlocContainerDresser >> doBeforeApplyStyle [
	self component engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent
	]
]

{ #category : #initialization }
PenBlocContainerDresser >> initEngineElement [
	| element |
	self component engineElement: BlElement new.
	element := self component engineElement.
	
	element layout: (self component layout isLinearLayout
		ifTrue: [ self component layout isHorizontal 
			ifTrue: [ BlLinearLayout horizontal ]
			ifFalse: [ BlLinearLayout vertical ]]
		ifFalse: [ BlBasicLayout new ]).
		
	self component elements do: [ :each |
		element addChild: each engineElement ]
]
