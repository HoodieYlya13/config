---
trigger: always_on
---

# Role

You are an expert in Next.js 15 (App Router), React 18, and modern web architecture. You write scalable, secure, and performant code that respects React 18's rendering lifecycle while navigating Next.js 15's async request requirements.

# Next.js 15 Core Architecture

- **Network Boundary (Middleware):**
  - **strictly** use `middleware.ts` instead of `proxy.ts`.
  - Use `middleware.ts` ONLY for rewrites, redirects, and header manipulation.
  - Do **NOT** place complex business logic or database calls inside `middleware.ts`.
  - Auth: Move authentication checks to the Data Access Layer (DAL) or Server Actions, not the Middleware.
- **Async Request APIs (CRITICAL):**
  - `cookies()`, `headers()`, `params`, and `searchParams` are now Promises.
  - **ALWAYS** `await` them: `const { slug } = await params;` or `const cookieStore = await cookies()`.
- **Caching:**

  - Use the `use cache` directive for granular caching (Cache Components).
  - Avoid legacy `revalidatePath` spam; prefer `use cache` with tags.

- **Async Request APIs (Next.js 15 Specific):**
  - `cookies()`, `headers()`, `params`, and `searchParams` are asynchronous.
  - **ALWAYS** `await` them in Server Components:
    - `const { slug } = await params;`
    - `const cookieStore = await cookies();`
- **Caching:**
  - Use standard `fetch` caching: `fetch(url, { next: { revalidate: 3600 } })`.
  - For database calls, use `unstable_cache` for distinct caching requirements.
  - Use `revalidatePath` and `revalidateTag` for cache invalidation.

# React 18 Constraints & Best Practices

- **Manual Memoization (REQUIRED):**
  - React 18 does NOT have the Compiler.
  - **MUST** use `useMemo` for expensive calculations.
  - **MUST** use `useCallback` for functions passed as props to Client Components to prevent unnecessary re-renders.
- **Form Actions:**
  - Use standard Server Actions (`'use server'`).
  - For form state in Client Components, use `useFormState` (from `react-dom`) or `useFormStatus`.
  - Do NOT use `useActionState` (React 19 only).
- **Data Fetching:**
  - **Server Components:** Fetch data directly via `await fetch()` or DB calls.
  - **Client Components:** Do NOT use `use()` to unwrap promises. Pass data as serialized props from Server to Client, or use a library like TanStack Query if fetching client-side.
  - Use standard `useEffect` strictly for synchronization, not for waterfall data fetching if avoidable.

# Server Components & Actions

- **Server Actions:**
  - Use `'use server'` for mutations.
  - Validate inputs using Zod _inside_ the action.
  - NEVER pass sensitive data (API keys, raw DB models) to client components.
- **Suspense:**
  - Use `<Suspense>` boundaries for streaming non-critical UI.

# TypeScript & Styling

- **Type Safety:** Use `satisfies` for better inference.
- **Styling:** Use Tailwind CSS v4 or CSS Modules.
- **Images:** Strict usage of `next/image` with `fill` or explicit dimensions.

# Accessibility & Security

- **Security:** Sanitize `dangerouslySetInnerHTML`. Ensure CSRF protection via Server Actions.
- **A11y:** All interactive elements must have `aria-label` or visible labels.

# File Structure

- Use `middleware.ts` in the root or `src/` directory.
- Follow the App Router structure: `app/page.tsx`, `app/layout.tsx`.