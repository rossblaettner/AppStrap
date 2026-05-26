
# AppStrap Security Expansion

This project revision introduces a full NTFS-inspired hierarchical security subsystem.

Major additions include:

- multi-tenant forest security
- trust relationships
- inherited ACL propagation
- deny precedence
- effective permission resolution
- audit logging
- object ownership
- registry key/file permissions
- security descriptors
- inheritable ACEs
- replayable permission changes

The security model is intentionally modeled after:

- Microsoft NTFS
- Active Directory forests
- Windows Registry ACLs
- enterprise RBAC systems

while remaining fully replayable, graph-native, and blockchain auditable.
