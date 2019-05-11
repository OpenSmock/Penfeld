"
Trait
"
Trait {
	#name : #TPenTreeNode,
	#category : #'Penfeld-Elements support'
}

{ #category : #'nodes management' }
TPenTreeNode >> addNode: aNode [
	aNode parent: self.
	self nodes add: aNode
]

{ #category : #'nodes management' }
TPenTreeNode >> addNodes: aCollection [
	aCollection do: [ :each | self addNode: each ]
]

{ #category : #api }
TPenTreeNode >> deepLevel [
	^ self parent deepLevel + 1
]

{ #category : #api }
TPenTreeNode >> doCollapse [
	self tree isPropagatedCollapse
		ifTrue: [ self forceCollapse ]
		ifFalse: [ self expanded: false ].
		
	self refresh.
	self tree refresh.
]

{ #category : #api }
TPenTreeNode >> doExpand [
	self expanded: true.
	self refresh.
	self tree refresh
]

{ #category : #api }
TPenTreeNode >> expandAll [
	self isLeaf ifFalse: [  
		self expanded: true.
		self nodes do: [ :node | node expandAll ]]
]

{ #category : #accessing }
TPenTreeNode >> expanded [
	self explicitRequirement
]

{ #category : #accessing }
TPenTreeNode >> expanded: aBoolean [
	self explicitRequirement
]

{ #category : #private }
TPenTreeNode >> forceCollapse [
	self expanded: false.
	self nodes do: [ :node | node forceCollapse ]
]

{ #category : #api }
TPenTreeNode >> getExpandedNodesAsList [
	| list |
	list := OrderedCollection new.
	self sortedNodes do: [ :each |
		list add: each.
		each isExpanded ifTrue: [ list addAll: each getExpandedNodesAsList ]].
	^ list
]

{ #category : #testing }
TPenTreeNode >> hasNodes [
	^ self nodes isNotEmpty
]

{ #category : #testing }
TPenTreeNode >> isExpanded [
	^ self expanded
]

{ #category : #testing }
TPenTreeNode >> isLeaf [
	^ self hasNodes not
]

{ #category : #accessing }
TPenTreeNode >> nodes [
	self explicitRequirement
]

{ #category : #api }
TPenTreeNode >> sortedNodes [
	^ self nodes sort: self tree sortingBlock
]

{ #category : #api }
TPenTreeNode >> switchExpand [
	self isExpanded 
		ifTrue: [ self doCollapse ]
		ifFalse: [ self doExpand ].
]

{ #category : #accessing }
TPenTreeNode >> tree [
	^ self parent tree
]
