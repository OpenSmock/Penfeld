Class {
	#name : #PenBlocTreeTableWithWidgetsExamples,
	#superclass : #Object,
	#category : #'Penfeld-Bloc-Examples'
}

{ #category : #'examples - instance creation' }
PenBlocTreeTableWithWidgetsExamples class >> checkBox [
	^  PenCheckBox new 
		dresser: PenBlocCheckBoxDresser new
		yourself.
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
		extent: 500@600 
]

{ #category : #'examples - instance creation' }
PenBlocTreeTableWithWidgetsExamples class >> header [
	^ PenTableItem new
		dresser: PFDBlocTableItemHeader new;
		forSection: #name put: (PenLabel new text: 'Nom');
		forSection: #numberOfSubclasses put: (PenLabel new text: 'Sub.');
		forSection: #numberOfVariables put: (PenLabel new text: 'Inst.');
		forSection: #checkbox put: (PenLabel new text: 'Check');
		forSection: #radioGroup put: (PenLabel new text: 'Radio Group');
		yourself
	
]

{ #category : #'examples - instance creation' }
PenBlocTreeTableWithWidgetsExamples class >> nodeForClass:  aClass [
	| node |
	node := PenTreeTableNode new.
	node name: aClass name.
	node dresser: PenBlocTreeTableNodeDresser new.
	node forSection: #name put: 
		(PenLabel new text: aClass name).
	node forSection: #numberOfSubclasses put: 
		(PenLabel new text: aClass subclasses size printString).
	node forSection: #numberOfVariables put: 
		(PenLabel new text: aClass instanceVariables size printString).
	node forSection: #checkbox put: self checkBox.
	node forSection: #radioGroup put: self radioGroup.
	aClass subclasses do: [ :subclass |
		node addNode: (self nodeForClass: subclass)].
	^ node
]

{ #category : #'examples - instance creation' }
PenBlocTreeTableWithWidgetsExamples class >> radioGroup [
	^  PenRadioGroup new addAll: 
		((1 to: 5) collect: [ :i |
			PenRadioButton  new 
				label: 'Radio Button ', i printString. ] ).
]

{ #category : #'see class side' }
PenBlocTreeTableWithWidgetsExamples >> seeClassSide [
]
