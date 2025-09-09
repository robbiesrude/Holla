# ReplicatedFirst

ReplicatedFirst contains objects that are replicated to clients before any other objects. This is used for:
- Loading screens and splash screens
- Critical LocalScripts that need to run immediately
- Essential client-side setup code
- Objects that must be available before the game fully loads

Scripts here run before StarterPlayerScripts.