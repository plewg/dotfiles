$beacnStudioId = "{0.0.1.00000000}.{C3CE8081-6E73-4F81-9844-B0B119A5B0A9}"

$defaultMicId = "{0.0.1.00000000}.{e083070f-d960-4493-af61-fca75e984b5b}"

Set-AudioDevice -Id $beacnStudioId

Set-AudioDevice -RecordingCommunicationVolume 100

Set-AudioDevice -Id $defaultMicId
