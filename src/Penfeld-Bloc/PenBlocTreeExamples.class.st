Class {
	#name : #PenBlocTreeExamples,
	#superclass : #Object,
	#category : #'Penfeld-Bloc-Examples'
}

{ #category : #examples }
PenBlocTreeExamples class >> example [
	| model |
	model := PenTree new.
	model root: (self nodeForClass: Model).
	model dresser: PenBlocTreeDresser new.
	model sortingBlock: [ :a :b | a key < b key ].
	model openInWorld
]

{ #category : #examples }
PenBlocTreeExamples class >> exampleExpandAll [
	| component |
	component := PenTree new.
	component root: (self nodeForClass: Model).
	component dresser: PenBlocTreeDresser new.
	component sortingBlock: [ :a :b | a key < b key ].
	component expandAll.
	component openInWorld 
]

{ #category : #examples }
PenBlocTreeExamples class >> examplePropagateClosure [
	| component |
	component := PenTree new.
	component root: (self nodeForClass: Model).
	component dresser: PenBlocTreeDresser new.
	component sortingBlock: [ :a :b | a key < b key ].
	component expandAll.
	component showRoot: true.
	component propagateCollapse: true.
	component openInWorld 
]

{ #category : #examples }
PenBlocTreeExamples class >> exampleTextEditor [
	| component model |
	component := PenTextEditor new.
	component position: 0 @ 0.
	component width: 500.
	component height: 500.
	component dresser: PenBlocTextEditorDresser new.
	component openInWorld
]

{ #category : #examples }
PenBlocTreeExamples class >> exampleWithRoot [
	| component |
	component := PenTree new.
	component root: (self nodeForClass: Model).
	component showRoot: true.
	component dresser: PenBlocTreeDresser new.
	component sortingBlock: [ :a :b | a key < b key ].
	component openInWorld 
]

{ #category : #'examples - instance creation' }
PenBlocTreeExamples class >> nodeForClass: aClass [
	| node |
	node := PenTreeNode new.
	node key: aClass name asSymbol.
	node dresser: PenBlocTreeNodeDresser new.
	node content: (PenLabel new text: aClass name).
	aClass subclasses do: [ :subclass | 
		node addNode: (self nodeForClass: subclass)].
	^ node
]

{ #category : #opening }
PenBlocTreeExamples class >> spaceBackground [
	^ Color r: 128 g: 128 b: 128 range: 255
]

{ #category : #'see class side' }
PenBlocTreeExamples >> seeClassSide [
]
