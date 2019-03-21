Trait {
	#name : #TStyStyleable,
	#category : #'Style-Core'
}

{ #category : #accessing }
TStyStyleable >> pseudoClasses [
	^ self explicitRequirement
]

{ #category : #accessing }
TStyStyleable >> styleClasses [
	^ self explicitRequirement
]

{ #category : #accessing }
TStyStyleable >> styleId [
	^ self explicitRequirement
]

{ #category : #accessing }
TStyStyleable >> styleName [
	^ self explicitRequirement
]
