# ZinApp Journal

This file is a timestamped stream-of-consciousness for all contributors.
Used to track what was attempted, what worked, and what didn’t.

## Format:
```
[YYYY-MM-DD] [Contributor/Agent Name]
- What was built or modified
- What issues were encountered (if any)
- What decisions were made
- What follow-up is required
```

---

[2025-04-08] Cline (AI Assistant)
- **Action:** Initial project scaffolding based on documentation review and plan.
- **Details:**
    - Created directory structure: `assets`, `components`, `constants`, `hooks`, `mock-api`, `navigation`, `screens`, `services`, `state`, `theme`, `types`, `utils`.
    - Created core configuration files: `package.json`, `tsconfig.json`, `babel.config.js`, `app.json`, `nativewind.config.ts`.
    - Generated mock API data files in `mock-api/db/` (`stylists.json`, `services.json`, `bookings.json`, `users.json`, `ratings.json`, `db.json`).
    - Created placeholder/initial files for constants, types, navigation, API service, auth state, and root `App.tsx`.
    - Installed project dependencies using `npm install`.
    - Organized documentation files into a new `docs/` directory.
- **Issues:**
    - Initial `move` command failed (likely shell mismatch), resolved using `mv`.
    - `npm install` reported 11 vulnerabilities (2 low, 9 high).
- **Decisions:**
    - Proceeded with `mv` for file organization.
    - Used standard Expo/React Native project structure.
    - Populated mock data based on `MOCK_API_SCHEMA.md`.
    - Configured path aliases in `tsconfig.json` and `babel.config.js`.
- **Follow-up:**
    - Address npm vulnerabilities (run `npm audit` for details).
    - Begin implementing components and screens as per `TODO.md`.
    - Resolve TypeScript errors reported after initial file creation (likely resolved by `npm install`, but needs verification).

---

[2025-04-08] Cline (AI Assistant)
- **Action:** Project cleanup and first component creation.
- **Details:**
    - Documented deferred NPM vulnerabilities in `docs/KNOWN_ISSUES.md`.
    - Created `global.css` for NativeWind base styles.
    - Updated `docs/TODO.md` to mark ratings mock file as complete.
    - Created initial structure for `BookingCard` component in `components/specific/BookingCard.tsx`.
    - Updated `docs/TODO.md` to mark `BookingCard` as created.
- **Issues:**
    - Encountered TS errors in `BookingCard.tsx` after creation (related to React import style and prop typing); addressed these with `replace_in_file`. Other TS errors (paths, JSX, NativeWind `styled`) might be IDE/type-checking delays.
- **Decisions:**
    - Deferred fixing NPM vulnerabilities.
    - Proceeded with creating the first component from the TODO list.
