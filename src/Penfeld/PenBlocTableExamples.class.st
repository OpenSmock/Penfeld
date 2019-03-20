Class {
	#name : #PenBlocTableExamples,
	#superclass : #Object,
	#category : #'Penfeld-Bloc-Examples'
}

{ #category : #'examples - instance creation' }
PenBlocTableExamples class >> allSubclasses: aClass [
	| list |
	list := OrderedCollection new.
	aClass withAllSubclassesDo: [ :class | | row |
		row := PenTableItem new.
		row key: class name asSymbol.
		row dresser: PenBlocTableItemDresser new.
		row forSection: #name put: (PenLabel text: class name).
		row forSection: #numberOfSubclasses put: (PenLabel text: class subclasses size printString).
		row forSection: #numberOfVariables put: (PenLabel text: class instanceVariables size printString).
		list add: row].
	^ list
]

{ #category : #examples }
PenBlocTableExamples class >> example [
	| model |
	model := PenTable new.
	model sections: { 
		PenSection new selector: #name.
		PenSection new selector: #numberOfSubclasses; size: 40.
		PenSection new selector: #numberOfVariables; size: 40 }.
	model header: self header.
	model addAllItems: (self allSubclasses: Model).
	model dresser: PenBlocTableDresser new.
	model sortingBlock: [ :a :b | a key < b key ].
	model dragSections: true.
	model allowToSelect: true.
	model openInInternalWindow.
	model inspect
]

{ #category : #examples }
PenBlocTableExamples class >> exampleMultiSelection [
	| model |
	model := PenTable new.
	model sections: { 
		PenSection new selector: #name.
		PenSection new selector: #numberOfSubclasses; size: 40.
		PenSection new selector: #numberOfVariables; size: 40 }.
	model header: self header.
	model addAllItems: (self allSubclasses: Model).
	model dresser: PenBlocTableDresser new.
	model sortingBlock: [ :a :b | a name < b name ].
	model dragSections: true.
	model allowToSelect: true.
	model multiSelection: true.
	model openInInternalWindow
]

{ #category : #'examples - instance creation' }
PenBlocTableExamples class >> header [
	^ PenTableItem new
		dresser: PenBlocTableItemHeaderDresser new;
		forSection: #name put: (PenLabel new text: 'Nom');
		forSection: #numberOfSubclasses put: (PenLabel new text: 'Sub.');
		forSection: #numberOfVariables put: (PenLabel new text: 'Inst.');
		yourself
	
]

{ #category : #'see class side' }
PenBlocTableExamples >> seeClassSide [
]
