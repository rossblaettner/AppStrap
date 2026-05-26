
# NTFS-Style Multi-Tenant Security Model

## Overview

AppStrap implements a Microsoft NTFS-inspired hierarchical security architecture supporting:

- hierarchical ACL inheritance
- explicit deny precedence
- tenant forest trusts
- one-way trust
- two-way trust
- audit inheritance
- inherited ACE propagation
- object ownership
- effective permission evaluation
- object-level auditing
- replayable permission changes

Registry semantics:

- registry keys behave like folders
- registry values behave like files

Both keys and values support:

- security descriptors
- ACL inheritance
- SACL audit policies
- ownership
- permission propagation
- effective permission resolution

---

## Permission Categories

| Permission | Description |
|---|---|
| READ | Read registry values |
| WRITE | Create/update values |
| MODIFY | Modify values and metadata |
| DELETE | Delete objects |
| RENAME | Rename keys/values |
| CREATE_CHILD | Create child keys |
| DELETE_CHILD | Delete child keys |
| CHANGE_PERMISSIONS | Modify ACLs |
| TAKE_OWNERSHIP | Transfer ownership |
| EXECUTE | Execute actions |
| AUDIT_VIEW | Read audit logs |
| BACKUP | Backup/export registry |
| RESTORE | Restore registry |
| FULL_CONTROL | All permissions |

---

## Inheritance Model

Permissions propagate similarly to NTFS:

```text
Tenant Root
    ↓
Namespace
    ↓
Registry Key
    ↓
Child Key
    ↓
Registry Value
```

ACE propagation supports:

- inherited ACEs
- explicit ACEs
- blocked inheritance
- selective propagation
- object-only inheritance
- child-only inheritance

---

## Trust Relationships

Tenants may establish:

| Trust Type | Description |
|---|---|
| ONE_WAY | Tenant A trusts Tenant B |
| TWO_WAY | Mutual trust |
| EXTERNAL | External identity trust |
| TRANSITIVE | Hierarchical forest trust |

---

## Security Resolution

Effective permissions are calculated from:

- tenant trusts
- group membership
- explicit ACEs
- inherited ACEs
- deny precedence
- ownership rules
- rules-engine policies
- temporal replay state

---

## Default Roles

| Role | Description |
|---|---|
| DOMAIN_ADMINISTRATOR | Full platform control |
| BACKUP_OPERATOR | Encrypted backup and restore |
| AUDITOR | Read audit logs |
| SECURITY_ADMINISTRATOR | Manage permissions |
| SERVICE_ACCOUNT | Restricted service execution |
| TENANT_ADMINISTRATOR | Tenant-level administration |
| READONLY_OPERATOR | Read-only access |
