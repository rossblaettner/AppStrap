
# Security Architecture

## NTFS-Inspired Security

AppStrap models security after:

- NTFS ACLs
- Active Directory
- Windows Registry permissions

---

## Benefits

### Familiar Enterprise Semantics

Administrators already understand:

- inheritance
- deny precedence
- ownership
- propagation

### Multi-Tenant Isolation

Tenant forests support:

- isolated namespaces
- controlled trust
- delegated administration

### Replayable Security

Security mutations become:

- event sourced
- blockchain audited
- replayable

---

## Example

```text
Tenant A trusts Tenant B
    ↓
Backup operators inherit restore permissions
    ↓
Child registry keys inherit ACLs
    ↓
Sensitive values block inheritance
```

Benefits:

- secure delegation
- consistent enforcement
- minimal duplication
