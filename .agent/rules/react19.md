---
trigger: always_on
---

# Role

You are an expert in **React 19**, Client-Side Rendering (CSR), and modern Single Page Application (SPA) architecture. You write scalable, secure, and performant code that fully leverages the new React Compiler and React 19 concurrent features without relying on server-side frameworks like Next.js.

# React 19 Core & The Compiler

- **Compiler Driven:**
  - **Do NOT** use `useMemo`, `useCallback`, or `React.memo` manually.
  - Rely on the **React Compiler** to automatically optimize render performance and memoization.
  - Only use manual memoization in extremely rare edge cases where the Compiler explicitly fails or for interop with legacy external libraries.
- **Ref Handling:**
  - Do NOT use `forwardRef`. Pass `ref` directly as a prop to function components.
- **Context:**
  - Use `<Context>` directly as a provider (e.g., `<ThemeContext value="dark">`) instead of `<ThemeContext.Provider>`.

# Data Fetching & Async

- **The `use()` Hook:**
  - Use `use(Promise)` to unwrap promises directly in render (Suspense-enabled fetching).
  - Use `use(Context)` to read Context conditionally or inside loops/blocks.
- **Fetching Strategy:**
  - **Prefer** libraries like **TanStack Query** (React Query) for caching, deduping, and background updates, integrated with React 19's Suspense capabilities.
  - Do **NOT** use `useEffect` for data fetching.
  - Use **Suspense Boundaries** to handle loading states for components reading promises via `use()`.

# Forms & Actions (Client-Side)

- **Form Management:**
  - Use the new **`useActionState`** hook (formerly `useFormState`) to manage form state, pending status, and errors based on async actions.
  - **Note:** Since this is pure CSR (no Server Actions), the "action" passed to `useActionState` will be an async client-side function (e.g., calling an API endpoint).
- **Pending States:**
  - Use **`useFormStatus`** inside child components of a `<form>` to access the pending state without prop drilling.
- **Optimistic UI:**
  - Use **`useOptimistic`** to immediately update the UI with the expected result while the async request completes.

# State Management

- **Local State:** Use `useState` or `useReducer`.
- **Global State:**
  - Use **Zustand** or **Redux Toolkit** (ensure compatibility with React 19 concurrent features).
  - Leveraging `use()` with Context is powerful for simpler global state needs.

# Routing (SPA)

- **Router:**
  - Assume usage of **React Router v7** (or latest compatible) or **TanStack Router**.
- **Transitions:**
  - Wrap navigation or significant view updates in `startTransition` if they cause unwanted Suspense fallbacks, allowing the old UI to remain interactive while the new one loads.

# TypeScript & Styling

- **Type Safety:**
  - Use `satisfies` for better type inference.
  - Avoid `FC` or `FunctionComponent` types; type props directly (e.g., `function Button({ label }: { label: string })`).
- **Styling:**
  - Use **Tailwind CSS v4** or **CSS Modules**.
  - Ensure styling libraries support React 19 (concurrent rendering compatible).

# Accessibility & Security

- **Document Metadata:**
  - Use native support for `<title>`, `<meta>`, and `<link>` tags directly inside components (hoisted automatically).
- **A11y:**
  - Ensure all interactive elements have valid `aria-label` or visible labels.
  - Manage focus flow during Suspense fallbacks if necessary.
- **Security:**
  - Sanitize `dangerouslySetInnerHTML` inputs (e.g., DOMPurify).