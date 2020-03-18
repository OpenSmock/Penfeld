Class {
	#name : #PenBlocTableExamples,
	#superclass : #Object,
	#category : #'Penfeld-Bloc-Examples'
}

{ #category : #'examples - instance creation' }
PenBlocTableExamples class >> allSubclasses: aClass [
	| list |
	list := OrderedCollection new.
	aClass
		withAllSubclassesDo: [ :class | 
			| row |
			row := PenTableItem new.
			row key: class name asSymbol.
			row dresser: PenBlocTableItemDresser new.
			row atSection: #name put: (PenLabel text: class name).
			row
				atSection: #numberOfSubclasses
				put: (PenLabel text: class subclasses size printString).
			row
				atSection: #numberOfVariables
				put: (PenLabel text: class instVarNames size printString).
			list add: row ].
	^ list
]

{ #category : #examples }
PenBlocTableExamples class >> example [
	| component |
	component := PenTable new.
	component sections: { 
		PenSection new selector: #name.
		PenSection new selector: #numberOfSubclasses; size: 40.
		PenSection new selector: #numberOfVariables; size: 40 }.
	component header: self header.
	component addAllItems: (self allSubclasses: PenComponent).
	component dresser: PenBlocTableDresser new.
	component sortingBlock: [ :a :b | a key < b key ].
	component dragSections: true.
	component allowToSelect: true.
	component onSelectionChangedDo: [ self inform: component selection printString ].
	component open

]

{ #category : #examples }
PenBlocTableExamples class >> exampleMultiSelection [
	| component |
	component := PenTable new.
	component sections: { 
		PenSection new selector: #name.
		PenSection new selector: #numberOfSubclasses; size: 40.
		PenSection new selector: #numberOfVariables; size: 40 }.
	component header: self header.
	component addAllItems: (self allSubclasses: PenComponent).
	component dresser: PenBlocTableDresser new.
	component sortingBlock: [ :a :b | a key < b key ].
	component dragSections: true.
	component allowToSelect: true.
	component multiSelection: true.
	component openInWorld
]

{ #category : #examples }
PenBlocTableExamples class >> exampleWithScrollBar [
	| component |
	component := PenTable new.
	component sections: { 
		PenSection new selector: #name.
		PenSection new selector: #numberOfSubclasses; size: 40.
		PenSection new selector: #numberOfVariables; size: 40 }.
	component header: self header.
	component addAllItems: (self allSubclasses: PenComponent).
	component dresser: PenBlocTableDresser new.
	component sortingBlock: [ :a :b | a key < b key ].
	component dragSections: true.
	component allowToSelect: true.
	component scrollBar: true.
	component openInWorld

]

{ #category : #'examples - instance creation' }
PenBlocTableExamples class >> header [
	^ PenTableItem new
		dresser: PenBlocTableItemHeaderDresser new;
		atSection: #name put: (PenLabel new text: 'Nom');
		atSection: #numberOfSubclasses put: (PenLabel new text: 'Sub.');
		atSection: #numberOfVariables put: (PenLabel new text: 'Inst.');
		yourself
	
]

{ #category : #testing }
PenBlocTableExamples class >> isDeprecated [ 
	^ true
]

{ #category : #'see class side' }
PenBlocTableExamples >> seeClassSide [
]
