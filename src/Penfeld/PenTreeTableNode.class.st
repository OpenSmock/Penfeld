Class {
	#name : #PenTreeTableNode,
	#superclass : #PenTableItem,
	#traits : 'TPenTreeNode',
	#classTraits : 'TPenTreeNode classTrait',
	#instVars : [
		'nodes',
		'expanded',
		'builder'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #building }
PenTreeTableNode >> build [
	self nodes do: [ :each | each build ].
	super build
]

{ #category : #accessing }
PenTreeTableNode >> builder [
	^ builder
]

{ #category : #accessing }
PenTreeTableNode >> builder: aBuilder [
	builder := aBuilder
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
	self onActionDo: [ self switchExpand ]
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
PenTreeTableNode >> styleName [
	^ #treeTableNode
]

{ #category : #accessing }
PenTreeTableNode >> table [
	^ self tree
]
