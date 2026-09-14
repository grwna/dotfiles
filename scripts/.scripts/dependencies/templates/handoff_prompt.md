You are about to hand off this task to another AI agent in a fresh session. Write a handoff document in Markdown containing everything the next agent needs to continue with zero ambiguity, and nothing it doesn't. Include:

Goal — what we're actually trying to accomplish, in one or two sentences
Done — what's completed and verified working (be specific: files changed, commands run, tests passing)
In progress — what's partially done and exactly where it was left off
Decisions & rationale — any architectural/approach choices made and why, so the next agent doesn't second-guess or redo them
Explicitly not done / deferred — things considered and intentionally skipped, so they aren't silently forgotten or redone
Next action — the single concrete next step, not a vague direction
Gotchas — anything that wasted time or caused confusion this session (a flaky test, a misleading file name, an assumption that turned out wrong)

Do not include the raw conversation or a narrative of how we got here — only the distilled state needed to act. Keep it tight; skip anything the next agent can discover by reading the code itself.
