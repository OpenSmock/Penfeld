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
	model dresser: PenBlocTreeTableDresser new.
	model sortingBlock: [ :a :b | a key < b key ].
	model openInWorld  
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
	model dresser: PenBlocTreeTableDresser new.
	model sortingBlock: [ :a :b | a key < b key ].
	model build.
	model openInWorld 
]

{ #category : #'examples - instance creation' }
PenBlocTreeTableExamples class >> header [
	^ PenTableItem new
		dresser: PenBlocTableItemHeaderDresser new;
		atSection: #name put: (PenLabel new text: 'Nom');
		atSection: #numberOfSubclasses put: (PenLabel new text: 'Sub.');
		atSection: #numberOfVariables put: (PenLabel new text: 'Inst.');
		yourself
	
]

{ #category : #'examples - instance creation' }
PenBlocTreeTableExamples class >> nodeForClass:  aClass [
	| node |
	node := PenTreeTableNode new.
	node key: aClass name asSymbol.
	node dresser: PenBlocTreeTableNodeDresser new.
	node atSection: #name put: 
		(PenLabel new text: aClass name).
	node atSection: #numberOfSubclasses put: 
		(PenLabel new text: aClass subclasses size printString).
	node atSection: #numberOfVariables put: 
		(PenLabel new text: aClass instanceVariables size printString).
	aClass subclasses do: [ :subclass |
		node addNode: (self nodeForClass: subclass)].
	^ node
]

{ #category : #'see class side' }
PenBlocTreeTableExamples >> seeClassSide [
]
