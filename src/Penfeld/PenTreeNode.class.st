Class {
	#name : #PenTreeNode,
	#superclass : #PenInteractionElement,
	#traits : 'TPenTreeNode',
	#classTraits : 'TPenTreeNode classTrait',
	#instVars : [
		'content',
		'nodes',
		'expanded',
		'builder'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #building }
PenTreeNode >> build [
	self content build.
	self nodes do: [ :each | each build ].
	super build
]

{ #category : #accessing }
PenTreeNode >> builder [
	^ builder
]

{ #category : #accessing }
PenTreeNode >> builder: aBuilder [
	builder := aBuilder
]

{ #category : #accessing }
PenTreeNode >> content [
	^ content
]

{ #category : #accessing }
PenTreeNode >> content: aGroup [
	content := aGroup isGroup
		ifTrue: [ aGroup ]
		ifFalse: [ PenGroupOld new add: aGroup ].
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
	self flag: 'Change onActionDo to respond on click on clickable area'.
	self onActionDo: [ self switchExpand ]
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

{ #category : #accessing }
PenTreeNode >> styleName [
	^ #treeNode
]
