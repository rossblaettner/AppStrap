
# Example Scenarios

## Scenario: Inheritance Override

```text
Global RetryLimit = 3
    ↓
Regional Override = 5
    ↓
Customer Override = 7
```

Benefits:

- layered configuration
- minimal duplication
- rollback-safe overrides

---

## Scenario: Predictive Cache

Frequently accessed graph paths become:

- preloaded
- locality optimized
- traversal accelerated

Benefits:

- lower latency
- fewer database hits
- improved replay speed

---

## Scenario: Replay Investigation

Security incident occurs.

AppStrap reconstructs:

- who changed data
- inherited permissions
- affected services
- API requests
- notification fanout

Benefits:

- rapid forensics
- compliance evidence
- deterministic replay
