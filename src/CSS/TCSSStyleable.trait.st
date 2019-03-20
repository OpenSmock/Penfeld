Trait {
	#name : #TCSSStyleable,
	#category : #'CSS-Core'
}

{ #category : #accessing }
TCSSStyleable >> pseudoClasses [
	^ self explicitRequirement
]

{ #category : #accessing }
TCSSStyleable >> styleClasses [
	^ self explicitRequirement
]

{ #category : #accessing }
TCSSStyleable >> styleId [
	^ self explicitRequirement
]

{ #category : #accessing }
TCSSStyleable >> styleName [
	^ self explicitRequirement
]
