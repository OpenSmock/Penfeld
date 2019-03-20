Class {
	#name : #PenBlocBasicDressersMap,
	#superclass : #PenDressersMap,
	#category : #'Penfeld-Bloc-Utils'
}

{ #category : #initialization }
PenBlocBasicDressersMap >> initMap [
	map
		at: PenContainer put: PenBlocContainerDresser ;
		at: PenWindow put: PenBlocMorphicWindowDresser ;
		at: PenLabel put: PenBlocLabelDresser ;
		at: PenButton put: PenBlocButtonDresser ;
		at: PenCheckBox put: PenBlocCheckBoxDresser ;
		at: PenList put: PenBlocListDresser ;
		at: PenTree put: PenDBlocTree ;
		at: PenTreeNode put: PenDBlocTreeNode ;
		at: PenTreeTable put: PenDBlocTreeTable ;
		at: PenTreeTableNode put: PenDBlocTreeTableNode ;
		at: PenComboBox put: PenBlocComboBoxDresser ;
		at: PenRadioButton put: PenBlocRadioButtonDresser ;
		at: PenRadioGroup put: PenBlocRadioGroupDresser ;
		at: PenSlider put: PenBlocSliderDresser
	
]
