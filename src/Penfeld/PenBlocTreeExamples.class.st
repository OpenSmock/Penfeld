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
	model dresser: PFDBlocTree new.
	model sortingBlock: [ :a :b | a name < b name ].
	model build.
	self
		openInWindow: model interactor 
		named: self name 
		extent: 300@500 
]

{ #category : #examples }
PenBlocTreeExamples class >> exampleExpandAll [
	| model |
	model := PenTree new.
	model root: (self nodeForClass: Model).
	model dresser: PFDBlocTree new.
	model sortingBlock: [ :a :b | a name < b name ].
	model expandAll.
	model build.
	self
		openInWindow: model interactor 
		named: self name 
		extent: 300@500 
]

{ #category : #examples }
PenBlocTreeExamples class >> examplePropagateClosure [
	| model |
	model := PenTree new.
	model root: (self nodeForClass: Model).
	model dresser: PFDBlocTree new.
	model sortingBlock: [ :a :b | a name < b name ].
	model expandAll.
	model showRoot: true.
	model propagateCollapse: true.
	model build.
	self
		openInWindow: model interactor 
		named: self name 
		extent: 300@500 
]

{ #category : #examples }
PenBlocTreeExamples class >> exampleWithRoot [
	| model |
	model := PenTree new.
	model root: (self nodeForClass: Model).
	model showRoot: true.
	model dresser: PFDBlocTree new.
	model sortingBlock: [ :a :b | a name < b name ].
	model build.
	self
		openInWindow: model interactor 
		named: self name 
		extent: 300@500 
]

{ #category : #'examples - instance creation' }
PenBlocTreeExamples class >> nodeForClass: aClass [
	| node |
	node := PenTreeNode new.
	node name: aClass name.
	node dresser: PFDBlocTreeNode new.
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
