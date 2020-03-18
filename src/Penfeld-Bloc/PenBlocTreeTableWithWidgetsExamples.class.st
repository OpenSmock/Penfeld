Class {
	#name : #PenBlocTreeTableWithWidgetsExamples,
	#superclass : #Object,
	#category : #'Penfeld-Bloc-Examples'
}

{ #category : #'examples - instance creation' }
PenBlocTreeTableWithWidgetsExamples class >> checkBox [
	^ PenCheckBox new 
]

{ #category : #examples }
PenBlocTreeTableWithWidgetsExamples class >> example [
	| model |
	model := PenTreeTable new.
	model sections: { 
		PenSection new selector: #name.
		PenSection new selector: #numberOfSubclasses; size: 40.
		PenSection new selector: #numberOfVariables; size: 40.
		PenSection new selector: #checkbox; size: 60.
		PenSection new selector: #radioGroup; size: 100 }.
	model root: (self nodeForClass: PenComponent).
	model showRoot: true.
	model header: self header.
	model showHeader: true.
	model dragSections: true.
	model treeSectionSelector: #name.
	model expandAll.
	model dresser: PenBlocTreeTableDresser new.
	model sortingBlock: [ :a :b | a key < b key ].
	model open
]

{ #category : #'examples - instance creation' }
PenBlocTreeTableWithWidgetsExamples class >> header [
	^ PenTableItem new
		dresser: PenBlocTableItemHeaderDresser new;
		atSection: #name put: (PenLabel new text: 'Nom');
		atSection: #numberOfSubclasses put: (PenLabel new text: 'Sub.');
		atSection: #numberOfVariables put: (PenLabel new text: 'Inst.');
		atSection: #checkbox put: (PenLabel new text: 'Check');
		atSection: #radioGroup put: (PenLabel new text: 'Radio Group');
		yourself
	
]

{ #category : #testing }
PenBlocTreeTableWithWidgetsExamples class >> isDeprecated [ 
	^ true
]

{ #category : #'examples - instance creation' }
PenBlocTreeTableWithWidgetsExamples class >> nodeForClass:  aClass [
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
	node atSection: #checkbox put: self checkBox.
	node atSection: #radioGroup put: self radioGroup.
	aClass subclasses do: [ :subclass |
		node addNode: (self nodeForClass: subclass)].
	^ node
]

{ #category : #'examples - instance creation' }
PenBlocTreeTableWithWidgetsExamples class >> radioGroup [
	| collection |
	collection := ((1 to: 5) collect: [ :i | 
		PenRadioButton  new 
			text: 'Radio Button ', i printString. ] ).
	PenRadioGroup new addAll: collection.
	^ PenContainer new
		layout: PenLinearLayout vertical;
		addAllElements: collection;
		yourself
]

{ #category : #'see class side' }
PenBlocTreeTableWithWidgetsExamples >> seeClassSide [
]
