Class {
	#name : #PenInfiniteDataSource,
	#superclass : #BlInfiniteDataSource,
	#instVars : [
		'listElements'
	],
	#category : #'Penfeld-Bloc-Support'
}

{ #category : #accessing }
PenInfiniteDataSource >> addElement: anElement [ 
	listElements add: anElement. 
	self notifyItemsInserted: (listElements size to: listElements size).
]

{ #category : #accessing }
PenInfiniteDataSource >> elements: aList [
	listElements := aList.
]

{ #category : #accessing }
PenInfiniteDataSource >> itemCount [
	^ listElements size
]

{ #category : #'instance creation' }
PenInfiniteDataSource >> onBindHolder: anElementHolder at: aPosition [
	| element |
	element := listElements at: aPosition.
	anElementHolder itemElement: element
]

{ #category : #'instance creation' }
PenInfiniteDataSource >> onCreateHolder: anInfiniteElement type: anItemType [
	^ PenInfiniteHolder new
]

{ #category : #accessing }
PenInfiniteDataSource >> removeElement: anElement [ 
	| index |
	index := listElements indexOf: anElement.
	listElements remove: anElement ifAbsent: [ ^ self ]. 
	self notifyItemsRemoved: (index to: index).
]
