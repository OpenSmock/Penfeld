Class {
	#name : #PenTextAndCodeEditorTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Brick-TextEditor-Tests'
}

{ #category : #setup }
PenTextAndCodeEditorTest >> codeEditor [
	|editor|
	editor := PenCodeEditor new.
	editor dresser: PenBlocCodeEditorDresser new.
	editor build.
	^editor
]

{ #category : #code }
PenTextAndCodeEditorTest >> testCodeEditorStyleName [
	self assert: self codeEditor styleName equals: #codeEditor
]

{ #category : #code }
PenTextAndCodeEditorTest >> testCustomBehavior [
	self assert: (self codeEditor behavior: OrderedCollection) dresser behavior == OrderedCollection 
]

{ #category : #common }
PenTextAndCodeEditorTest >> testDataSource [
	| textEditor dataSource |
	textEditor := self textEditor.
	dataSource := textEditor dresser dataSource.
	self assert: dataSource == textEditor editor
]

{ #category : #code }
PenTextAndCodeEditorTest >> testDefaultBehavior [
	self assert: self codeEditor dresser behavior == Object
]

{ #category : #code }
PenTextAndCodeEditorTest >> testDefaultMethod [
	self assert: self codeEditor displayedMethod isNil
]

{ #category : #text }
PenTextAndCodeEditorTest >> testDefaultText [
	self assert: self textEditor getText isEmpty
]

{ #category : #text }
PenTextAndCodeEditorTest >> testSetAndGetText [
	| text |
	text := 'Hello world'.
	self
		assert:
			(self textEditor
				setText: text;
				getText)
		equals: text
]

{ #category : #code }
PenTextAndCodeEditorTest >> testSetMethod [
	| method editor |
	method := OrderedCollection >> #add:.
	editor := self codeEditor.
	editor method: method.
	self assert: editor displayedMethod == method.
	self assert: editor getText equals: method sourceCode
]

{ #category : #text }
PenTextAndCodeEditorTest >> testTextEditorStyleName [
	self assert: self textEditor styleName equals: #textEditor
]

{ #category : #setup }
PenTextAndCodeEditorTest >> textEditor [
	|editor|
	editor := PenTextEditor new.
	editor dresser: PenBlocTextEditorDresser new.
	editor build.
	^editor
]
