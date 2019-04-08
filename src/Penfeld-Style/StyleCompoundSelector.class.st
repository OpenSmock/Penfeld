Class {
	#name : #StyleCompoundSelector,
	#superclass : #StyleSelector,
	#instVars : [
		'selectors',
		'relationships'
	],
	#category : #'Style-Core'
}

{ #category : #'as yet unclassified' }
StyleCompoundSelector class >> selectors: selectors relationships: relationships [
	^ self new
		selectors: selectors;
		relationships: relationships;
		yourself
]

{ #category : #testing }
StyleCompoundSelector >> = aSelector [
	^ aSelector isSimpleSelector not and: [ self selectors = aSelector selectors ]
]

{ #category : #accessing }
StyleCompoundSelector >> initialize [
	super initialize.
	relationships := OrderedCollection new.
	selectors := OrderedCollection new
]

{ #category : #testing }
StyleCompoundSelector >> matchesStyleable: aStyleable [
	^ self matchesStyleable: aStyleable selectorIndex: selectors size
]

{ #category : #testing }
StyleCompoundSelector >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList [
	
	^ self
		matchesStyleable: aStyleable
		pseudoClassStates: aPseudoClassStateList
		selectorIndex: self selectors size
]

{ #category : #testing }
StyleCompoundSelector >> matchesStyleable: aNode pseudoClassStates: aPseudoClassStateList selectorIndex: aSelectorIndex [
	| selector parent relation |
	aSelectorIndex = 0
		ifTrue: [ ^ true ].	"no more selectors, so it matches"
	selector := selectors at: aSelectorIndex.
	(selector matchesStyleable: aNode pseudoClassStates: aPseudoClassStateList selectorIndex: aSelectorIndex)
		ifFalse: [ ^ false ].
	aSelectorIndex = 1
		ifTrue: [ ^ true ].	"no more selectors, so it matches"
	relation := relationships at: aSelectorIndex - 1.
	parent := aNode parent.
	parent ifNil:[^ false].
	relation isChild
		ifTrue: [ ^ self matchesStyleable: parent pseudoClassStates: aPseudoClassStateList allButLast selectorIndex: aSelectorIndex - 1 ].
	relation isDescendant
		ifTrue:
			[ | thePseudoClassStateList |
			thePseudoClassStateList := aPseudoClassStateList.
			[ parent isNotNil ]
				whileTrue:
					[ thePseudoClassStateList := thePseudoClassStateList allButLast.
					(self matchesStyleable: parent pseudoClassStates: thePseudoClassStateList selectorIndex: aSelectorIndex - 1)
						ifTrue: [ ^ true ].
					parent := parent parent ] ].
	^ false
]

{ #category : #testing }
StyleCompoundSelector >> matchesStyleable: aStyleable selectorIndex: aSelectorIndex [
	^ self
		matchesStyleable: aStyleable
		pseudoClassStates: OrderedCollection new
		selectorIndex: aSelectorIndex
]

{ #category : #accessing }
StyleCompoundSelector >> relationships [
	^ relationships
]

{ #category : #accessing }
StyleCompoundSelector >> relationships: anObject [
	relationships := anObject
]

{ #category : #accessing }
StyleCompoundSelector >> rule: aRule [
	super rule: aRule.
	self selectors do: [ :item | item rule: aRule ]
]

{ #category : #accessing }
StyleCompoundSelector >> selectors [
	^ selectors
]

{ #category : #accessing }
StyleCompoundSelector >> selectors: aCollection [
	aCollection
		do: [ :item |  self selectors add: (item rule: self rule; yourself) ]
]

{ #category : #updating }
StyleCompoundSelector >> updateMatching [
	matchOnId := self selectors anySatisfy: [ :s | s matchesOnId ].
	matchOnName := self selectors anySatisfy: [ :s | s matchesOnName ].
	matchOnStyleClass := self selectors anySatisfy: [ :s | s matchesOnStyleClass ]
]

{ #category : #updating }
StyleCompoundSelector >> updateSpecificity [
	| idCount styleClassCount nameCount pseudoClassCount |
	idCount := self selectors sum: [ :s | s idCount ].
	styleClassCount := self selectors sumNumbers: [ :s | s styleClassCount ].
	pseudoClassCount := self selectors sumNumbers: [ :s | s pseudoClassCount ].
	nameCount := self selectors sum: [ :s | s nameCount ].
	specificity := idCount << 8 | (pseudoClassCount << 4) | styleClassCount | nameCount
]
