Class {
	#name : #PenCodeEditor,
	#superclass : #PenTextEditor,
	#instVars : [
		'displayedMethod'
	],
	#category : #'Penfeld-Elements'
}

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

{ #category : #accessing }
PenCodeEditor >> styleName [
	^ #codeEditor
]
