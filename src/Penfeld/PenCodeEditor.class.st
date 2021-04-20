Class {
	#name : #PenCodeEditor,
	#superclass : #PenTextEditor,
	#instVars : [
		'displayedMethod'
	],
	#category : #'Penfeld-Elements'
}

{ #category : #accessing }
PenCodeEditor class >> styleName [
	^ #codeEditor
]

{ #category : #API }
PenCodeEditor >> behavior: aBehavior [
	"Set the behavior (class, trait...) from which the syntax highlighting will work from"
	dresser behavior: aBehavior
]

{ #category : #accessing }
PenCodeEditor >> displayedMethod [
	^displayedMethod
]

{ #category : #API }
PenCodeEditor >> method: aCompiledMethod [
	displayedMethod := aCompiledMethod.
	self setText: displayedMethod sourceCode
]

{ #category : #API }
PenCodeEditor >> setSelectionInterval: anInterval [
	self editor selectNone.
	self editor select: anInterval first - 1 to: anInterval last
]