- **Follow-up:**
    - Continue implementing tasks from `docs/TODO.md`.
    - Integrate `BookingCard` into relevant screens once they are built.
    - Monitor TS errors to see if they resolve or require further action (e.g., checking `tsconfig.json`'s `jsx` setting if errors persist).

---

[2025-04-08] Cline (AI Assistant)
- **Action:** Project setup troubleshooting and SDK upgrade.
- **Details:**
    - Created `docs/TECHNICAL_ROADMAP.md` and committed.
    - Created placeholder screen files (`LandingScreen`, `ServiceSelectScreen`, etc.) in `screens/`.
    - Updated `navigation/AppNavigator.tsx` to use new screen components.
    - Attempted to run `npm run dev` for navigation testing.
- **Issues:**
    - Encountered Metro error: `ENOENT: no such file or directory, scandir 'src/assets'`.
        - Attempted fix by creating `metro.config.js`. (Failed)
        - Attempted fix by adjusting `assetBundlePatterns` in `app.json`. (Failed)
    - Identified Expo SDK mismatch (Project SDK 50 vs. Expo Go SDK 52).
    - Upgraded project dependencies to Expo SDK 51 (`package.json`, `npm install`). (Still incompatible with Expo Go)
    - Upgraded project dependencies to Expo SDK 52 (`package.json`, `npm install`).
    - Encountered Metro error: `Unable to resolve asset "./assets/images/icon.png"`.
        - Fixed by creating placeholder asset files using `touch`.
    - Encountered Metro/Babel error: `.plugins is not a valid Plugin property`.
        - Attempted fix by changing `babel.config.js` to use `require('babel-plugin-module-resolver')`. (Failed)
        - Attempted fix by simplifying `babel.config.js` (removing module-resolver). (Failed)
        - Attempted fix by simplifying `babel.config.js` further (removing nativewind/babel). (Allowed bundler to start but broke aliases/styling).
        - Reverted `babel.config.js` to restore nativewind plugin.
- **Decisions:**
    - Upgraded project to Expo SDK 52 to match Expo Go requirement.
    - Used placeholder files for missing assets.
    - Temporarily simplified `babel.config.js` for debugging, then reverted.
- **Follow-up:**
    - Need to resolve the persistent Babel `.plugins is not a valid Plugin property` error to allow the app to build correctly with NativeWind and path aliases enabled.
    - Investigate potential conflicts between Expo SDK 52, NativeWind v4, and Babel configuration.
    - Once build is successful, proceed with Phase 1 Step 2 (Navigation Test).

---

[2025-04-08] Cline (AI Assistant)
- **Action:** Attempted to resolve build errors by downgrading NativeWind.
- **Details:**
    - Based on research suggesting NativeWind v4 incompatibility with Expo SDK 52, downgraded `nativewind` to `2.0.11`.
    - Adjusted `babel.config.js` to remove `react-native-reanimated/plugin` temporarily.
    - Adjusted `tailwindcss` to `3.3.2` and `postcss` to `8.4.22` for compatibility with NativeWind v2.
    - Created `tailwind.config.js` (required by NativeWind v2).
    - Cleared caches and reinstalled dependencies.
- **Issues:**
    - Resolved the Babel `.plugins is not a valid Plugin property` error.
    - Encountered a new runtime error: `Unable to convert string to floating point value: "large"`.
    - Analysis suggested the error originated in `react-native-screens` during transitions, likely due to NativeWind v2 style transformation issues with RN 0.75.x.
    - Explicitly defined numerical `fontSize` values in `tailwind.config.js` as a potential fix. (Failed)
- **Decisions:**
    - Followed external guide suggesting NativeWind v2 downgrade.
    - Attempted to fix the subsequent runtime error by adjusting Tailwind config.
- **Follow-up:**
    - The NativeWind v2 downgrade introduced a different, equally blocking runtime error.

---

[2025-04-08] Cline (AI Assistant)
- **Action:** Attempted to resolve build errors by upgrading back to NativeWind v4 with specific configuration.
- **Details:**
    - Uninstalled NativeWind v2.
    - Installed NativeWind v4 (`4.0.1`) and compatible PostCSS (`8.4.31`).
    - Updated `babel.config.js` for NativeWind v4 (`['nativewind/babel', { mode: 'compileOnly' }]`), keeping `module-resolver` and `react-native-reanimated/plugin`.
    - Updated `tailwind.config.js` content structure for v4.
    - Removed incorrect `nativewind.config.ts`.
    - Created `postcss.config.js`.
    - Cleared caches and reinstalled dependencies.
- **Issues:**
    - The original Babel error `.plugins is not a valid Plugin property` returned immediately upon starting the Metro bundler.
- **Decisions:**
    - Reverted to NativeWind v4 as the v2 downgrade caused different runtime errors.
    - Applied recommended v4 configuration.
- **Conclusion:**
    - The project is currently stuck in a loop:
        - NativeWind v2 + Expo SDK 52 causes runtime errors (`Unable to convert string...`).
        - NativeWind v4 + Expo SDK 52 causes Babel build errors (`.plugins is not valid...`).
    - This indicates a fundamental incompatibility or complex configuration issue between Expo SDK 52, React Native 0.75.x, NativeWind (v2 or v4), and potentially Babel/Metro.
- **Follow-up:**
    - Commit current state for external review.
    - Further investigation needed, potentially involving:
        - Trying Expo SDK 51.
        - Testing without NativeWind temporarily.
        - Seeking community support or checking for newer patches/versions.

---

[2025-04-08] Cline (AI Assistant)
- **Action:** Planning migration from NativeWind to `twrnc`.
- **Details:**
    - Due to persistent build/runtime errors related to NativeWind (v2 & v4) compatibility with Expo SDK 52, a strategic decision was made to migrate the styling layer.
    - The chosen alternative is `twrnc` (tailwind-react-native-classnames), a lightweight library that applies Tailwind classes at runtime without build-time dependencies (Babel/PostCSS).
    - Developed a detailed migration plan focusing on removing NativeWind, installing `twrnc`, setting up configuration, refactoring components, and verifying visual/functional consistency.
- **Decisions:**
    - Adopt `twrnc` as the primary styling solution to unblock development and resolve build issues.
    - Prioritize maintaining visual fidelity and animations during the migration.
- **Follow-up:**
    - Execute the `twrnc` migration plan step-by-step.
    - Update relevant project documentation (Roadmap, README) post-migration.

---

[2025-04-09] Cline (AI Assistant)
- **Action:** Executed `twrnc` migration setup and initial testing.
- **Details:**
    - Uninstalled `nativewind`, `tailwindcss`, `postcss`.
    - Deleted `tailwind.config.js`, `postcss.config.js`.
    - Removed `nativewind/babel` plugin from `babel.config.js`.
    - Installed `twrnc` (v4.6.1).
    - Attempted various setups for a `twrnc.ts` utility file (using `create()`, direct import, require), all resulting in runtime errors (`_twrnc.default is not a function` or circular dependencies).
    - Removed `twrnc.ts` utility file.
    - Modified `App.tsx` and `LandingScreen.tsx` to import `tw` directly from `'twrnc'`.
    - Corrected path alias issues in `LandingScreen.tsx` temporarily using relative paths.
    - Performed aggressive manual cache clearing (`.expo`, `.metro-cache`, `node_modules`, `package-lock.json`, VS Code restart, `npm install`).
- **Issues:**
    - Despite code correctly using `import tw from 'twrnc';` and aggressive cache clearing, the Metro bundler *still* throws the error `Unable to resolve module ../twrnc from ...\screens\LandingScreen.tsx`, referencing a non-existent relative path from a previous state.
- **Conclusion:**
    - The persistence of the incorrect module resolution error after extensive cache clearing strongly suggests a deep, unresolvable issue with Metro's caching mechanism or a fundamental incompatibility between `twrnc` and the Expo 52/RN 0.75.3 environment that prevents the module from being correctly resolved or loaded.
- **Decision:**
    - Pause `twrnc` migration attempt.
    - Document the current state and persistent error thoroughly.
    - Push the current (non-working) state to GitHub for external review and potential alternative solutions.
- **Follow-up:**
    - Add issue to `KNOWN_ISSUES.md`.
    - Commit and push current state.
    - Await feedback/alternative approaches.
