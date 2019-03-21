Class {
	#name : #PenBlocSliderExamples,
	#superclass : #Object,
	#category : #'Penfeld-Bloc-Examples'
}

{ #category : #examples }
PenBlocSliderExamples class >> exampleProgressBar [
	| progressBar |
	progressBar := PenSlider new interval: (1 to: 10 by: 0.01).
	progressBar position: 20@20.
	progressBar dresser: PenBlocProgressBarDresser new.
	progressBar openInInternalWindow.
		
	[[progressBar isMax] whileFalse: [ progressBar increment. (Duration milliSeconds: 10) wait ]] fork.
]

{ #category : #examples }
PenBlocSliderExamples class >> exampleProgressBarWithPercentage [
	| progressBar label container |
	progressBar := PenSlider new interval: (1 to: 10 by: 0.01).
	progressBar position: 20@20.
	progressBar dresser: PenBlocProgressBarDresser new.
	
	label := PenLabel text: (self textInPercent: progressBar).
	label position: 20@50.

	container := PenContainer new.
	container size: 300 @ 300.
	container addAllElements: {progressBar. label}.
	
	progressBar onValueChangedDo: [ label text: (self textInPercent: progressBar) ].
	
	container openInInternalWindow.
		
	[[progressBar isMax] whileFalse: [ progressBar increment. (Duration milliSeconds: 10) wait ]] fork.
]

{ #category : #examples }
PenBlocSliderExamples class >> exampleSlider [
	| container slider label |
	slider := PenSlider new interval: (1 to: 10 by: 0.01).
	slider middle.
	slider position: 20@20.
	slider dresser: PenBlocSliderDresser new.
	
	label := PenLabel text: (slider value round: 1) printString.
	label position: 20@50.

	container := PenContainer new.
	container size: 300 @ 300.
	container addAllElements: {slider. label}.
	
	slider onValueChangedDo: [ label text: (slider value round: 1) printString ].
	
	container openInInternalWindow
	
]

{ #category : #examples }
PenBlocSliderExamples class >> exampleSlider2 [
	| container slider label |
	slider := PenSlider new interval: (1 to: 10).
	slider middle.
	slider position: 20@20.
	slider dresser: PenBlocSliderDresser new.
	
	label := PenLabel text: (slider value round: 1) printString.
	label position: 20@50.

	container := PenContainer new.
	container size: 300 @ 300.
	container addAllElements: {slider. label}.
	
	slider onValueChangedDo: [ label text: (slider value round: 1) printString ].
	
	container openInInternalWindow
	
]

{ #category : #examples }
PenBlocSliderExamples class >> textInPercent: aSlider [
	^ (aSlider fraction * 100) rounded printString, ' pourcents'
	
]

{ #category : #'see class side' }
PenBlocSliderExamples >> seeClassSide [
]
