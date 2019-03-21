Class {
	#name : #PenBlocTreeTableExamples,
	#superclass : #Object,
	#category : #'Penfeld-Bloc-Examples'
}

{ #category : #examples }
PenBlocTreeTableExamples class >> example [
	| model |
	model := PenTreeTable new.
	model sections: { 
		PenSection new selector: #name.
		PenSection new selector: #numberOfSubclasses; size: 40.
		PenSection new selector: #numberOfVariables; size: 40 }.
	model root: (self nodeForClass: Model).
	model showRoot: true.
	model treeSectionSelector: #name.
	model expandAll.
	model dresser: PFDBlocTreeTable new.
	model sortingBlock: [ :a :b | a name < b name ].
	model build.
	self
		openInWindow: model engineElement 
		named: self name 
		extent: 400@500 
]

{ #category : #examples }
PenBlocTreeTableExamples class >> exampleWithHeader [
	| model |
	model := PenTreeTable new.
	model sections: { 
		PenSection new selector: #name.
		PenSection new selector: #numberOfSubclasses; size: 40.
		PenSection new selector: #numberOfVariables; size: 40 }.
	model root: (self nodeForClass: Model).
	model showRoot: true.
	model header: self header.
	model showHeader: true.
	model dragSections: true.
	model treeSectionSelector: #name.
	model expandAll.
	model dresser: PFDBlocTreeTable new.
	model sortingBlock: [ :a :b | a name < b name ].
	model build.
	self
		openInWindow: model engineElement 
		named: self name 
		extent: 400@500 
]

{ #category : #'examples - instance creation' }
PenBlocTreeTableExamples class >> header [
	^ PenTableItem new
		dresser: PFDBlocTableItemHeader new;
		forSection: #name put: (PenLabel new text: 'Nom');
		forSection: #numberOfSubclasses put: (PenLabel new text: 'Sub.');
		forSection: #numberOfVariables put: (PenLabel new text: 'Inst.');
		yourself
	
]

{ #category : #'examples - instance creation' }
PenBlocTreeTableExamples class >> nodeForClass:  aClass [
	| node |
	node := PenTreeTableNode new.
	node name: aClass name.
	node dresser: PFDBlocTreeTableNode new.
	node forSection: #name put: 
		(PenLabel new text: aClass name).
	node forSection: #numberOfSubclasses put: 
		(PenLabel new text: aClass subclasses size printString).
	node forSection: #numberOfVariables put: 
		(PenLabel new text: aClass instanceVariables size printString).
	aClass subclasses do: [ :subclass |
		node addNode: (self nodeForClass: subclass)].
	^ node
]

{ #category : #'see class side' }
PenBlocTreeTableExamples >> seeClassSide [
]
