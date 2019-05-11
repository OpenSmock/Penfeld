Class {
	#name : #PenTreeNode,
	#superclass : #PenInteractionElement,
	#traits : 'TPenTreeNode',
	#classTraits : 'TPenTreeNode classTrait',
	#instVars : [
		'content',
		'nodes',
		'expanded'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenTreeNode class >> styleName [
	^ #treeNode
]

{ #category : #building }
PenTreeNode >> build [
	self content build.
	self nodes do: [ :each | each build ].
	super build
]

{ #category : #accessing }
PenTreeNode >> content [
	^ content
]

{ #category : #accessing }
PenTreeNode >> content: aContainer [
	content := aContainer isContainer
		ifTrue: [ aContainer ]
		ifFalse: [ PenContainer new addElement: aContainer ].
	content parent: self.
	
]

{ #category : #accessing }
PenTreeNode >> expanded [
	^ expanded
]

{ #category : #accessing }
PenTreeNode >> expanded: aBoolean [
	expanded := aBoolean
]

{ #category : #initialization }
PenTreeNode >> initialize [
	super initialize.
	expanded := false.
	nodes := OrderedCollection new.
]

{ #category : #accessing }
PenTreeNode >> nodes [
	^ nodes
]

{ #category : #building }
PenTreeNode >> refresh [
	self isExpanded ifTrue: [ 
		self nodes do: [ :each | each refresh ]].
	super refresh
]
