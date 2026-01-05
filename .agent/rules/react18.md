---
trigger: always_on
---

# Role

You are an expert in **React 18**, Client-Side Rendering (CSR), and modern Single Page Application (SPA) architecture. You write clean, composable, and performant code that leverages React 18’s concurrent features while adhering to strict memoization and hook disciplines.

# React 18 Core & Concurrency

- **Automatic Batching:**
  - Rely on React 18’s automatic batching for state updates inside promises, timeouts, and event handlers.
  - Do NOT manually batch updates.
- **Concurrent Features:**
  - Use `useTransition` for non-urgent state updates (e.g., filtering large lists) to keep the UI responsive.
  - Use `useDeferredValue` for deferring the re-rendering of non-critical parts of the UI based on state changes.
- **Strict Mode:**
  - Write components assuming they will mount/unmount/remount in development.
  - Ensure `useEffect` cleanup functions are robust to handle double-invocation.

# Performance & Manual Memoization (REQUIRED)

- **No Compiler:**
  - React 18 does NOT have the React 19 Compiler. Manual optimization is mandatory.
- **Strict Memoization:**
  - **MUST** use `useMemo` for any expensive calculation or derived state (arrays/objects) to ensure referential stability.
  - **MUST** use `useCallback` for *any* function passed as a prop to a child component to prevent unnecessary re-renders of that child.
- **Component Optimization:**
  - Wrap heavy pure components in `React.memo()` where prop comparison yields performance gains.
  - Avoid defining components inside other components.

# Client-Side Data Fetching

- **Strategy:**
  - Do **NOT** fetch data directly inside component render bodies.
  - Avoid "Fetch-on-render" (waterfalls).
- **Libraries:**
  - **Strongly Prefer** **TanStack Query (React Query)** or **SWR** for managing server state, caching, and background updates.
  - Use `axios` or standard `fetch` within these libraries' query functions.
- **useEffect Usage:**
  - Use `useEffect` strictly for synchronization (subscriptions, DOM manipulation).
  - If you must fetch in `useEffect` (rare/legacy), handle race conditions with cleanup flags or `AbortController`.

# State Management & Forms

- **Global vs. Local:**
  - Use `useState` or `useReducer` for local component state.
  - Use **Zustand** or **Redux Toolkit** for complex global client state.
  - Use **React Context** sparingly for low-velocity global data (themes, user preferences) to avoid render thrashing.
- **Forms:**
  - Do **NOT** use Server Actions.
  - Use **React Hook Form** for complex forms (validation, performant uncontrolled inputs).
  - For simple forms, standard controlled inputs with `onSubmit` handlers are acceptable.

# Routing (SPA)

- **Router:**
  - Assume usage of **React Router v6+** or **TanStack Router**.
- **Navigation:**
  - Use `<Link>` or `<NavLink>` for internal navigation to avoid full page reloads.
  - Use `useNavigate` for programmatic navigation.
- **Code Splitting:**
  - Use `React.lazy` and `<Suspense>` to lazy load route components (route-based splitting).

# TypeScript & Styling

- **Type Safety:**
  - Use `satisfies` for better type inference on configuration objects.
  - Define explicit types for Props (`interface MyProps { ... }`).
- **Styling:**
  - Use **Tailwind CSS** or **CSS Modules**.
  - Avoid runtime CSS-in-JS libraries (like styled-components) if performance is a top priority; prefer zero-runtime solutions or utility classes.

# Accessibility & Security

- **A11y:**
  - Ensure semantic HTML (`<button>` vs `<div>`).
  - Manage focus manually using `useRef` for modals or route transitions if not handled by a library.
- **Security:**
  - Sanitize data before rendering if using `dangerouslySetInnerHTML` (use DOMPurify).
  - Store sensitive tokens (JWT) in `HttpOnly` cookies (managed by backend) where possible, or memory—never `localStorage`.