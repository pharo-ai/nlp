Class {
	#name : #BaselineOfAINLP,
	#superclass : #BaselineOf,
	#category : #BaselineOfAINLP
}

{ #category : #baselines }
BaselineOfAINLP >> baseline: spec [
  <baseline>
	spec
		for: #(common)
		do: [ 
			"External dependencies"
			spec
				baseline: 'AIStopwords'
				with: [ spec repository: 'github://pharo-ai/stopwords/src' ].

			"Packages"
				spec 
					package: 'AINLP'					with: [ spec requires: #('AIStopwords') ].
		
				spec
					group: 'Core' 						with: #('AINLP');
					group: 'default' 					with: #('Core') ]
]
