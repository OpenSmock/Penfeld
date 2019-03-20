Class {
	#name : #PenBlocContainerDresser,
	#superclass : #PenBlocDresser,
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #dressing }
PenBlocContainerDresser >> doAfterApplyStyle [
	| var |

	"Position"
	var := self model position.
	var ifNotNil: [ self model interactor relocate: var ].

	"Width and Height"
	self model interactor constraintsDo: [ :c |
		self model width ifNotNil: [ c horizontal exact: self model width pref ].
		self model height ifNotNil: [ c vertical exact: self model height pref ] 
	]
]

{ #category : #dressing }
PenBlocContainerDresser >> doBeforeApplyStyle [
	self model interactor layout: BlBasicLayout new.
	self model interactor constraintsDo: [ :c |
		self model width ifNil: [ c horizontal matchParent ].
		self model height ifNil: [ c vertical matchParent ] 
	]
]

{ #category : #initialization }
PenBlocContainerDresser >> initInteractor [
	self model interactor: BlElement new.
	(self model layout isKindOf: PenLinearLayout)
		ifTrue: [ self model layout isHorizontal 
			ifTrue: [ BlLinearLayout horizontal ]
			ifFalse: [ BlLinearLayout vertical ]]
		ifFalse: [  ].
		
	self model elements do: [ :each |
		self model interactor addChild: each interactor ]
]
