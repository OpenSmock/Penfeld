Class {
	#name : #PenBlocContainerDresser,
	#superclass : #PenBlocDresser,
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocContainerDresser >> backgroundColor: aValue [
	self model engineElement background: aValue
]

{ #category : #dressing }
PenBlocContainerDresser >> doAfterApplyStyle [
	| var |

	"Position"
	var := self model position.
	var ifNotNil: [ self model engineElement relocate: var ].

	"Width and Height"
	self model engineElement constraintsDo: [ :c |
		self model width ifNotNil: [ c horizontal exact: self model width pref ].
		self model height ifNotNil: [ c vertical exact: self model height pref ] 
	]
]

{ #category : #dressing }
PenBlocContainerDresser >> doBeforeApplyStyle [
	self model engineElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent
	]
]

{ #category : #initialization }
PenBlocContainerDresser >> initEngineElement [
	| element |
	self model engineElement: BlElement new.
	element := self model engineElement.
	
	element layout: (self model layout isLinearLayout
		ifTrue: [ self model layout isHorizontal 
			ifTrue: [ BlLinearLayout horizontal ]
			ifFalse: [ BlLinearLayout vertical ]]
		ifFalse: [ BlBasicLayout new ]).
		
	self model elements do: [ :each |
		element addChild: each engineElement ]
]
