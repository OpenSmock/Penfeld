"
Trait
"
Trait {
	#name : #TPenSections,
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
TPenSections >> dragSections [
	self explicitRequirement
]

{ #category : #accessing }
TPenSections >> dragSections: aBoolean [
	self explicitRequirement
]

{ #category : #accessing }
TPenSections >> header [
	self explicitRequirement
]

{ #category : #accessing }
TPenSections >> header: anObject [
	self explicitRequirement
]

{ #category : #sections }
TPenSections >> moveSection: sectionA after: sectionB [
	| newSections | 
	newSections := self sections asOrderedCollection.
	newSections remove: sectionA.
	newSections add: sectionA after: sectionB.
	self sections: newSections.
	self refreshSectionsOrder.
	
]

{ #category : #sections }
TPenSections >> moveSection: sectionA before: sectionB [
	| newSections | 
	newSections := self sections asOrderedCollection.
	newSections remove: sectionA.
	newSections add: sectionA before: sectionB.
	self sections: newSections.
	self refreshSectionsOrder.
	
]

{ #category : #building }
TPenSections >> refreshSectionsOrder [
	self explicitRequirement
]

{ #category : #accessing }
TPenSections >> sections [
	self explicitRequirement
]

{ #category : #accessing }
TPenSections >> sections: aList [
	self explicitRequirement
]

{ #category : #accessing }
TPenSections >> showHeader [
	self explicitRequirement
]

{ #category : #accessing }
TPenSections >> showHeader: aBoolean [
	self explicitRequirement
]
