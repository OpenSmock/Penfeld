"
Test if basic building with Bloc basic dressers has no error.
"
Class {
	#name : #PenBlocElementsBuildingTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Bloc-Tests'
}

{ #category : #support }
PenBlocElementsBuildingTest >> allSubclasses: aClass [
	| list |
	list := OrderedCollection new.
	aClass withAllSubclassesDo: [ :class | | row |
		row := PenTableItem new.
		row key: class name asSymbol.
		row atSection: #name put: (PenLabel text: class name).
		row atSection: #numberOfSubclasses put: (PenLabel text: class subclasses size printString).
		row atSection: #numberOfVariables put: (PenLabel text: class instanceVariables size printString).
		list add: row].
	^ list
]

{ #category : #support }
PenBlocElementsBuildingTest >> nodeForClass: aClass [
	| node |
	node := PenTreeNode new.
	node key: aClass name asSymbol.
	node content: (PenLabel new text: aClass name).
	aClass subclasses do: [ :subclass | 
		node addNode: (self nodeForClass: subclass)].
	^ node
]

{ #category : #tests }
PenBlocElementsBuildingTest >> testButton [
	| component |
	component := PenButton new text: 'Button'.
	component engine: PenBlocEngine new.
	component build
]

{ #category : #tests }
PenBlocElementsBuildingTest >> testCheckBox [
	| component |
	component := PenCheckBox new label: 'CheckBox'.
	component engine: PenBlocEngine new.
	component build
]

{ #category : #tests }
PenBlocElementsBuildingTest >> testLabel [
	| component |
	component := PenLabel new text: 'Label'.
	component engine: PenBlocEngine new.
	component build
]

{ #category : #tests }
PenBlocElementsBuildingTest >> testList [
	| component |
	component := PenList new addAllItems: 
		(Object withAllSubclasses collect: [ :c | PenLabel new 
			text: c name; 
			yourself ]) .
	component engine: PenBlocEngine new.
	component build
]

{ #category : #tests }
PenBlocElementsBuildingTest >> testRadioButton [
	| component |
	component := PenCheckBox new label: 'CheckBox'.
	component engine: PenBlocEngine new.
	component build
]

{ #category : #tests }
PenBlocElementsBuildingTest >> testTable [
	| component |
	component :=  PenTable new.
	component sections: { 
		PenSection new selector: #name.
		PenSection new selector: #numberOfSubclasses; size: 40.
		PenSection new selector: #numberOfVariables; size: 40 }.
	component addAllItems: (self allSubclasses: Model).
	component engine: PenBlocEngine new.
	component build
]

{ #category : #tests }
PenBlocElementsBuildingTest >> testToggleButton [
	| component |
	component := PenTree new.
	component root: (self nodeForClass: Model).
	component sortingBlock: [ :a :b | a key < b key ].
	component engine: PenBlocEngine new.
	component build
]
