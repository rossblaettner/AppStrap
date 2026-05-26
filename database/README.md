
# Database Layer

## Purpose

The database layer provides the durable persistence backbone for AppStrap.

PostgreSQL acts as:

- registry persistence engine
- graph storage engine
- event sourcing store
- audit ledger archive
- projection materialization engine
- metadata repository

---

## Database Subdirectories

| Directory | Purpose |
|---|---|
| schema | Core relational DDL |
| views | Optimized read projections |
| functions | Stored procedures and triggers |
| indexes | Performance optimization |
| seeds | Example initialization data |

---

## Core Concepts

### Registry Nodes

Registry nodes form hierarchical structures similar to the Windows Registry.

Paths are canonicalized and indexed for:

- rapid traversal
- subscription matching
- inheritance resolution

### Registry Values

Values support:

- typed storage
- inheritance
- overrides
- temporal reconstruction

### Event Streams

Event sourcing ensures:

- immutable history
- replayability
- deterministic reconstruction

### Graph Metadata

All entities track:

- access counts
- reference counts
- traversal density
- predictive cache scores

---

## PostgreSQL Features Used

- UUID generation
- JSONB
- recursive traversal
- triggers
- stored procedures
- views
- indexing
- extensions

---

## Recommended Extensions

| Extension | Purpose |
|---|---|
| uuid-ossp | UUID generation |
| pgcrypto | Encryption |
| ltree | Hierarchical traversal |
| pg_stat_statements | Telemetry |
| apache_age | Graph queries |

---

## Data Governance

All database structures should include:

- COMMENT metadata
- foreign-key enforcement
- deterministic indexes
- replay-safe relationships
- versioned schema evolution
