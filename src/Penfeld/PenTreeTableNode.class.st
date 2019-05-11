Class {
	#name : #PenTreeTableNode,
	#superclass : #PenTableItem,
	#traits : 'TPenTreeNode',
	#classTraits : 'TPenTreeNode classTrait',
	#instVars : [
		'nodes',
		'expanded'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenTreeTableNode class >> styleName [
	^ #treeTableNode
]

{ #category : #building }
PenTreeTableNode >> build [
	self nodes do: [ :each | each build ].
	super build
]

{ #category : #accessing }
PenTreeTableNode >> expanded [
	^ expanded
]

{ #category : #accessing }
PenTreeTableNode >> expanded: aBoolean [
	expanded := aBoolean
]

{ #category : #private }
PenTreeTableNode >> forceClosure [
	self expanded: false.
	self nodes do: [ :node | node forceCollapse ]
]

{ #category : #initialization }
PenTreeTableNode >> initialize [
	super initialize.
	expanded := false.
	nodes := OrderedCollection new.
]

{ #category : #accessing }
PenTreeTableNode >> nodes [
	^ nodes
]

{ #category : #building }
PenTreeTableNode >> refresh [
	self content do: [ :each | each refresh ].
	self isExpanded ifTrue: [ 
		self nodes do: [ :each | each refresh ]].
	super refresh
]

{ #category : #accessing }
PenTreeTableNode >> table [
	^ self tree
]
