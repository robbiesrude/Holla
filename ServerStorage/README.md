# ServerStorage

ServerStorage is a container for objects that should only exist on the server. This includes:
- Server-only assets and models
- Private data and configurations
- Objects that will be cloned to players or the workspace later
- Sensitive information that clients shouldn't access

Contents are not replicated to clients, ensuring security and reducing bandwidth.