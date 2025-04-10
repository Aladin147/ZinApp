# ZinApp V2 - Approaches That Didn't Work

This document records approaches, tools, or code experiments that were tried during V2 development but ultimately failed, were abandoned, or caused significant issues, along with the reasons why. This serves as a reference to avoid repeating past mistakes.

---

## 2025-04-10

*   **Attempt:** Running `flutter create` via `execute_command` tool (multiple attempts).
    *   **Issue:** Command consistently hung or failed with errors like `'flutter' is not recognized` or `GOTO was unexpected at this time.`. This seemed related to environment path issues or limitations in how the tool interacts with the shell/Flutter batch scripts.
    *   **Resolution:** Required manual execution of `flutter create .` directly in the user's terminal after correct SDK installation and PATH setup.

*   **Attempt:** Using `xcopy` / `robocopy` via `execute_command` for initial documentation copy.
    *   **Issue:** Parameter parsing errors (`xcopy`, `robocopy /E`) or incorrect flag interpretation (`robocopy /MIR`) within the execution environment.
    *   **Resolution:** User manually copied the documentation folder.

*   **Attempt:** Initializing Git repo (`git init`) and checking out `V2-Dev` branch *after* running `flutter create .`.
    *   **Issue:** Caused conflicts because `flutter create` generated files (like `.gitignore`, `README.md`) that clashed with files already existing in the `V2-Dev` branch history (from the old RN project). `git checkout` aborted.
    *   **Resolution:** Forced checkout (`git checkout -f V2-Dev`), cleaned the working directory (`git rm -rf .`, `git clean -fdx`), then re-added all the new Flutter project files before committing.

---

*(Add new entries as applicable)*
